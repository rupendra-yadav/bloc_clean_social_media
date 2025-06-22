import 'package:clean_bloc_wrap/core/error/app_failures.dart';
import 'package:clean_bloc_wrap/core/usecases/usecase.dart';
import 'package:clean_bloc_wrap/features/auth/domain/entities/user_entity.dart';
import 'package:clean_bloc_wrap/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

class GetUser implements UseCase<UserEntity, NoParams> {
  final AuthRepository authRepository;

  GetUser(this.authRepository);
  @override
  Future<Either<Failure, UserEntity>> call(params) async {
    return await authRepository.getUserDetails();
  }
}
