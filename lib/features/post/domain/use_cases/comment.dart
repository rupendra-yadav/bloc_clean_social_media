import 'package:clean_bloc_wrap/core/error/app_failures.dart';
import 'package:clean_bloc_wrap/core/usecases/usecase.dart';
import 'package:clean_bloc_wrap/features/post/domain/entities/post_entity.dart';
import 'package:clean_bloc_wrap/features/post/domain/repository/post_repository.dart';
import 'package:dartz/dartz.dart';

class CommentUseCase extends UseCase<void, CommentUseCaseParams> {
  final PostRepository postRepository;

  CommentUseCase(this.postRepository);
  @override
  Future<Either<Failure, void>> call(CommentUseCaseParams params) {
    return postRepository.postComment(
      params.postId,
      params.text,
      params.uid,
      params.name,
      params.profilepic,
    );
  }
}

class CommentUseCaseParams {
  final String postId;
  final String text;
  final String uid;
  final String name;
  final String profilepic;

  CommentUseCaseParams({
    required this.uid,
    required this.name,
    required this.profilepic,
    required this.postId,
    required this.text,
  });
}
