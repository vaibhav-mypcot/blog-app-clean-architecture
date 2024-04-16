import 'dart:convert';

import 'package:blog_app/features/pagingnation/data/user_model/user_model.dart';
import 'package:http/http.dart' as http;

class UsersApi {
  // static const FETCH_LIMIT = 20;
  Future<UserModel> getUserData(int FETCH_LIMIT) async {
    try {
      final response = await http.get(
          Uri.parse('https://dummyjson.com/users?skip=0&limit=$FETCH_LIMIT'));
      if (response.statusCode == 200) {
        final String responseBody = response.body;
        final Map<String, dynamic> responseData = json.decode(responseBody);
        return UserModel.fromMap(responseData);
      } else {
        throw Exception('Failed to load users: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }
}
