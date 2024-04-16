part of 'user_data_bloc.dart';

abstract class UserDataState {}

final class UserDataInitial extends UserDataState {}

class DataLoaded extends UserDataState {
  final List<User>? users;
  DataLoaded({required this.users});
}

class DataLoading extends UserDataState {
  final List<User>? oldUsers;
  final bool isFetchFirst;
  DataLoading(this.oldUsers, {this.isFetchFirst = false});
}

class DataError extends UserDataState {
  final String errorMessage;
  DataError({required this.errorMessage});
}
