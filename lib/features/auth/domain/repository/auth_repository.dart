import 'dart:typed_data';

import 'package:clean_bloc_wrap/core/error/app_failures.dart';
import 'package:clean_bloc_wrap/features/auth/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

abstract class AuthRepository extends Equatable {
  Future<Either<Failure, UserEntity>> getUserDetails();
  Future<Either<Failure, UserEntity>> signUpUser(
    String email,
    String pw,
    String userName,
    String bio,
    Uint8List file,
  );
  Future<Either<Failure, UserEntity>> loginUser(String email, String pw);
  Future<Either<Failure, void>> signOut();
}
