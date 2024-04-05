import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/mockito.dart';

import '../../helper/test_helper.mocks.dart';

void main() {
  late GetAllBlogsUseCase getAllBlogsUsecase; // Usecase
  late MockBlogRepository mockBlogRepository; // repo

  late final List<Blog> blogList;

  setUp(() {
    mockBlogRepository = MockBlogRepository();
    getAllBlogsUsecase = GetAllBlogsUseCase(mockBlogRepository);

    blogList = [
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
  });

  group("get all blogs", () {
    setUp(() {
      provideDummy<Either<Failure, List<Blog>>>(Right(blogList));
    });

    test('should return a list of blogs from the repository', () async {
      // Mock the  repository method to return a dummy value
      when(mockBlogRepository.getAllBlogs())
          .thenAnswer((_) async => Right(blogList));

      // Act
      final result = await getAllBlogsUsecase.call(NoParams());

      // Assert
      expect(result, Right(blogList));
      verify(mockBlogRepository.getAllBlogs());
    });
  });
}
