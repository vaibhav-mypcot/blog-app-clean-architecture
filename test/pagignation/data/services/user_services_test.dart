import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/features/pagingnation/data/services/users_api.dart';
import 'package:blog_app/features/pagingnation/data/user_model/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import '../../../blog/helper/test_helper.mocks.dart';

void main() {
  late UsersApi usersApi;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    usersApi = UsersApi();
  });

  group('User data api', () {
    test('User data fetch successfully', () async {
      when(mockHttpClient
              .get(Uri.parse('https://dummyjson.com/users?skip=0&limit=30')))
          .thenAnswer(
              (_) async => http.Response(('helper/user_response.json'), 200));

      // act
      final result = await usersApi.getUserData(30);

      // assert
      expect(result, equals(UserModel()));
    });

    test('User data fetch failed', () async {
      when(mockHttpClient
              .get(Uri.parse('https://dummyjson.com/users?skip=0&limit=30')))
          .thenAnswer(
              (_) async => http.Response(('helper/user_response.json'), 404));

      // act
      final result = await usersApi.getUserData(30);

      // assert
      expect(() => result, throwsA(isA<ServerException>()));
    });
  });
}
