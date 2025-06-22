part of 'post_bloc.dart';

sealed class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

class PostUpload extends PostEvent {
  final String description;
  final String uid;
  final String username;
  final String profImage;
  Uint8List file;

  PostUpload(
    this.file,
    this.description,
    this.uid,
    this.username,
    this.profImage,
  );
}

class PostComment extends PostEvent {
  final String postId;
  final String text;
  final String uid;
  final String name;
  final String profilepic;

  PostComment(this.postId, this.text, this.uid, this.name, this.profilepic);
}

class PostLike extends PostEvent {
  final String postid;
  final String uid;
  final List likes;

  PostLike(this.postid, this.uid, this.likes);
}

class PostDelete extends PostEvent {
  final String postid;

  PostDelete(this.postid);
}
