import 'dart:typed_data';
import 'package:clean_bloc_wrap/features/post/domain/use_cases/comment.dart';
import 'package:clean_bloc_wrap/features/post/domain/use_cases/delete_post.dart';
import 'package:clean_bloc_wrap/features/post/domain/use_cases/like_post.dart';
import 'package:clean_bloc_wrap/features/post/domain/use_cases/upload_post.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final UploadPostUseCase uploadPostUseCase;
  final CommentUseCase commentUseCase;
  final LikePostUseCase likePostUseCase;
  final DeletePostUseCase deletePostUseCase;
  PostBloc({
    required this.uploadPostUseCase,
    required this.commentUseCase,
    required this.likePostUseCase,
    required this.deletePostUseCase,
  }) : super(PostInitial()) {
    on<PostUpload>(_onuploadpost);
    on<PostComment>(_oncommentpost);
    on<PostLike>(_onlikepost);
    on<PostDelete>(_ondeletepost);
  }

  Future<void> _onuploadpost(PostUpload event, Emitter emit) async {
    emit(PostLoading());
    final result = await uploadPostUseCase(
      UploadPostUseCaseParams(
        description: event.description,
        uid: event.uid,
        username: event.username,
        profImage: event.profImage,
        file: event.file,
      ),
    );
    result.fold((failure) => emit(PostFailure()), (_) => emit(PostSuccess()));
  }

  Future<void> _oncommentpost(PostComment event, Emitter emit) async {
    final result = await commentUseCase(
      CommentUseCaseParams(
        uid: event.uid,
        name: event.name,
        profilepic: event.profilepic,
        postId: event.postId,
        text: event.text,
      ),
    );
    result.fold((failure) => emit(PostFailure()), (_) => emit(PostSuccess()));
  }

  Future<void> _onlikepost(PostLike event, Emitter emit) async {
    final result = await likePostUseCase(
      LikePostUseCaseParams(
        postid: event.postid,
        uid: event.uid,
        likes: event.likes,
      ),
    );
    result.fold((failure) => emit(PostFailure()), (_) => emit(PostSuccess()));
  }

  Future<void> _ondeletepost(PostDelete event, Emitter emit) async {
    final result = await deletePostUseCase(
      DeletePostUseCaseParams(postid: event.postid),
    );
    result.fold((failure) => emit(PostFailure()), (_) => emit(PostSuccess()));
  }
}
