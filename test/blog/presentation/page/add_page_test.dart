import 'package:bloc_test/bloc_test.dart';
import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_app/features/blog/presentation/pages/blog_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockBlogBloc extends MockBloc<BlogEvent, BlogState> implements BlogBloc {}

void main() {
  late MockBlogBloc mockBlogBloc;

  setUp(() {
    mockBlogBloc = MockBlogBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<BlogBloc>(
      create: (context) => mockBlogBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('display loader', (tester) async {
    // Arrange
    when(() => mockBlogBloc.state).thenReturn(BlogLoading());
    // Act
    await tester.pumpWidget(makeTestableWidget(const BlogPage()));
    expect(find.byType(Loader), findsAny);
  });

  testWidgets('Display Success', (tester) async {
    // Arrange

    when(() => mockBlogBloc.state).thenReturn(BlogDisplaySuccess([], {}));
    // Act
    await tester.pumpWidget(makeTestableWidget(const BlogPage()));
    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(IconButton), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
  });
}
