import 'package:clean_bloc_wrap/core/error/app_failures.dart';
import 'package:clean_bloc_wrap/core/usecases/usecase.dart';
import 'package:clean_bloc_wrap/features/profile/domain/entity/profile_entity.dart';
import 'package:clean_bloc_wrap/features/profile/domain/repository/profile_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetDataUseCase implements UseCase<ProfileEntity, GetDataParams> {
  final ProfileRepository profileRepository;

  GetDataUseCase(this.profileRepository);
  @override
  Future<Either<Failure, ProfileEntity>> call(GetDataParams params) {
    return profileRepository.getData(params.uid);
  }
}

class GetDataParams extends Equatable {
  final String uid;

  GetDataParams(this.uid);

  @override
  // TODO: implement props
  List<Object?> get props => [uid];
}
