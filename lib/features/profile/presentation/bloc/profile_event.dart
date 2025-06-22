part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

final class ProfileFollowToggle extends ProfileEvent {
  final String currentId;
  final String targetId;

  ProfileFollowToggle(this.currentId, this.targetId);
}

final class ProfileGetData extends ProfileEvent {
  final String uid;

  ProfileGetData(this.uid);
}
