import 'dart:io';

import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';

import '../../helper/test_helper.mocks.dart';

void main() {
  late MockGetAllBlogsUseCase mockGetAllBlogsUseCase;
  late MockDeleteBlogs mockDeleteBlogs;
  late MockUploadBlog mockUploadBlog;
  late BlogBloc blogBloc;
  late final blogList;
  late final uploadedBlog;

  setUp(() {
    mockUploadBlog = MockUploadBlog();
    mockGetAllBlogsUseCase = MockGetAllBlogsUseCase();
    mockDeleteBlogs = MockDeleteBlogs();
    blogBloc = BlogBloc(
      uploadBlog: mockUploadBlog,
      getAllBlogs: mockGetAllBlogsUseCase,
      deleteBlogs: mockDeleteBlogs,
    );
    blogList = <Blog>[
      Blog(
        id: '1',
        posterId: 'poster1',
        title: 'Blog 1',
        content: 'Content 1',
        imageUrl: 'image1.jpg',
        topics: ['topic1', 'topic2'],
        updatedAt: DateTime.now(),
        posterName: 'alpha',
      ),
    ];

    uploadedBlog = Blog(
      id: '1',
      posterId: 'posterId',
      title: 'title',
      content: 'content',
      imageUrl: 'image1.jpg',
      topics: ['topics'],
      updatedAt: DateTime.now(),
      posterName: 'alpha',
    );
  });

  group('Display success event', () {
    // in right(success) BlogDisplaySuccess i emit the {list, {}}
    // but in the act result it only give the list so this test case will not execute
    blocTest<BlogBloc, BlogState>(
      'emits BlogDisplaySuccess when MyEvent is added.',
      build: () {
        provideDummy<Either<Failure, List<Blog>>>(const Right([]));
        when(mockGetAllBlogsUseCase.call(NoParams()))
            .thenAnswer((_) async => const Right([]));

        return blogBloc;
      },
      act: (bloc) => bloc.add(BlogFetchAllBlogs()),
      expect: () => [
        BlogDisplaySuccess([], {}),
      ],
    );
  });

  group('display upload event', () {
    blocTest('emit BlogUploadSuccess when BlogUpload event is add',
        build: () {
          provideDummy<Either<Failure, Blog>>(Right(uploadedBlog));
          when(mockUploadBlog.call(any))
              .thenAnswer((_) async => Right(uploadedBlog));

          return blogBloc;
        },
        act: (bloc) => bloc.add(BlogUpload(
              content: 'title1',
              image: File('image.jpg'),
              posterId: 'id1',
              title: 'title1',
              topics: ["topic1"],
            )),
        expect: () => [BlogUploadSuccess()]);
  });

  group('delete event', () {
    blocTest<BlogBloc, BlogState>(
      'emits BlogDisplaySuccess when DeleteSelectedBlogEvent is added',
      build: () => blogBloc,
      act: (bloc) => bloc.add(DeleteSelectedBlogEvent()),
      expect: () => [],
    );
  });
}
