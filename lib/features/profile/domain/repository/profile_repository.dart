import 'package:clean_bloc_wrap/core/error/app_failures.dart';
import 'package:clean_bloc_wrap/features/profile/domain/entity/profile_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

abstract class ProfileRepository extends Equatable {
  Future<Either<Failure, void>> followToggle(
    String currentUserId,
    String targetUserId,
  );
  Future<Either<Failure, ProfileEntity>> getData(String uid);
}
