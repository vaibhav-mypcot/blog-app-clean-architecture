import 'package:blog_app/core/common/entities/user.dart';
import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/mockito.dart';

import '../../helper/test_helper.mocks.dart';

void main() {
  late UserSignUp userSignUp;
  late MockAuthRepository mockAuthRepository;
  late final user;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    userSignUp = UserSignUp(mockAuthRepository);
    user = User(id: '1', email: 'vaibhav@gmail.com', name: 'vaibhav');
  });

  group('user Sign Up', () {
    setUp(() {
      provideDummy<Either<Failure, User>>(Right(user));
    });

    test('user sign up successfully', () async {
      when(mockAuthRepository.signUpWithEmailPassword(
              name: 'vaibhav',
              email: 'vaibhav@gmail.com',
              password: 'Test@321'))
          .thenAnswer((_) async => Right(user));

      // Act

      final result = await userSignUp.call(UserSignUpParams(
          email: 'vaibhav@gmail.com', password: 'Test@321', name: 'vaibhav'));

      // Assert
      expect(result, Right(user));
    });

    test('user sign up failure', () async {
      when(mockAuthRepository.signUpWithEmailPassword(
              name: 'vaibhav',
              email: 'vaibhav@gmail.com',
              password: 'Test@321'))
          .thenAnswer((_) async => Left(Failure('failed')));

      // Act

      final result = await userSignUp.call(UserSignUpParams(
          email: 'vaibhav@gmail.com', password: 'Test@321', name: 'vaibhav'));

      // Assert
      expect(result, Left(Failure('failed')));
    });
  });
}
