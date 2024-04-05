import 'dart:io';

import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/domain/usecases/upload_blog.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/mockito.dart';

import '../../helper/test_helper.mocks.dart';

void main() {
  late UploadBlog uploadBlog;
  late MockBlogRepository mockBlogRepository;
  late final params;
  late final uploadedBlog;

  setUp(() {
    mockBlogRepository = MockBlogRepository();
    uploadBlog = UploadBlog(mockBlogRepository);

    params = UploadBlogParams(
      posterId: 'poster1',
      title: 'Blog 1',
      content: 'Content 1',
      image: File('path/to/image.jpg'),
      topics: ['topic1', 'topic2'],
    );
    uploadedBlog = Blog(
      id: '1',
      posterId: params.posterId,
      title: params.title,
      content: params.content,
      imageUrl: 'image1.jpg',
      topics: params.topics,
      updatedAt: DateTime.now(),
      posterName: 'alpha',
    );

    provideDummy<Either<Failure, Blog>>(Right(uploadedBlog));
  });

  test('should upload a blog successfully', () async {
    // Arrange
    
    when(mockBlogRepository.uploadBlog(
      image: params.image,
      title: params.title,
      content: params.content,
      posterId: params.posterId,
      topics: params.topics,
    )).thenAnswer((_) async => Right(uploadedBlog));

    // Act
    final result = await uploadBlog(params);

    // Assert
    expect(result, equals(Right(uploadedBlog)));
    verify(mockBlogRepository.uploadBlog(
      image: params.image,
      title: params.title,
      content: params.content,
      posterId: params.posterId,
      topics: params.topics,
    ));
    verifyNoMoreInteractions(mockBlogRepository);
  });

}
