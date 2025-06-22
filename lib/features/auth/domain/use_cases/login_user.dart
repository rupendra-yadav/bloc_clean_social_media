import 'package:clean_bloc_wrap/core/error/app_failures.dart';
import 'package:clean_bloc_wrap/core/usecases/usecase.dart';
import 'package:clean_bloc_wrap/features/auth/domain/entities/user_entity.dart';
import 'package:clean_bloc_wrap/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class LoginUseCase implements UseCase<UserEntity, LoginUseCaseParams> {
  final AuthRepository authRepository;

  LoginUseCase(this.authRepository);
  @override
  Future<Either<Failure, UserEntity>> call(LoginUseCaseParams params) async {
    // Basic input validation before calling the repository.
    if (params.email.trim().isEmpty) {
      return Left(
        UnexpectedFailure(message: "Email is not valid", statusCode: 0),
      );
    }
    if (params.pw.length < 6) {
      return Left(
        UnexpectedFailure(
          message: "password must be Greater than 6",
          statusCode: 0,
        ),
      );
    }
    return await authRepository.loginUser(params.email, params.pw);
  }
}

/// Parameters required for the LoginUsecase use case.
class LoginUseCaseParams extends Equatable {
  final String email;
  final String pw;

  const LoginUseCaseParams({required this.email, required this.pw});

  @override
  List<Object?> get props => [email, pw];
}
