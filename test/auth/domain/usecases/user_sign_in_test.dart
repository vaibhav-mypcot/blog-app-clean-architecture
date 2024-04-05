import 'package:blog_app/core/common/entities/user.dart';
import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_in.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/mockito.dart';

import '../../helper/test_helper.mocks.dart';

void main() {
  late UserSignIn userSignIn;
  late MockAuthRepository mockAuthRepository;
  late final user;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    userSignIn = UserSignIn(mockAuthRepository);
    user = User(id: '1', email: 'vaibhav@gmail.com', name: 'vaibhav');
  });

  group('User sign in', () {
    setUp(() {
      provideDummy<Either<Failure, User>>(Right(user));
    });
    test('should return user sign in successful', () async {
      when(mockAuthRepository.signInWithEmailPassword(
              email: 'vaibhav@gmail.com', password: 'Test@321'))
          .thenAnswer((_) async => Right(user));

      // Act
      final result = await userSignIn.call(
          UserSignInParams(email: 'vaibhav@gmail.com', password: 'Test@321'));

      // Assert
      expect(result, Right(user));
    });

    test('should return user sign in failure', () async {
      when(mockAuthRepository.signInWithEmailPassword(
              email: 'vaibhav@gmail.com', password: 'Test@321'))
          .thenAnswer((_) async => Left(Failure('failed')));

      // Act
      final result = await userSignIn.call(
          UserSignInParams(email: 'vaibhav@gmail.com', password: 'Test@321'));

      // Assert
      expect(result, Left(Failure('failed')));
    });
  });
}
