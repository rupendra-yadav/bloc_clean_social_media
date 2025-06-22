import 'package:clean_bloc_wrap/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:clean_bloc_wrap/features/post/presentation/bloc/post_bloc.dart';
import 'package:clean_bloc_wrap/core/utils/colors.dart';
import 'package:clean_bloc_wrap/features/post/presentation/widgets/comment_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentScreen extends StatefulWidget {
  final snap;
  const CommentScreen({super.key, required this.snap});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _commentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text("Comments"),
        centerTitle: false,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .doc(widget.snap['postId'])
            .collection('comments')
            .snapshots(),
        builder:
            (
              context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
            ) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) =>
                    CommentsCard(snap: snapshot.data!.docs[index].data()),
              );
            },
      ),

      //COMMENT WRITING SECTION
      bottomNavigationBar: SafeArea(
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthSuccess) {
              final user = state.user;
              return Container(
                decoration: BoxDecoration(
                  border: BoxBorder.all(),
                  borderRadius: BorderRadius.circular(10),
                ),
                height: kToolbarHeight,
                margin: EdgeInsets.only(
                  left: 4,
                  right: 4,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 4,
                ),
                padding: const EdgeInsets.only(left: 16, right: 8),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(user.photoUrl),
                      radius: 18,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 8),
                        child: TextField(
                          controller: _commentController,
                          decoration: InputDecoration(
                            hintText: "comment as ${user.username}",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        context.read<PostBloc>().add(
                          PostComment(
                            widget.snap['postId'],
                            _commentController.text,
                            user.uid,
                            user.username,
                            user.photoUrl,
                          ),
                        );

                        setState(() {
                          _commentController.text = "";
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 8,
                        ),
                        child: const Text(
                          "Post",
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
