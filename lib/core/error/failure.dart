import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String message;
  // we wrap the this.message with square brackets for when it get's empty value the String will be an default value
  Failure(this.message);

  @override
  List<Object?> get props => [message];
}

// class Person {
//   final String name;
//   final int age;

//   Person(this.name, this.age);

//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is Person &&
//           runtimeType == other.runtimeType &&
//           name == other.name &&
//           age == other.age;

//   @override
//   int get hashCode => name.hashCode ^ age.hashCode;
// }
