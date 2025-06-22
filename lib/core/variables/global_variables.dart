import 'package:clean_bloc_wrap/features/post/presentation/pages/addpost.dart';
import 'package:clean_bloc_wrap/features/search/presentation/pages/feedScreen.dart';
import 'package:clean_bloc_wrap/features/chat/messages.dart';
import 'package:clean_bloc_wrap/features/search/presentation/pages/search_tab.dart';
import 'package:clean_bloc_wrap/features/profile/presentation/pages/user_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

const webScreenSize = 500;

List<Widget> homeScreenItems = [
  const FeedScreen(),
  const SearchTab(),
  const AddPostScreen(),
  const Messages(),
  UserProfile(uid: FirebaseAuth.instance.currentUser!.uid),
];
