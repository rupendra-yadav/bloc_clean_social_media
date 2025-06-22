import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  final String username;
  final String bio;
  final String photoUrl;

  final List followers;
  final List following;

  const ProfileEntity({
    required this.username,

    required this.bio,
    required this.photoUrl,
    required this.followers,
    required this.following,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [username, bio, photoUrl, followers, following];
}
