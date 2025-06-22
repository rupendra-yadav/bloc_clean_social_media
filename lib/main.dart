import 'package:clean_bloc_wrap/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:clean_bloc_wrap/features/post/presentation/bloc/post_bloc.dart';
import 'package:clean_bloc_wrap/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:clean_bloc_wrap/injection_container.dart';
import 'package:clean_bloc_wrap/core/navigation/mobilescreen_layout.dart';
import 'package:clean_bloc_wrap/features/auth/presentation/pages/login_page.dart';
import 'package:clean_bloc_wrap/core/utils/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<AuthBloc>()..add(AuthCurrentUserRequested()),
        ),
        BlocProvider(create: (context) => sl<PostBloc>()),
        BlocProvider(create: (context) => sl<ProfileBloc>()),
      ],
      child: MaterialApp(
        title: "Instagram",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.light(),
          scaffoldBackgroundColor: primaryColor,
          appBarTheme: AppBarTheme(backgroundColor: Colors.white),
        ),

        home: Scaffold(
          body: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthSuccess) {
                return MobileScreenLayout();
              } else if (state is AuthInitial) {
                return LoginPage();
              } else {
                return LoginPage();
              }
            },
          ),
        ),
      ),
    );
  }
}
