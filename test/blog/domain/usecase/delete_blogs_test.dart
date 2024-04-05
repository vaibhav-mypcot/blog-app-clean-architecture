import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/features/blog/domain/usecases/delete_blogs.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/mockito.dart';

import '../../helper/test_helper.mocks.dart';

void main() {
  group('delete blogs', () {
    late DeleteBlogs deleteBlogs;
    late MockBlogRepository mockBlogRepository;
    late final deleteBlogsParams;
    late final String deletionResult;

    setUp(() {
      mockBlogRepository = MockBlogRepository();
      deleteBlogs = DeleteBlogs(mockBlogRepository);
      deleteBlogsParams =
          DeleteBlogsParams(deleteBlogsId: {'id1': 'aa', 'id2': 'bb'});
      deletionResult = 'Deletion successful';
      provideDummy<Either<Failure, String>>(Right(deletionResult));
    });

    test('should delete blogs successfully', () async {
      // Arrange
      when(mockBlogRepository.deleteBlogs(
              blogId: deleteBlogsParams.deleteBlogsId))
          .thenAnswer((_) => Right(deletionResult));

      // Act
      final result = await deleteBlogs(deleteBlogsParams);

      // Assert
      expect(result, Right(deletionResult));
    });

    test('should return a failure if deletion fails', () async {
      // Arrange
      // Assuming your repository returns a failure when deleting blogs
      when(mockBlogRepository.deleteBlogs(
              blogId: deleteBlogsParams.deleteBlogsId))
          .thenAnswer((_) => Left(Failure('Deletion failed')));

      // Act
      final result = await deleteBlogs(deleteBlogsParams);

      // Assert
      expect(result,
          Left(Failure('Deletion failed'))); // Use await to handle Future
    });
  });
}
