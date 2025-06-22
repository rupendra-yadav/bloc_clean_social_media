import 'package:clean_bloc_wrap/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:clean_bloc_wrap/features/auth/data/repository/auth_repository_impl.dart';
import 'package:clean_bloc_wrap/features/auth/domain/repository/auth_repository.dart';
import 'package:clean_bloc_wrap/features/auth/domain/use_cases/get_user.dart';
import 'package:clean_bloc_wrap/features/auth/domain/use_cases/login_user.dart';
import 'package:clean_bloc_wrap/features/auth/domain/use_cases/logout.dart';
import 'package:clean_bloc_wrap/features/auth/domain/use_cases/sign_up.dart';
import 'package:clean_bloc_wrap/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void initAuth() {
  /// Auth Use Cases Injection

  sl.registerLazySingleton(() => GetUser(sl()));
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => SignUpUsecase(sl()));
  sl.registerLazySingleton(() => LogOut(sl()));

  /// Auth Repository Injection
  ///
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));

  /// Auth Data sources Injection
  sl.registerLazySingleton(
    () => AuthRemoteDataSource(auth: sl(), firestore: sl(), storage: sl()),
  );

  /// Auth  Bloc Injection
  sl.registerFactory(
    () => AuthBloc(
      loginUseCase: sl(),
      signUpUseCase: sl(),
      getUserUseCase: sl(),
      logoutUseCase: sl(),
    ),
  );
}
