import 'package:clean_bloc_wrap/features/profile/domain/entity/profile_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileModel extends ProfileEntity {
  ProfileModel({
    required super.username,
    required super.bio,
    required super.photoUrl,
    required super.followers,
    required super.following,
  });
  Map<String, dynamic> toJson() => {
    'username': username,
    'bio': bio,
    'photoUrl': photoUrl,
    'followers': followers,
    'following': following,
  };

  static ProfileModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return ProfileModel(
      username: snapshot['username'],
      bio: snapshot['bio'],
      photoUrl: snapshot['photoUrl'],
      followers: snapshot['followers'] ?? [],
      following: snapshot['following'] ?? [],
    );
  }
}
