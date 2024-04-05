import 'package:blog_app/core/common/entities/user.dart';
import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/auth/domain/usecases/current_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/mockito.dart';

import '../../helper/test_helper.mocks.dart';

void main() {
  late CurrentUser currentUser;
  late MockAuthRepository mockAuthRepository;
  late final user;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    currentUser = CurrentUser(mockAuthRepository);
    user = User(id: '1', email: 'vaibhav@gmail.com', name: 'vaibhav');
  });

  group('Current user', () {
    setUp(() {
      provideDummy<Either<Failure, User>>(Right(user));
    });

    test('should return current user from the repository', () async {
      when(mockAuthRepository.currentUser())
          .thenAnswer((_) async => Right(user));

      // Act
      final result = await currentUser.call(NoParams());

      // Assert
      expect(result, Right(user));
    });

    test('should return failure of current user', () async {
      when(mockAuthRepository.currentUser())
          .thenAnswer((_) async => Left(Failure('Failed')));

      // Act
      final result = await currentUser.call(NoParams());

      // Assert
      expect(result, Left(Failure('Failed')));
    });
  });
}
