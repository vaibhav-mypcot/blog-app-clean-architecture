import 'package:blog_app/core/network/connection_checker.dart';

import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/blog/data/datasources/blog_local_data_source.dart';
import 'package:blog_app/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:blog_app/features/blog/domain/usecases/delete_blogs.dart';
import 'package:blog_app/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:blog_app/features/blog/domain/usecases/upload_blog.dart';
import 'package:mockito/annotations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// customMocks: [MockSpec<SupabaseClient>(as: #MockSupabaseClient)],
@GenerateMocks(
  [
    BlogRepository,
    BlogRemoteDataSource,
    BlogLocalDataSource,

    ConnectionChecker,
    UseCase,
    SupabaseClient,
    PostgrestFilterBuilder,

    // Use Cases
    GetAllBlogsUseCase,
    UploadBlog,
    DeleteBlogs,
  
  ],
)
void main() {}
