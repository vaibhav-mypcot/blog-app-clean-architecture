import 'dart:io';

import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/features/blog/data/model/blog_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class BlogRemoteDataSource {
  Future<BlogModel> uploadBlog(BlogModel blog);
  Future<String> uploadBlogImage({
    required File image,
    required BlogModel blog,
  });

  Future<List<BlogModel>> getAllBlogs();

  void deleteBlogs({
    required Map blogId,
  });
}

class BlogRemoteDataSourceImpl implements BlogRemoteDataSource {
  final SupabaseClient supabaseClient;
  BlogRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<String> uploadBlogImage({
    required File image,
    required BlogModel blog,
  }) async {
    try {
      await supabaseClient.storage.from('blog_images').upload(
            blog.id,
            image,
          );

      return supabaseClient.storage.from('blog_images').getPublicUrl(blog.id);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<BlogModel> uploadBlog(BlogModel blog) async {
    try {
      final blogData =
          await supabaseClient.from('blogs').insert(blog.toJson()).select();
      return BlogModel.fromJson(blogData.first);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<BlogModel>> getAllBlogs() async {
    try {
      final blogs =
          await supabaseClient.from('blogs').select('*, profiles (name)');
      blogs.map((e) => BlogModel.fromJson(e)).forEach((blog) {
        print('Title: ${blog}');
      });
      return blogs
          .map(
            (blog) => BlogModel.fromJson(blog).copyWith(
              posterName: blog['profiles']['name'],
            ),
          )
          .toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  //-- Delete Blogs

  @override
  void deleteBlogs({required Map blogId}) async {
    try {
      List values = blogId.values.toList();
      for (var blogIdValue in values) {
        await supabaseClient.from('blogs').delete().eq('id', blogIdValue);
      }

      print("blogs deleted from database successfully");
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  // @override
  // void deleteBlogs() {
  //   try {
  //     supabaseClient.from('blogs').delete().eq('id', id);
  
  //   } catch (e) {

  //   }
  // }
}
