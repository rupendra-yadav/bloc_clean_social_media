import 'dart:developer';
import 'dart:typed_data';

import 'package:clean_bloc_wrap/core/error/app_exceptions.dart';
import 'package:clean_bloc_wrap/core/error/app_failures.dart';
import 'package:clean_bloc_wrap/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:clean_bloc_wrap/features/auth/domain/entities/user_entity.dart';
import 'package:clean_bloc_wrap/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;

  AuthRepositoryImpl(this._authRemoteDataSource);
  @override
  Future<Either<Failure, UserEntity>> getUserDetails() async {
    try {
      final UserEntity currentUser = await _authRemoteDataSource
          .getUserDetails();
      return Right(currentUser);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message, statusCode: e.statusCode));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message, statusCode: 500));
    } catch (e) {
      log("Repository Unexpected Error Getting Current user: $e");
      return Left(UnexpectedFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> loginUser(String email, String pw) async {
    try {
      final UserEntity currentUser = await _authRemoteDataSource.loginUsers(
        email: email,
        password: pw,
      );
      return Right(currentUser);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message, statusCode: e.statusCode));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message, statusCode: 500));
    } catch (e) {
      log("Repository Unexpected Error logging User: $e");
      return Left(UnexpectedFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  List<Object?> get props => throw UnimplementedError();

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await _authRemoteDataSource.SignOut();
      return Right("_");
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signUpUser(
    String email,
    String pw,
    String userName,
    String bio,
    Uint8List file,
  ) async {
    try {
      final UserEntity currentUser = await _authRemoteDataSource.signUpUser(
        email: email,
        username: userName,
        password: pw,
        bio: bio,
        file: file,
      );
      return Right(currentUser);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message, statusCode: e.statusCode));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message, statusCode: 500));
    } catch (e) {
      log("Repository Unexpected Error Signing user: $e");
      return Left(UnexpectedFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  // TODO: implement stringify
  bool? get stringify => true;
}
