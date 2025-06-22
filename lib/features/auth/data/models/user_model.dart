import 'package:clean_bloc_wrap/features/auth/domain/entities/user_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.email,
    required super.username,
    required super.uid,
    required super.bio,
    required super.photoUrl,
  });
  Map<String, dynamic> toJson() => {
    'username': username,
    'email': email,
    'uid': uid,
    'bio': bio,
    'photoUrl': photoUrl,
  };

  static UserModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserModel(
      username: snapshot['username'],
      email: snapshot['email'],
      uid: snapshot['uid'],
      bio: snapshot['bio'],
      photoUrl: snapshot['photoUrl'],
    );
  }
}
