import 'dart:developer';

import 'package:clean_bloc_wrap/core/error/app_exceptions.dart';
import 'package:clean_bloc_wrap/core/error/app_failures.dart';
import 'package:clean_bloc_wrap/features/profile/data/data_source/remote_data_source.dart';
import 'package:clean_bloc_wrap/features/profile/domain/entity/profile_entity.dart';
import 'package:clean_bloc_wrap/features/profile/domain/repository/profile_repository.dart';
import 'package:dartz/dartz.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource profileRemoteDataSource;

  ProfileRepositoryImpl(this.profileRemoteDataSource);
  @override
  Future<Either<Failure, void>> followToggle(
    String currentUserId,
    String targetUserId,
  ) async {
    try {
      await profileRemoteDataSource.followToggle(currentUserId, targetUserId);
      return Right('');
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message, statusCode: e.statusCode));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message, statusCode: 500));
    } catch (e) {
      log("Repository Unexpected Error getting news: $e");
      return Left(UnexpectedFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  @override
  // TODO: implement stringify
  bool? get stringify => throw UnimplementedError();

  @override
  Future<Either<Failure, ProfileEntity>> getData(String uid) async {
    try {
      final ProfileEntity user = await profileRemoteDataSource.getData(uid);
      return Right(user);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message, statusCode: e.statusCode));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message, statusCode: 500));
    } catch (e) {
      log("Repository Unexpected Error getting user: $e");
      return Left(UnexpectedFailure(message: e.toString(), statusCode: 500));
    }
  }
}
