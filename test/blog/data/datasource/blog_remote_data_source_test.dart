import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:blog_app/features/blog/data/model/blog_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../auth/helper/helper.mocks.dart';




void main() {
  late BlogRemoteDataSourceImpl dataSource;
  late MockSupabaseClient mockSupabaseClient;
  late MockSupabaseQueryBuilder mockQueryBuilder;
  late MockPostgrestFilterBuilder mockPostgrestFilterBuilder =
      MockPostgrestFilterBuilder();
  late final testBlogList;

  setUp(() {
    mockSupabaseClient = MockSupabaseClient();
    dataSource = BlogRemoteDataSourceImpl(mockSupabaseClient);
    mockQueryBuilder = MockSupabaseQueryBuilder();
    mockPostgrestFilterBuilder = MockPostgrestFilterBuilder();

    testBlogList = [
      {
        'id': '1',
        'posterId': 'poster1',
        'title': 'Blog 1',
        'content': 'Content 1',
        'imageUrl': 'image1.jpg',
        'topics': ['topic1', 'topic2'],
        'updatedAt': DateTime.now().toIso8601String(),
        'posterName': 'alpha',
      }
    ];
  });

  group('getAllBlogs', () {
    test('should return list of BlogModel when the call is successful',
        () async {
      // Arrange

      when(mockSupabaseClient.from('blogs').select('*, profiles (name)'))
          .thenAnswer((_) => testBlogList);

      // Act
      final result = await dataSource.getAllBlogs();

      // Assert
      expect(result, testBlogList);
    });

    test('should throw a ServerException when the call fails', () {
      // Arrange
      when(mockQueryBuilder.select('*, profiles (name)'))
          .thenThrow(Exception());

      // Act
      final call = dataSource.getAllBlogs;

      // Assert
      expect(() => call(), throwsA(isA<ServerException>()));
    });
  });
}
