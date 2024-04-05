import 'dart:io';

import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/features/blog/data/model/blog_model.dart';
import 'package:blog_app/features/blog/data/repositories/blog_repository_impl.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/mockito.dart';

import '../../helper/test_helper.mocks.dart';

final testBlogModel = BlogModel(
  id: '1',
  posterId: 'poster1',
  title: 'Blog 1',
  content: 'Content 1',
  imageUrl: 'image1.jpg',
  topics: ['topic1', 'topic2'],
  updatedAt: DateTime.now(),
  posterName: 'alpha',
);

void main() {
  late BlogRepositoryImpl repository;
  late MockBlogRemoteDataSource mockRemoteDataSource;
  late MockBlogLocalDataSource mockLocalDataSource;
  late MockConnectionChecker mockConnectionChecker;

  setUp(() {
    mockRemoteDataSource = MockBlogRemoteDataSource();
    mockLocalDataSource = MockBlogLocalDataSource();
    mockConnectionChecker = MockConnectionChecker();
    repository = BlogRepositoryImpl(
      mockRemoteDataSource,
      mockLocalDataSource,
      mockConnectionChecker,
    );
    // Stubbing the uploadBlogImage method
    when(mockRemoteDataSource.uploadBlogImage(
      image: anyNamed('image'),
      blog: anyNamed('blog'),
    )).thenAnswer((_) async => 'imageUrl');

    // Stubbing the uploadBlog method
    when(mockRemoteDataSource.uploadBlog(any))
        .thenAnswer((_) async => testBlogModel);
  });

  //------------------------------------------------- Fetch Blogs ----------------------------------------------------------------------------------------------------------------------------

  group('getAllBlogs', () {
    final List<Blog> testBlogList = [
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

    final testBlogModelList = testBlogList
        .map(
          (blog) => BlogModel(
            id: blog.id,
            posterId: blog.posterId,
            title: blog.title,
            content: blog.content,
            imageUrl: blog.imageUrl,
            topics: blog.topics,
            updatedAt: blog.updatedAt,
          ),
        )
        .toList();

    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // Arrange
      when(mockConnectionChecker.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getAllBlogs())
          .thenAnswer((_) async => testBlogModelList);

      // Act
      final result = await repository.getAllBlogs();

      // Assert
      expect(
          result, equals(Right<Failure, List<BlogModel>>(testBlogModelList)));
    });

    test('should return local data when there is no internet connection',
        () async {
      // Arrange
      when(mockConnectionChecker.isConnected).thenAnswer((_) async => false);
      when(mockLocalDataSource.loadBlogs()).thenReturn(testBlogModelList);

      // Act
      final result = await repository.getAllBlogs();

      // Assert
      expect(
          result, equals(Right<Failure, List<BlogModel>>(testBlogModelList)));
    });

    test(
        'should return ServerFailure when the call to remote data source is unsuccessful',
        () async {
      // Arrange
      when(mockConnectionChecker.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getAllBlogs()).thenThrow(ServerException(''));

      // Act
      final result = await repository.getAllBlogs();

      // Assert
      expect(result, equals(Left<Failure, List<Blog>>(Failure(''))));
      verify(mockRemoteDataSource.getAllBlogs());
      verifyNoMoreInteractions(mockRemoteDataSource);
      verifyZeroInteractions(mockLocalDataSource);
    });
  });

//------------------------------------------------- Upload Blogs ----------------------------------------------------------------------------------------------------------------------------

  group('uploadBlog', () {
    test('should return uploaded blog when upload is successful', () async {
      // Arrange
      final testBlogModel = BlogModel(
        id: '1',
        posterId: 'poster1',
        title: 'Blog 1',
        content: 'Content 1',
        imageUrl: 'image1.jpg',
        topics: ['topic1', 'topic2'],
        updatedAt: DateTime.now(),
        posterName: 'alpha',
      );
      when(mockConnectionChecker.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.uploadBlogImage(
              image: anyNamed('image'), blog: testBlogModel))
          .thenAnswer((_) async => 'imageUrl');
      when(mockRemoteDataSource.uploadBlog(testBlogModel))
          .thenAnswer((_) async => testBlogModel);

      // Act
      final result = await repository.uploadBlog(
        image: File("image1.jpg"),
        title: 'Blog 1',
        content: 'Content 1',
        posterId: 'poster1',
        topics: ['topic1', 'topic2'],
      );

      // Assert
      expect(result, right<Failure, Blog>(testBlogModel));
    });

    test('should return a failure when there is no internet connection',
        () async {
      // Arrange
      final testBlogModel = BlogModel(
        id: '1',
        posterId: 'poster1',
        title: 'Blog 1',
        content: 'Content 1',
        imageUrl: 'image1.jpg',
        topics: ['topic1', 'topic2'],
        updatedAt: DateTime.now(),
        posterName: 'alpha',
      );

      when(mockConnectionChecker.isConnected).thenAnswer((_) async => false);

      // Act
      final result = await repository.uploadBlog(
        image: File("image.jpg"),
        title: 'testTitle',
        content: 'testContent',
        posterId: 'testPosterId',
        topics: ['topic1', 'topic2'],
      );

      // Assert
      expect(result, Left<Failure, Blog>(Failure('No Internet Connection')));
    });
  });

  //------------------------------------------------- Delete Blogs ----------------------------------------------------------------------------------------------------------------------------

  group('deleteBlogs', () {
    test('should delete blogs successfully', () {
      // Arrange
      Map<dynamic, dynamic> blogId = {
        'id1': 'aa',
        'id2': 'bb'
      }; 
      when(mockRemoteDataSource.deleteBlogs(blogId: blogId))
          .thenAnswer((_) async => null);

      // Act
      final result = repository.deleteBlogs(blogId: blogId);

      // Assert
      expect(result, Right<Failure, String>('blogs deleted successfully'));
      verify(mockRemoteDataSource.deleteBlogs(blogId: blogId));
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test('should return a failure when an exception occurs', () {
      // Arrange
       Map<dynamic, dynamic> blogId = {'id1': 'aa', 'id2': 'bb'}; 
      final exceptionMessage = 'Server exception occurred';
      when(mockRemoteDataSource.deleteBlogs(blogId: blogId))
          .thenThrow(ServerException(exceptionMessage));

      // Act
      final result = repository.deleteBlogs(blogId: blogId);

      // Assert
      expect(result, Left<Failure, String>(Failure(exceptionMessage)));
      verify(mockRemoteDataSource.deleteBlogs(blogId: blogId));
      verifyNoMoreInteractions(mockRemoteDataSource);
    });
  });
}
