import 'package:clean_bloc_wrap/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:clean_bloc_wrap/features/post/presentation/bloc/post_bloc.dart';
import 'package:clean_bloc_wrap/features/post/presentation/pages/comments.dart';
import 'package:clean_bloc_wrap/core/utils/colors.dart';
import 'package:clean_bloc_wrap/features/post/presentation/widgets/likeanimation.dart';
import 'package:clean_bloc_wrap/features/profile/presentation/pages/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider_base_tools/provider_base_tools.dart';

class PostCard extends StatefulWidget {
  final snap;
  const PostCard({super.key, required this.snap});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLikeAnimating = false;

  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthBloc bloc) {
      final state = bloc.state;
      if (state is AuthSuccess) return state.user;
      // return null;
    });

    return Container(
      color: primaryColor,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          //HEADER SECTION
          Container(
            padding: const EdgeInsets.symmetric(vertical: 6).copyWith(right: 0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 24,

                  backgroundImage: NetworkImage(widget.snap['profImage']),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              UserProfile(uid: widget.snap['uid']),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.snap['username'],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        child: ListView(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shrinkWrap: true,
                          children: ['Delete']
                              .map(
                                (e) => InkWell(
                                  onTap: () async {
                                    context.read<PostBloc>().add(
                                      PostDelete(widget.snap['postId']),
                                    );
                                    // widget.snap['postId'],

                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                      horizontal: 26,
                                    ),
                                    child: Text(e),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.more_vert),
                ),
              ],
            ),
          ),

          //IMAGE
          GestureDetector(
            onDoubleTap: () async {
              context.read<PostBloc>().add(
                PostLike(
                  widget.snap['postId'],
                  user!.uid,
                  widget.snap['likes'],
                ),
              );
              // await FirestoreMethods().likePost(
              //   widget.snap['postId'],
              //   user.uid,
              //   widget.snap['likes'],
              // );
              setState(() {
                isLikeAnimating = true;
                Future.delayed(Duration(seconds: 1), () {
                  setState(() {
                    isLikeAnimating = false;
                  });
                });
              });
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: double.infinity,
                  child: Image.network(
                    widget.snap['postUrl'],
                    fit: BoxFit.cover,
                  ),
                ),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: isLikeAnimating ? 1 : 0,
                  child: Likeanimation(
                    isAnimating: isLikeAnimating,
                    duration: const Duration(milliseconds: 400),
                    onEnd: () {
                      isLikeAnimating = false;
                    },
                    child: const Icon(
                      Icons.favorite,
                      color: primaryColor,
                      size: 120,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // LIKES COMMENTS
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Likeanimation(
                isAnimating: widget.snap['likes'].contains(user!.uid),
                child: IconButton(
                  onPressed: () {
                    context.read<PostBloc>().add(
                      PostLike(
                        widget.snap['postId'],
                        user.uid,
                        widget.snap['likes'],
                      ),
                    );
                  },
                  icon: widget.snap['likes'].contains(user.uid)
                      ? const Icon(Icons.favorite, color: Colors.red, size: 32)
                      : const Icon(Icons.favorite_border, size: 32),
                ),
              ),
              IconButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CommentScreen(snap: widget.snap),
                  ),
                ),
                icon: const Icon(Icons.mode_comment_outlined, size: 28),
              ),

              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.send_outlined, size: 28),
                  ),
                ),
              ),
            ],
          ),

          // DESCRIPPTION AND COMMENTS
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "${widget.snap['likes'].length}",
                  // style: Theme.of(context).textTheme.bodyMedium,
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 8),
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(color: blackColour),
                      children: [
                        TextSpan(
                          text: "${widget.snap['username']}: ",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: widget.snap['description'],
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: const Text(
                      'View all Comments',
                      style: TextStyle(fontSize: 14, color: secondaryColor),
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    DateFormat.yMMMd().format(
                      widget.snap['datePublished'].toDate(),
                    ),
                    style: const TextStyle(fontSize: 14, color: secondaryColor),
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
