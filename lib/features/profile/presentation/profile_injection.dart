import 'package:clean_bloc_wrap/features/profile/data/data_source/remote_data_source.dart';
import 'package:clean_bloc_wrap/features/profile/data/repository/profile_repository_impl.dart';
import 'package:clean_bloc_wrap/features/profile/domain/repository/profile_repository.dart';
import 'package:clean_bloc_wrap/features/profile/domain/use_cases/follow_toggle.dart';
import 'package:clean_bloc_wrap/features/profile/domain/use_cases/get_data.dart';
import 'package:clean_bloc_wrap/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:get_it/get_it.dart';

GetIt sl = GetIt.instance;

void initProfile() {
  sl.registerLazySingleton(() => FollowToggleUseCase(sl()));
  sl.registerLazySingleton(() => GetDataUseCase(sl()));

  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSource(sl()),
  );

  sl.registerFactory(
    () => ProfileBloc(followToggleUseCase: sl(), getDataUseCase: sl()),
  );
}
