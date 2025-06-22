part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthLoginRequested extends AuthEvent {
  final String email;
  final String pw;

  AuthLoginRequested({required this.email, required this.pw});
}

class AuthSignUpRequested extends AuthEvent {
  final String email;
  final String pw;
  final String userName;
  final String bio;
  final Uint8List file;

  AuthSignUpRequested({
    required this.email,
    required this.pw,
    required this.userName,
    required this.bio,
    required this.file,
  });
}

class AuthCurrentUserRequested extends AuthEvent {}

class AuthLogoutRequested extends AuthEvent {}
