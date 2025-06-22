import 'dart:developer';
import 'dart:typed_data';

import 'package:clean_bloc_wrap/core/error/app_exceptions.dart';
import 'package:clean_bloc_wrap/core/error/app_failures.dart';
import 'package:clean_bloc_wrap/features/post/data/data_source/remote_data_source.dart';
import 'package:clean_bloc_wrap/features/post/domain/repository/post_repository.dart';
import 'package:dartz/dartz.dart';

class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource _postRemoteDataSource;

  PostRepositoryImpl(this._postRemoteDataSource);

  @override
  Future<Either<Failure, void>> deletePost(String postid) async {
    try {
      await _postRemoteDataSource.deletePost(postid);
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString(), statusCode: 500));
    }
    throw ("deleted");
  }

  @override
  Future<Either<Failure, void>> likePost(
    String postId,
    String uid,
    List likes,
  ) async {
    try {
      await _postRemoteDataSource.likePost(postId, uid, likes);
      return Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message, statusCode: e.statusCode));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message, statusCode: 500));
    } catch (e) {
      log("Repository Unexpected Error Uploading post: $e");
      return Left(UnexpectedFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, void>> postComment(
    String postId,
    String text,
    String uid,
    String name,
    String profilepic,
  ) async {
    try {
      await _postRemoteDataSource.postComment(
        postId,
        text,
        uid,
        name,
        profilepic,
      );
      return Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message, statusCode: e.statusCode));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message, statusCode: 500));
    } catch (e) {
      log("Repository Unexpected Error Uploading post: $e");
      return Left(UnexpectedFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, String>> uploadPost(
    String description,
    String uid,
    String username,
    String profImage,
    Uint8List file,
  ) async {
    try {
      final String result = await _postRemoteDataSource.uploadPost(
        description,
        uid,
        username,
        profImage,
        file,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message, statusCode: e.statusCode));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message, statusCode: 500));
    } catch (e) {
      log("Repository Unexpected Error Uploading post: $e");
      return Left(UnexpectedFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  @override
  // TODO: implement stringify
  bool? get stringify => throw UnimplementedError();
}
