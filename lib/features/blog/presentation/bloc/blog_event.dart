part of 'blog_bloc.dart';

@immutable
sealed class BlogEvent {}

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
}

final class BlogFetchAllBlogs extends BlogEvent {}

final class BlogDeleteEvent extends BlogEvent {}

final class SelectedBlogEvent extends BlogEvent {
  final int index;
  final String blogId; 
  SelectedBlogEvent(this.index, this.blogId);
}

class UnSelectedBlogEvent extends BlogEvent {
  final int index;
  final String blogId; 
  UnSelectedBlogEvent(this.index, this.blogId);
}

class UnSelectAllBlogs extends BlogEvent {}

class DeleteSelectedBlogEvent extends BlogEvent {}
