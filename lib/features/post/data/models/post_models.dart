import 'package:clean_bloc_wrap/features/post/domain/entities/post_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel extends PostEntity {
  PostModel({
    required super.description,
    required super.uid,
    required super.username,
    required super.postId,
    required super.postUrl,
    required super.datePublished,
    required super.profImage,
    required super.likes,
  });

  Map<String, dynamic> toJson() => {
    'description': description,
    'uid': uid,
    'username': username,
    'postId': postId,
    'postUrl': postUrl,
    'datePublished': datePublished,
    'profImage': profImage,
    'likes': likes,
  };

  static PostModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return PostModel(
      description: snapshot['description'],
      uid: snapshot['uid'],
      username: snapshot['username'],
      postId: snapshot['postId'],
      postUrl: snapshot['postUrl'],
      datePublished: snapshot['datePublished'],
      profImage: snapshot['profImage'],
      likes: snapshot['likes'],
    );
  }
}
