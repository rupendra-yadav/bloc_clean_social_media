import 'package:clean_bloc_wrap/features/profile/data/model/profile_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ProfileRemoteDataSource extends Equatable {
  final FirebaseFirestore firebaseFirestore;

  ProfileRemoteDataSource(this.firebaseFirestore);
  Future<void> followToggle(String currentId, String targetId) async {
    final currentUserDoc = await firebaseFirestore
        .collection('users')
        .doc(currentId)
        .get();
    final targetUserDoc = await firebaseFirestore
        .collection('users')
        .doc(targetId)
        .get();
    if (currentUserDoc.exists && targetUserDoc.exists) {
      final currentuser = currentUserDoc.data();
      final targetuser = targetUserDoc.data();
      if (currentuser != null && targetuser != null) {
        //unfollow
        List<String> currentfollowing = List<String>.from(
          currentuser['following'] ?? [],
        );
        if (currentfollowing.contains(targetId)) {
          await firebaseFirestore.collection('users').doc(currentId).update({
            'following': FieldValue.arrayRemove([targetId]),
          });
          await firebaseFirestore.collection('users').doc(targetId).update({
            'followers': FieldValue.arrayRemove([currentId]),
          });
        } else {
          await firebaseFirestore.collection('users').doc(currentId).update({
            'following': FieldValue.arrayUnion([targetId]),
          });
          await firebaseFirestore.collection('users').doc(targetId).update({
            'followers': FieldValue.arrayUnion([currentId]),
          });
        }
      }
    }
  }

  Future<ProfileModel> getData(String uid) async {
    var snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get();

    ProfileModel data = ProfileModel.fromSnap(snap);
    return data;
  }

  @override
  List<Object?> get props => throw UnimplementedError();
}
