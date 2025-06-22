import 'dart:typed_data';

import 'package:clean_bloc_wrap/features/auth/data/models/user_model.dart';
import 'package:clean_bloc_wrap/features/auth/domain/entities/user_entity.dart';
import 'package:clean_bloc_wrap/features/post/data/data_source/storage_methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart' as model;
import 'package:firebase_storage/firebase_storage.dart';

class AuthRemoteDataSource {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;

  AuthRemoteDataSource({
    required FirebaseAuth auth,
    required FirebaseFirestore firestore,
    required FirebaseStorage storage,
  }) : _auth = auth,
       _firestore = firestore,
       _storage = storage;

  Future<UserEntity> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap = await _firestore
        .collection('users')
        .doc(currentUser.uid)
        .get();

    return UserModel.fromSnap(snap);
  }

  Future<UserEntity> signUpUser({
    required String email,
    required String username,
    required String password,
    required String bio,
    required Uint8List file,
  }) async {
    // final res = 'An error has occured';
    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String photoUrl = await StorageMethods(
        _storage,
        _auth,
      ).uploadImageToStorage('profilePics', file, false);

      UserModel user = UserModel(
        username: username,
        uid: cred.user!.uid,
        photoUrl: photoUrl,
        email: email,
        bio: bio,
      );

      await _firestore
          .collection('users')
          .doc(cred.user!.uid)
          .set(user.toJson());

      return user;
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future<UserEntity> loginUsers({
    required String email,
    required String password,
  }) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        UserCredential cred = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Fetch additional user data from Firestore or your database if needed
        DocumentSnapshot userDoc = await _firestore
            .collection('users')
            .doc(cred.user!.uid)
            .get();

        if (userDoc.exists) {
          UserModel user = UserModel.fromSnap(userDoc);
          return user;
        } else {
          throw Exception("User data not found in database");
        }
      } else {
        throw Exception("Please enter all details");
      }
    } catch (err) {
      print("Login Error: $err");
      // return null;
      throw Exception(err.toString());
    }
  }

  Future<void> SignOut() async {
    await _auth.signOut();
  }
}
