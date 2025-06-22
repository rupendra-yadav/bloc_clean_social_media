import 'dart:typed_data';
import 'package:clean_bloc_wrap/core/error/app_failures.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

abstract class PostRepository extends Equatable {
  Future<Either<Failure, String>> uploadPost(
    String description,
    String uid,
    String username,
    String profImage,
    Uint8List file,
  );
  Future<Either<Failure, void>> likePost(String postId, String uid, List likes);
  Future<Either<Failure, void>> postComment(
    String postId,
    String text,
    String uid,
    String name,
    String profilepic,
  );
  Future<Either<Failure, void>> deletePost(String postid);

  @override
  List<Object?> get props => throw UnimplementedError();
}
