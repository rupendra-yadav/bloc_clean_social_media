import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String email;
  final String username;
  final String uid;
  final String bio;
  final String photoUrl;

  const UserEntity({
    required this.email,
    required this.username,
    required this.uid,
    required this.bio,
    required this.photoUrl,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [email, username, uid, bio, photoUrl];
}
