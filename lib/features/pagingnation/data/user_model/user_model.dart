// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'user.dart';

class UserModel extends Equatable {
  List<User>? users;
  int? total;
  int? skip;
  int? limit;

  UserModel({this.users, this.total, this.skip, this.limit});

  factory UserModel.fromMap(Map<String, dynamic> data) => UserModel(
        users: (data['users'] as List<dynamic>?)
            ?.map((e) => User.fromMap(e as Map<String, dynamic>))
            .toList(),
        total: data['total'] as int?,
        skip: data['skip'] as int?,
        limit: data['limit'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'users': users?.map((e) => e.toMap()).toList(),
        'total': total,
        'skip': skip,
        'limit': limit,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [UserModel].
  // factory UserModel.fromJson(String data) {
  //   return UserModel.fromMap(json.decode(data) as Map<String, dynamic>);
  // }

  // /// `dart:convert`
  // ///
  // /// Converts [UserModel] to a JSON string.
  // String toJson() => json.encode(toMap());

  @override
  List<Object> get props => [User, 100, 0, 30];
}
