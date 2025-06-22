import 'package:clean_bloc_wrap/core/error/app_failures.dart';
import 'package:clean_bloc_wrap/core/usecases/usecase.dart';
import 'package:clean_bloc_wrap/features/post/domain/repository/post_repository.dart';
import 'package:dartz/dartz.dart';

class LikePostUseCase extends UseCase<void, LikePostUseCaseParams> {
  final PostRepository postRepository;

  LikePostUseCase(this.postRepository);
  @override
  Future<Either<Failure, void>> call(LikePostUseCaseParams params) {
    return postRepository.likePost(params.postid, params.uid, params.likes);
  }
}

class LikePostUseCaseParams {
  final String postid;
  final String uid;
  final List likes;

  LikePostUseCaseParams({
    required this.postid,
    required this.uid,
    required this.likes,
  });
}
