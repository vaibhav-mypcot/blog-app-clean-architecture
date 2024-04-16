import 'package:bloc/bloc.dart';
import 'package:blog_app/features/pagingnation/data/user_model/user.dart';
import 'package:blog_app/features/pagingnation/data/services/users_api.dart';
import 'package:equatable/equatable.dart';

part 'user_data_event.dart';
part 'user_data_state.dart';

class UserDataBloc extends Bloc<UserDataEvent, UserDataState> {
  final UsersApi _usersApi = UsersApi();
  int limit = 20;

  UserDataBloc() : super(UserDataInitial()) {
    on<FetchUsersEvent>(_onFetchAllUsersData);
  }

  void _onFetchAllUsersData(
      FetchUsersEvent event, Emitter<UserDataState> emit) async {
    try {
      if (state is DataLoading) return;

      final currentState = state;

      var oldUserData = <User>[];
      if (currentState is DataLoaded) {
        oldUserData = currentState.users!;
      }

      emit(DataLoading(oldUserData, isFetchFirst: limit == 20));

      final newPost = await _usersApi.getUserData(limit).then((newPost) {
        limit += 20;
        final userData = (state as DataLoading).oldUsers;
        userData!.addAll(newPost.users!);
        emit(DataLoaded(users: userData));
      });
    } catch (e) {
      emit(DataError(errorMessage: 'Error fetching users: $e'));
    }
  }
}
