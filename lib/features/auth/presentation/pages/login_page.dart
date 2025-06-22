import 'package:clean_bloc_wrap/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:clean_bloc_wrap/features/auth/presentation/pages/signup_page.dart';
import 'package:clean_bloc_wrap/core/utils/colors.dart';
import 'package:clean_bloc_wrap/core/variables/global_variables.dart';
import 'package:clean_bloc_wrap/features/auth/presentation/widgets/textfield_inputs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

// import 'package:instagram/resources/auth_methods.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  bool _isloading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passController.dispose();
  }

  void loginUsers() async {
    final email = _emailController.text.trim();
    final pw = _passController.text.trim();
    if (email.isNotEmpty && pw.isNotEmpty) {
      context.read<AuthBloc>().add(AuthLoginRequested(email: email, pw: pw));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        child: Center(
          child: Container(
            padding: MediaQuery.of(context).size.width > webScreenSize
                ? EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 3,
                  )
                : const EdgeInsets.all(10.0),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  flex: 2,
                  child: Container(), //FOR BETTER ALIGNMENT OF WIDGETS
                ),

                //INSTAGRAM LOGO (SVG FORMAT)
                SvgPicture.asset('assets/ic_instagram.svg', color: blackColour),

                const SizedBox(height: 24),
                //TEXTFIELD FOR USENAME INPUT
                TextFieldInputs(
                  hintText: "Username",
                  textEditingController: _emailController,
                  textInputKeyBoardType: TextInputType.emailAddress,
                  isPass: false,
                ),
                const SizedBox(height: 24),

                //TEXTFIELD INPUT FOR PASSWORD
                TextFieldInputs(
                  hintText: "Password",
                  textEditingController: _passController,
                  textInputKeyBoardType: TextInputType.text,
                  isPass: true,
                ),
                const SizedBox(height: 24),

                InkWell(
                  onTap: loginUsers,
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                      color: Colors.blue,
                    ),
                    child:
                        // _isloading
                        //     ? const
                        BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                            if (state is AuthLoading) {
                              return Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              );
                            }
                            return Text(
                              "Login",
                              style: TextStyle(color: Colors.white),
                            );
                          },
                        ),
                  ),
                ),

                Flexible(flex: 2, child: Container()),
                const SizedBox(height: 12),

                //
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: const Text(
                        "Don't have an account?",
                        style: TextStyle(color: blackColour),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignupPage(),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: const Text(
                          "Sign up",
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
