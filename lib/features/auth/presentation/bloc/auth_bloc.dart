import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:clean_bloc_wrap/core/usecases/usecase.dart';
import 'package:clean_bloc_wrap/features/auth/domain/entities/user_entity.dart';
import 'package:clean_bloc_wrap/features/auth/domain/use_cases/get_user.dart';
import 'package:clean_bloc_wrap/features/auth/domain/use_cases/login_user.dart';
import 'package:clean_bloc_wrap/features/auth/domain/use_cases/logout.dart';
import 'package:clean_bloc_wrap/features/auth/domain/use_cases/sign_up.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final SignUpUsecase signUpUseCase;
  final GetUser getUserUseCase;
  final LogOut logoutUseCase;

  AuthBloc({
    required this.loginUseCase,
    required this.signUpUseCase,
    required this.getUserUseCase,
    required this.logoutUseCase,
  }) : super(AuthInitial()) {
    on<AuthLoginRequested>(_onlogin);
    on<AuthSignUpRequested>(_onsignup);
    on<AuthCurrentUserRequested>(_ongetuser);
    on<AuthLogoutRequested>(_onlogout);
  }

  Future<void> _onlogin(AuthLoginRequested event, Emitter emit) async {
    final email = event.email;
    final pw = event.pw;
    emit(AuthLoading());
    final result = await loginUseCase(LoginUseCaseParams(email: email, pw: pw));
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(AuthSuccess(user)),
    );
  }

  Future<void> _onsignup(AuthSignUpRequested event, Emitter emit) async {
    final email = event.email;
    final pw = event.pw;
    final username = event.userName;
    final bio = event.bio;
    final file = event.file;
    emit(AuthLoading());
    final result = await signUpUseCase(
      SignUpUsecaseParams(
        email: email,
        pw: pw,
        userName: username,
        bio: bio,
        file: file,
      ),
    );
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(AuthSuccess(user)),
    );
  }

  Future<void> _ongetuser(AuthCurrentUserRequested event, Emitter emit) async {
    final result = await getUserUseCase(NoParams());
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(AuthSuccess(user)),
    );
  }

  Future<void> _onlogout(AuthLogoutRequested event, Emitter emit) async {
    emit(AuthLoading());
    final result = await logoutUseCase(NoParams());
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(AuthFailure()),
    );
  }
}
