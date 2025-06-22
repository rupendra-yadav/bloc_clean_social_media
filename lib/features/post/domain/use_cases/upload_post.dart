import 'dart:typed_data';

import 'package:clean_bloc_wrap/core/error/app_failures.dart';
import 'package:clean_bloc_wrap/core/usecases/usecase.dart';
import 'package:clean_bloc_wrap/features/post/domain/repository/post_repository.dart';
import 'package:dartz/dartz.dart';

class UploadPostUseCase extends UseCase<String, UploadPostUseCaseParams> {
  final PostRepository postRepository;

  UploadPostUseCase(this.postRepository);
  @override
  Future<Either<Failure, String>> call(UploadPostUseCaseParams params) {
    return postRepository.uploadPost(
      params.description,
      params.uid,
      params.username,
      params.profImage,
      params.file,
    );
  }
}

class UploadPostUseCaseParams {
  final String description;
  final String uid;
  final String username;
  final String profImage;
  Uint8List file;

  UploadPostUseCaseParams({
    required this.description,
    required this.uid,
    required this.username,
    required this.profImage,
    required this.file,
  });
}
