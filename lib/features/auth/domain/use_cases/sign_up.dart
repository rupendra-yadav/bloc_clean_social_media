import 'dart:typed_data';

import 'package:clean_bloc_wrap/core/error/app_failures.dart';
import 'package:clean_bloc_wrap/core/usecases/usecase.dart';
import 'package:clean_bloc_wrap/features/auth/domain/entities/user_entity.dart';
import 'package:clean_bloc_wrap/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class SignUpUsecase implements UseCase<UserEntity, SignUpUsecaseParams> {
  final AuthRepository authRepository;

  SignUpUsecase(this.authRepository);
  @override
  Future<Either<Failure, UserEntity>> call(SignUpUsecaseParams params) {
    return authRepository.signUpUser(
      params.email,
      params.pw,
      params.userName,
      params.bio,
      params.file,
    );
  }
}

class SignUpUsecaseParams extends Equatable {
  final String email;
  final String pw;
  final String userName;
  final String bio;
  final Uint8List file;

  SignUpUsecaseParams({
    required this.email,
    required this.pw,
    required this.userName,
    required this.bio,
    required this.file,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [email, pw, userName, bio, file];
}
