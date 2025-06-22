import 'package:clean_bloc_wrap/core/error/app_failures.dart';
import 'package:clean_bloc_wrap/core/usecases/usecase.dart';
import 'package:clean_bloc_wrap/features/profile/domain/repository/profile_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class FollowToggleUseCase implements UseCase<void, FollowToggleParams> {
  final ProfileRepository profileRepository;

  FollowToggleUseCase(this.profileRepository);
  @override
  Future<Either<Failure, void>> call(FollowToggleParams params) {
    return profileRepository.followToggle(params.currentId, params.targetId);
  }
}

class FollowToggleParams extends Equatable {
  final String currentId;
  final String targetId;

  FollowToggleParams(this.currentId, this.targetId);

  @override
  // TODO: implement props
  List<Object?> get props => [currentId, targetId];
}
