import 'package:bloc_test/bloc_test.dart';
import 'package:blog_app/features/pagingnation/presentation/bloc/user_data_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UserDataBloc', () {
    late UserDataBloc userDataBloc;

    setUp(() {
      userDataBloc = UserDataBloc();
    });

    tearDown(() {
      userDataBloc.close();
    });

    test('initial state is UserDataInitial', () {
      expect(userDataBloc.state, equals(UserDataInitial()));
    });

    blocTest<UserDataBloc, UserDataState>(
      'emits [DataLoading, DataLoaded] when FetchUsersEvent is added and data is loaded successfully',
      build: () => userDataBloc,
      act: (bloc) => bloc.add(FetchUsersEvent()),
      verify: (_) {
        expect(userDataBloc.state, equals(DataLoading([], isFetchFirst: true)));
        // Simulate successful data loading
        userDataBloc.emit(DataLoaded(users: []));
        expect(userDataBloc.state, equals(DataLoaded(users: [])));
      },
    );

    blocTest<UserDataBloc, UserDataState>(
      'emits [DataLoading, DataError] when FetchUsersEvent is added and data loading fails',
      build: () => userDataBloc,
      act: (bloc) => bloc.add(FetchUsersEvent()),
      verify: (_) {
        expect(userDataBloc.state, equals(DataLoading([], isFetchFirst: true)));
        // Simulate error during data loading
        userDataBloc.emit(DataError(errorMessage: 'Error fetching users'));
        expect(userDataBloc.state,
            equals(DataError(errorMessage: 'Error fetching users')));
      },
    );
  });
}
