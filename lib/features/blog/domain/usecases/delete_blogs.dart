import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/src/either.dart';

class DeleteBlogs implements UseCase<String, DeleteBlogsParams>{
     final BlogRepository blogRepository;
  DeleteBlogs(this.blogRepository);
  @override
  Future<Either<Failure, String>> call(DeleteBlogsParams params) async{
   return  blogRepository.deleteBlogs(blogId: params.deleteBlogsId);
 
  } 
}

class DeleteBlogsParams {
  final Map deleteBlogsId;

  DeleteBlogsParams({required this.deleteBlogsId});
}