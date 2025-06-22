import 'package:clean_bloc_wrap/core/utils/colors.dart';
import 'package:clean_bloc_wrap/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:clean_bloc_wrap/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:clean_bloc_wrap/features/profile/presentation/widgets/followbutton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider_base_tools/provider_base_tools.dart';

class UserProfile extends StatefulWidget {
  final uid;
  const UserProfile({super.key, required this.uid});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  int post = 0;
  late String currrentUser;

  late bool isOwnPost;

  @override
  void initState() {
    super.initState();
    final state = context.read<AuthBloc>().state;
    if (state is AuthSuccess) {
      currrentUser = state.user.uid;
      isOwnPost = widget.uid == currrentUser;
      context.read<ProfileBloc>().add(ProfileGetData(widget.uid));
    }
  }

  void followtoggle(String currentId) {
    final profileState = context.read<ProfileBloc>().state;
    if (profileState is! ProfileLoaded) {
      return;
    }
    final profileUser = profileState.user;
    final isFollowing = profileUser.followers.contains(currentId);
    setState(() {
      if (isFollowing) {
        profileUser.followers.remove(currrentUser);
      } else {
        profileUser.followers.add(currrentUser);
      }
    });
    context.read<ProfileBloc>().add(ProfileFollowToggle(currentId, widget.uid));
  }

  void SignOut() {
    context.read<AuthBloc>().add(AuthLogoutRequested());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoaded) {
          final userData = state.user;
          final bool isFollowing = userData.followers.contains(currrentUser);

          return Scaffold(
            appBar: AppBar(
              title: Text(
                userData.username,
                style: const TextStyle(color: blackColour),
              ),
              centerTitle: false,
              backgroundColor: primaryColor,
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.menu, color: blackColour, size: 20),
                ),
              ],
            ),
            body: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 16,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 42,
                            backgroundImage: NetworkImage(userData.photoUrl),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                buildStatColumn('$post', "posts"),
                                buildStatColumn(
                                  "${userData.followers.length}",
                                  "follower",
                                ),
                                buildStatColumn(
                                  "${userData.following.length}",
                                  "following",
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.all(22),
                        child: Column(
                          children: [
                            Text(
                              userData.bio,
                              style: TextStyle(color: blackColour),
                            ),
                          ],
                        ),
                      ),
                      FollowButton(
                        isFollowButton: isOwnPost ? false : true,
                        isFollowing: isFollowing,
                        function: isOwnPost
                            ? SignOut
                            : () => followtoggle(currrentUser),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('posts')
                      .where('uid', isEqualTo: widget.uid)
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    return GridView.builder(
                      shrinkWrap: true,
                      itemCount: (snapshot.data! as dynamic).docs.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                            childAspectRatio: 1,
                          ),
                      itemBuilder: (context, index) {
                        DocumentSnapshot snap =
                            (snapshot.data! as dynamic).docs[index];
                        return Container(
                          child: Image(
                            image: NetworkImage(snap['postUrl']),
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

Column buildStatColumn(String num, String label) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        num.toString(),
        style: TextStyle(
          color: blackColour,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      Text(
        label,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Colors.grey,
        ),
      ),
    ],
  );
}
