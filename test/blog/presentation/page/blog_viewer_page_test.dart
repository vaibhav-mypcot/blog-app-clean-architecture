import 'package:bloc_test/bloc_test.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';

class MockBlogBloc extends MockBloc<BlogEvent, BlogState> implements BlogBloc {}

