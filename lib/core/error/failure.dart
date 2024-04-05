import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String message;
  // we wrap the this.message with square brackets for when it get's empty value the String will be an default value
  Failure(this.message);

  @override
  List<Object?> get props => [message];
}
