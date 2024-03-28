part of 'blog_bloc.dart';

@immutable
sealed class BlogState {}

final class BlogInitial extends BlogState {}

final class BlogLoading extends BlogState {}

final class BlogFailure extends BlogState {
  final String error;
  BlogFailure(this.error);
}

final class BlogUploadSuccess extends BlogState {}

final class BlogDisplaySuccess extends BlogState {
  final List<Blog> blogs;
  final Map<int, String> selectedIndices;
  BlogDisplaySuccess(
    this.blogs,
    this.selectedIndices
  );
}

final class BlogDeleteState extends BlogState {}

final class SelectedBlogState extends BlogState {
  final List<int> selectedIndices;
  SelectedBlogState(this.selectedIndices);
}
