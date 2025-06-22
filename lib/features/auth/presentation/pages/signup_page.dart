import 'dart:typed_data';
import 'package:clean_bloc_wrap/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:clean_bloc_wrap/core/utils/colors.dart';
import 'package:clean_bloc_wrap/core/utils/utils.dart';
import 'package:clean_bloc_wrap/features/auth/presentation/pages/login_page.dart';
import 'package:clean_bloc_wrap/features/auth/presentation/widgets/textfield_inputs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  bool _isloading = false;
  Uint8List? _image;

  @override
  void dispose() {
    super.dispose();
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
  }

  void signUpUser() {
    context.read<AuthBloc>().add(
      AuthSignUpRequested(
        email: _emailController.text,
        pw: _passwordController.text,
        userName: _userNameController.text,
        bio: _bioController.text,
        file: _image!,
      ),
    );
  }

  selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(8),
            width: 500,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(flex: 2, child: Container()),

                //INSTAGRAM LOGO
                // SvgPicture(bytesLoader)
                SvgPicture.asset('assets/ic_instagram.svg'),
                const SizedBox(height: 12),
                Stack(
                  children: [
                    _image != null
                        ? CircleAvatar(
                            radius: 64,
                            backgroundImage: MemoryImage(_image!),
                          )
                        : const CircleAvatar(
                            radius: 64,
                            backgroundColor: Colors.red,
                          ),
                    Positioned(
                      bottom: -9,
                      left: 75,
                      child: IconButton(
                        onPressed: selectImage,
                        icon: const Icon(Icons.add_a_photo_outlined),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                //INPUT FOR EMAIL ADDRESS
                TextFieldInputs(
                  hintText: 'Email',
                  textEditingController: _emailController,
                  textInputKeyBoardType: TextInputType.emailAddress,
                ),

                const SizedBox(height: 24),
                //INPUT FOR  NAME
                TextFieldInputs(
                  hintText: 'UserName',
                  textEditingController: _userNameController,
                  textInputKeyBoardType: TextInputType.emailAddress,
                ),

                const SizedBox(height: 24),
                //INPUTS FOR PASSWORD
                TextFieldInputs(
                  hintText: 'Password',
                  isPass: true,
                  textEditingController: _passwordController,
                  textInputKeyBoardType: TextInputType.emailAddress,
                ),

                const SizedBox(height: 24),
                TextFieldInputs(
                  hintText: 'Add bio',
                  textEditingController: _bioController,
                  textInputKeyBoardType: TextInputType.emailAddress,
                ),

                const SizedBox(height: 12),
                InkWell(
                  onTap: signUpUser,
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    alignment: Alignment.center,
                    width: double.infinity,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      color: Colors.blue,
                    ),
                    child: BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        if (state is AuthLoading) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          );
                        }
                        return Text(
                          "SignUp",
                          style: TextStyle(color: Colors.white),
                        );
                      },
                    ),
                  ),
                ),
                Flexible(flex: 2, child: Container()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: const Text("Already have an account?"),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: const Text(
                          "Log in",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
