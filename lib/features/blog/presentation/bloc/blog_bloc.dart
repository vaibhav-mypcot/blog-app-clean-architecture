import 'dart:io';

import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/domain/usecases/delete_blogs.dart';
import 'package:blog_app/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:blog_app/features/blog/domain/usecases/upload_blog.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog _uploadBlog;
  final GetAllBlogsUseCase _getAllBlogs;
  final DeleteBlogs _deleteBlogs;
  // List<Map<int, String>> selectedIndices = [];
  // List<int> selectedIndices = [];
  Map<int, String> selectedIndices = {};

  BlogBloc({
    required UploadBlog uploadBlog,
    required GetAllBlogsUseCase getAllBlogs,
    required DeleteBlogs deleteBlogs,
  })  : _uploadBlog = uploadBlog,
        _getAllBlogs = getAllBlogs,
        _deleteBlogs = deleteBlogs,
        super(BlogInitial()) {
    // on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<BlogUpload>(_onBlogUpload);
    on<BlogFetchAllBlogs>(_onFetchAllBlogs);
    on<BlogEvent>(_deleteSelectedBlog);
  }

  void _deleteSelectedBlog(BlogEvent event, Emitter<BlogState> emit) async {
    // -- Select Blog
    if (event is SelectedBlogEvent) {
      final int index = event.index;
      final String blogId = event.blogId;

      if (selectedIndices.containsKey(index)) {
        selectedIndices.remove(index);
      } else {
        selectedIndices[index] = blogId;
        print("All Maps values : ${selectedIndices}");
      }
      final res = await _getAllBlogs(NoParams());
      res.fold((l) => emit(BlogFailure(l.message)),
          (r) => emit(BlogDisplaySuccess(r, selectedIndices)));
    }
    // -- UnSelect Blog
    else if (event is UnSelectedBlogEvent) {
      final int index = event.index;
      if (selectedIndices.containsKey(index)) {
        selectedIndices.remove(index);
      }
      final res = await _getAllBlogs(NoParams());
      res.fold((l) => emit(BlogFailure(l.message)),
          (r) => emit(BlogDisplaySuccess(r, selectedIndices)));
    }

    // -- Cancel all selected blogs

    else if (event is UnSelectAllBlogs) {
      if (selectedIndices.isNotEmpty) {
        selectedIndices.clear();
      }
      final res = await _getAllBlogs(NoParams());
      res.fold((l) => emit(BlogFailure(l.message)),
          (r) => emit(BlogDisplaySuccess(r, selectedIndices)));
    }

    // -- Delete selected blogs
    else if (event is DeleteSelectedBlogEvent) {
      if (selectedIndices.isNotEmpty) {
        _deleteBlogs(DeleteBlogsParams(deleteBlogsId: selectedIndices));
        selectedIndices.clear();
      }
    }
  }

  void _onBlogUpload(BlogUpload event, Emitter<BlogState> emit) async {
    final res = await _uploadBlog(
      UploadBlogParams(
        posterId: event.posterId,
        title: event.title,
        content: event.content,
        image: event.image,
        topics: event.topics,
      ),
    );

    res.fold(
      (l) => emit(BlogFailure(l.message)),
      (r) => emit(
        BlogUploadSuccess(),
      ),
    );
  }

  void _onFetchAllBlogs(
      BlogFetchAllBlogs event, Emitter<BlogState> emit) async {
    final res = await _getAllBlogs(NoParams());
    res.fold((l) => emit(BlogFailure(l.message)),
        (r) => emit(BlogDisplaySuccess(r, selectedIndices)));
  }
}
