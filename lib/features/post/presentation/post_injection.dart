import 'package:clean_bloc_wrap/features/post/data/data_source/remote_data_source.dart';
import 'package:clean_bloc_wrap/features/post/data/repository/post_repository_impl.dart';
import 'package:clean_bloc_wrap/features/post/domain/repository/post_repository.dart';
import 'package:clean_bloc_wrap/features/post/domain/use_cases/comment.dart';
import 'package:clean_bloc_wrap/features/post/domain/use_cases/delete_post.dart';
import 'package:clean_bloc_wrap/features/post/domain/use_cases/like_post.dart';
import 'package:clean_bloc_wrap/features/post/domain/use_cases/upload_post.dart';
import 'package:clean_bloc_wrap/features/post/presentation/bloc/post_bloc.dart';
import 'package:get_it/get_it.dart';

GetIt sl = GetIt.instance;

void initPost() {
  sl.registerLazySingleton(() => UploadPostUseCase(sl()));
  sl.registerLazySingleton(() => CommentUseCase(sl()));
  sl.registerLazySingleton(() => LikePostUseCase(sl()));
  sl.registerLazySingleton(() => DeletePostUseCase(sl()));

  sl.registerLazySingleton<PostRepository>(() => PostRepositoryImpl(sl()));
  sl.registerLazySingleton<PostRemoteDataSource>(
    () => PostRemoteDataSourceImpl(sl(), sl(), sl()),
  );

  sl.registerFactory(
    () => PostBloc(
      uploadPostUseCase: sl(),
      commentUseCase: sl(),
      likePostUseCase: sl(),
      deletePostUseCase: sl(),
    ),
  );
}
