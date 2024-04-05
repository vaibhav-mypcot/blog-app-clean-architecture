import 'package:blog_app/features/auth/data/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final testUserModel =
      UserModel(id: '1', email: 'vaibhav@gmail.com', name: 'vaibhav');

  test('should be a subclass of blog entity', () async {
    // assert
    expect(testUserModel, isA<UserModel>());
  });
}
