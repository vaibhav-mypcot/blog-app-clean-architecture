import 'package:blog_app/features/blog/data/model/blog_model.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
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

  test('should be a subclass of blog entity', () async {
    //assert
    expect(testBlogModel, isA<Blog>());
  });
}
