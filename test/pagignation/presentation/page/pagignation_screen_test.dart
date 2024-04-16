import 'package:bloc_test/bloc_test.dart';
import 'package:blog_app/features/pagingnation/data/user_model/user.dart';
import 'package:blog_app/features/pagingnation/presentation/bloc/user_data_bloc.dart';
import 'package:blog_app/features/pagingnation/presentation/pages/users_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';

// Mock UserDataBloc
class MockUserDataBloc extends MockBloc<UserDataEvent, UserDataState>
    implements UserDataBloc {}

void main() {
  group('UsersListScreen Widget Test', () {
    late MockUserDataBloc mockUserDataBloc;

    setUp(() {
      mockUserDataBloc = MockUserDataBloc();
    });

    Widget makeTestableWidget(Widget body) {
      return BlocProvider<UserDataBloc>(
        create: (context) => mockUserDataBloc,
        child: MaterialApp(
          home: body,
        ),
      );
    }

    testWidgets('Renders UsersListScreen widget', (WidgetTester tester) async {
      // Mock the UserDataBloc state
      final List<User> mockUsers = [
        User(id: 1, firstName: 'User 1'),
        User(id: 2, firstName: 'User 2'),
        User(id: 3, firstName: 'User 3'),
      ];
      when(() => mockUserDataBloc.state)
          .thenReturn(DataLoaded(users: mockUsers));

      // Build UsersListScreen widget
      await tester.pumpWidget(makeTestableWidget(UsersListScreen()));

      // Verify that the UsersListScreen widget renders correctly
      expect(find.text('Users Data'), findsOneWidget);
      // expect(find.byType(CircularProgressIndicator), findsAny);

      // Verify that the user cards are displayed
      // expect(find.text('User 1'), findsOneWidget);
      // expect(find.text('User 2'), findsOneWidget);
      // expect(find.text('User 3'), findsOneWidget);
    });
  });
}
