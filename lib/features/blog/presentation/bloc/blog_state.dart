part of 'blog_bloc.dart';

abstract class BlogState extends Equatable {
  const BlogState();
  @override
  List<Object?> get props => [];
}

final class BlogInitial extends BlogState {}

final class BlogLoading extends BlogState {}

final class BlogFailure extends BlogState {
  final String error;
  BlogFailure(this.error);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

final class BlogUploadSuccess extends BlogState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class BlogDisplaySuccess extends BlogState {
  final List<Blog> blogs;
  final Map<int, String> selectedIndices;
  BlogDisplaySuccess(this.blogs, this.selectedIndices);

  @override
  // TODO: implement props
  List<Object?> get props => [blogs, selectedIndices];
}

final class BlogDeleteState extends BlogState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

final class SelectedBlogState extends BlogState {
  final List<int> selectedIndices;
  SelectedBlogState(this.selectedIndices);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
