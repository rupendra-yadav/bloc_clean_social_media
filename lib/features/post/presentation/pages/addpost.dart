import 'package:clean_bloc_wrap/features/auth/domain/entities/user_entity.dart';
import 'package:clean_bloc_wrap/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:clean_bloc_wrap/features/post/presentation/bloc/post_bloc.dart';
import 'package:clean_bloc_wrap/core/utils/colors.dart';
import 'package:clean_bloc_wrap/core/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostState();
}

class _AddPostState extends State<AddPostScreen> {
  Uint8List? _file;
  final TextEditingController _descriptionController = TextEditingController();
  bool _isloading = false;

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
  }

  void postImage(String uid, String username, String profImage) async {
    context.read<PostBloc>().add(
      PostUpload(_file!, _descriptionController.text, uid, username, profImage),
    );
  }

  _selectImage(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text("Create a post"),
          children: [
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("Select form gallery"),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List file = await pickImage(ImageSource.gallery);
                setState(() {
                  _file = file;
                });
              },
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("Take a picture"),
              onPressed: () async {
                Navigator.pop(context);
                Uint8List file = await pickImage(ImageSource.camera);
                setState(() {
                  _file = file;
                });
              },
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("DISCARD"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void clearImage() {
    setState(() {
      _file = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    late final UserEntity user;

    return _file == null
        ? Center(
            child: TextButton(
              onPressed: () => _selectImage(context),
              child: const Text(
                "Create a post",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        : BlocListener<PostBloc, PostState>(
            listener: (context, state) {
              if (state is PostSuccess) {
                setState(() {
                  _file = null;
                  _isloading = false;
                });
              }
              if (state is PostLoading) {
                setState(() {
                  _isloading = true;
                });
              }
            },
            child: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthSuccess) {
                  user = state.user;
                }
                return Scaffold(
                  appBar: AppBar(
                    backgroundColor: primaryColor,
                    leading: IconButton(
                      onPressed: clearImage,
                      icon: const Icon(Icons.arrow_back),
                    ),
                    title: const Text("Post up"),
                    actions: [
                      TextButton(
                        onPressed: () =>
                            postImage(user.uid, user.username, user.photoUrl),
                        child: const Text(
                          "Post",
                          style: TextStyle(
                            color: blueColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  body: Column(
                    children: [
                      _isloading
                          ? const LinearProgressIndicator()
                          : const Padding(padding: EdgeInsets.only(top: 0)),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(user.photoUrl),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: TextField(
                              controller: _descriptionController,
                              decoration: InputDecoration(
                                hintText: 'Write a caption..',
                                border: InputBorder.none,
                              ),
                              maxLines: 8,
                            ),
                          ),
                          SizedBox(
                            height: 45,
                            width: 45,
                            child: AspectRatio(
                              aspectRatio: 487 / 451,
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    alignment: FractionalOffset.topCenter,
                                    image: MemoryImage(_file!),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Divider(),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          );
  }
}
