import 'package:clean_bloc_wrap/features/auth/presentation/auth_injection.dart';
import 'package:clean_bloc_wrap/features/post/presentation/post_injection.dart';
import 'package:clean_bloc_wrap/features/profile/presentation/profile_injection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // final prefs = await SharedPreferences.getInstance();

  sl
    // ..registerLazySingleton(() => prefs)
    ..registerLazySingleton(() => FirebaseAuth.instance)
    ..registerLazySingleton(() => FirebaseFirestore.instance)
    ..registerLazySingleton(() => FirebaseStorage.instance);

  initAuth();
  initPost();
  initProfile();
}
