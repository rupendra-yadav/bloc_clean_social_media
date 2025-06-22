import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class PostEntity extends Equatable {
  final String description;
  final String uid;
  final String username;
  final String postId;
  final datePublished;
  final String postUrl;
  final String profImage;
  final likes;

  const PostEntity({
    required this.description,
    required this.uid,
    required this.username,
    required this.postId,
    required this.postUrl,
    required this.datePublished,
    required this.profImage,
    required this.likes,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    description,
    uid,
    username,
    postId,
    datePublished,
    postUrl,
    profImage,
    likes,
  ];
}
