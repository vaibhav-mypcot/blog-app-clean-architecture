import 'package:blog_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog_app/features/auth/data/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../blog/helper/test_helper.mocks.dart';


void main() {
  late MockSupabaseClient mockSupabaseClient;
  late AuthRemoteDataSourceImpl authRemoteDataSourceImpl;
  late final user;
  late final response;
  setUp(() {
    mockSupabaseClient = MockSupabaseClient();
    authRemoteDataSourceImpl = AuthRemoteDataSourceImpl(mockSupabaseClient);

    user = UserModel(id: "1", email: "vaibhav@gmial.com", name: "Test@321");
  });

  group('Sign in with Email & Password', () {
    setUp(() {
      // when(mockSupabaseClient.auth).thenReturn(mockSupabaseClient.auth);
    });

    test('should return UserModel when sign-in is successful', () async {
      // Arrange

      when(mockSupabaseClient.auth.signInWithPassword(
              email: 'vaibhav@gmail.com', password: 'Test@321'))
          .thenAnswer((_) async => user);

      // Act
      final result = await authRemoteDataSourceImpl.signInWithEmailPassword(
          email: 'vaibhav@gmail.com', password: 'Test@321');

      // Assert
      expect(result, user);
    });
  });
}
