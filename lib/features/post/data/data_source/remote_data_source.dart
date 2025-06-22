import 'package:clean_bloc_wrap/features/post/data/data_source/storage_methods.dart';
import 'package:clean_bloc_wrap/features/post/data/models/post_models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

import 'package:uuid/uuid.dart';

abstract class PostRemoteDataSource extends Equatable {
  Future<String> uploadPost(
    String description,
    String uid,
    String username,
    String profImage,
    Uint8List file,
  );
  Future<void> likePost(String postId, String uid, List likes);
  Future<void> postComment(
    String postId,
    String text,
    String uid,
    String name,
    String profilepic,
  );
  Future<void> deletePost(String postid);
}

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;
  final FirebaseAuth _auth;

  PostRemoteDataSourceImpl(this._firestore, this._storage, this._auth);

  //UPLOAD POST

  @override
  Future<String> uploadPost(
    String description,
    String uid,
    String username,
    String profImage,
    Uint8List file,
  ) async {
    String res = 'Some error';

    try {
      String photoUrl = await StorageMethods(
        _storage,
        _auth,
      ).uploadImageToStorage('posts', file, true);
      String postId = const Uuid().v1();
      PostModel post = PostModel(
        description: description,
        uid: uid,
        username: username,
        postId: postId,
        postUrl: photoUrl,
        datePublished: DateTime.now(),
        profImage: profImage,
        likes: [],
      );
      _firestore.collection('posts').doc(postId).set(post.toJson());
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  @override
  Future<void> likePost(String postId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid]),
        });
      } else {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid]),
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Future<void> postComment(
    String postId,
    String text,
    String uid,
    String name,
    String profilepic,
  ) async {
    // final postId = post.postId;
    // final uid = post.uid;
    // final name = post.username;
    // final profilepic = post.profImage;
    try {
      if (text.isNotEmpty) {
        String commentId = const Uuid().v1();
        await _firestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .set({
              'profilepic': profilepic,
              'name': name,
              'uid': uid,
              'text': text,
              'commentId': commentId,
              'datePublished': DateTime.now(),
            });
      } else {
        print("text is empty");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  // DELETE POST METHOD

  @override
  Future<void> deletePost(String postId) async {
    try {
      await _firestore.collection('posts').doc(postId).delete();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  @override
  // TODO: implement stringify
  bool? get stringify => throw UnimplementedError();
}
