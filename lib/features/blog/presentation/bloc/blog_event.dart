part of 'blog_bloc.dart';

@immutable
sealed class BlogEvent extends Equatable{}

final class BlogUpload extends BlogEvent {
  final String posterId;
  final String title;
  final String content;
  final File image;
  final List<String> topics;

  BlogUpload({
    required this.posterId,
    required this.title,
    required this.content,
    required this.image,
    required this.topics,
  });
  
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

final class BlogFetchAllBlogs extends BlogEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

final class BlogDeleteEvent extends BlogEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

final class SelectedBlogEvent extends BlogEvent {
  final int index;
  final String blogId; 
  SelectedBlogEvent(this.index, this.blogId);
  
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class UnSelectedBlogEvent extends BlogEvent {
  final int index;
  final String blogId; 
  UnSelectedBlogEvent(this.index, this.blogId);
  
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class UnSelectAllBlogs extends BlogEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class DeleteSelectedBlogEvent extends BlogEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
