import 'package:clean_bloc_wrap/core/error/app_failures.dart';
import 'package:clean_bloc_wrap/core/usecases/usecase.dart';
import 'package:clean_bloc_wrap/features/post/domain/repository/post_repository.dart';
import 'package:dartz/dartz.dart';

class DeletePostUseCase extends UseCase<void, DeletePostUseCaseParams> {
  final PostRepository postRepository;

  DeletePostUseCase(this.postRepository);
  @override
  Future<Either<Failure, void>> call(DeletePostUseCaseParams params) {
    return postRepository.deletePost(params.postid);
  }
}

class DeletePostUseCaseParams {
  final String postid;

  DeletePostUseCaseParams({required this.postid});
}
