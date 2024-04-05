import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/features/auth/data/models/user_model.dart';
import 'package:blog_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/mockito.dart';

import '../../helper/test_helper.mocks.dart';

void main() {
  late AuthRepositoryImpl authRepositoryImpl;
  late MockAuthRemoteDataSource mockAuthRemoteDataSource;
  late MockConnectionChecker mockConnectionChecker;
  late final UserModel user;


  setUp(() {
    mockAuthRemoteDataSource = MockAuthRemoteDataSource();
    mockConnectionChecker = MockConnectionChecker();
    authRepositoryImpl = AuthRepositoryImpl(
      mockAuthRemoteDataSource,
      mockConnectionChecker,
    );
    when(mockConnectionChecker.isConnected).thenAnswer((_) async => true);
  });

  group('Current User', () {
    setUp(() {
      user = UserModel(id: '1', email: "vaibhav@gmail.com", name: "vaibhav");
    });
    test('should return User when user is logged in and connected', () async {
      // Arrange

      when(mockAuthRemoteDataSource.getCurrentUserData())
          .thenAnswer((_) async => user);

      // Act
      final result = await authRepositoryImpl.currentUser();

      // Assert
      expect(result, equals(Right(user)));
      verifyNever(mockAuthRemoteDataSource.currentUserSession);
    });

    // test('should return User when user is logged in and disconnected',
    //     () async {
    //   // Arrange
    //   when(mockConnectionChecker.isConnected).thenAnswer((_) async => false);

    //   // Act
    //   final result = await authRepositoryImpl.currentUser();

    //   // Assert
    //   expect(result,
    //       equals(Right(User(id: '1', email: 'vaibhav@gmail.com', name: ' '))));
    //   verifyNever(mockAuthRemoteDataSource.getCurrentUserData());
    // });

    test('should return Failure when user is not logged in', () async {
      // Arrange
      when(mockAuthRemoteDataSource.getCurrentUserData())
          .thenAnswer((_) async => null);

      // Act
      final result = await authRepositoryImpl.currentUser();

      // Assert
      expect(result, equals(left(Failure("User not logged in"))));
    });

    test('should return Failure when an error occurs', () async {
      // Arrange

      when(mockAuthRemoteDataSource.getCurrentUserData())
          .thenThrow(const ServerException('Server error'));

      // Act
      final result = await authRepositoryImpl.currentUser();

      // Assert
      expect(result, equals(left(Failure("Server error"))));
    });
  });

  group('SignIn with Email & Password', () {
    final user =
        UserModel(id: "1", email: "vaibhav@gmial.com", name: "Test@321");
    test('should return User when sign-in is successful', () async {
      // Arrange
      when(mockAuthRemoteDataSource.signInWithEmailPassword(
              email: "vaibhav@gmial.com", password: "Test@321"))
          .thenAnswer((_) async => user);
      // Act
      final result = await authRepositoryImpl.signInWithEmailPassword(
          email: "vaibhav@gmial.com", password: "Test@321");
      // Assert
      expect(result, equals(Right(user)));
    });

    test('should return Failure when sign-in fails', () async {
      // Arrange
      final failure = Failure('Sign-in failed');
      when(mockAuthRemoteDataSource.signInWithEmailPassword(
              email: "vaibhav@gmial.com", password: "Test@321"))
          .thenThrow(const ServerException('Sign-in failed'));

      // Act
      final result = await authRepositoryImpl.signInWithEmailPassword(
          email: "vaibhav@gmial.com", password: "Test@321");

      // Assert
      expect(result, equals(Left(failure)));
    });
  });

  group('SignUp with Name, Email & Password', () {
    final user =
        UserModel(id: "1", email: "vaibhav@gmial.com", name: "Test@321");
    test('should return User when sign-in is successful', () async {
      // Arrange
      when(mockAuthRemoteDataSource.signUpWithEmailPassword(
              name: 'vaibhav',
              email: 'vaibhav@gmail.com',
              password: 'Test@321'))
          .thenAnswer((_) async => user);
      // Act
      final result = await authRepositoryImpl.signUpWithEmailPassword(
          name: 'vaibhav', email: 'vaibhav@gmail.com', password: 'Test@321');
      // Assert
      expect(result, equals(Right(user)));
    });

    test('should return Failure when sign-in fails', () async {
      // Arrange
      final failure = Failure('Sign-in failed');
      when(mockAuthRemoteDataSource.signUpWithEmailPassword(
              name: 'vaibhav',
              email: 'vaibhav@gmail.com',
              password: 'Test@321'))
          .thenThrow(const ServerException('Sign-in failed'));

      // Act
      final result = await authRepositoryImpl.signUpWithEmailPassword(
          name: 'vaibhav', email: 'vaibhav@gmail.com', password: 'Test@321');

      // Assert
      expect(result, equals(Left(failure)));
    });
  });

  group('_getUser', () {
    test('should return Right with user when connected and function succeeds',
        () async {
      // Arrange
      final user =
          UserModel(id: '1', email: 'vaibhav@gmail.com', name: 'vaibhav');
      when(mockConnectionChecker.isConnected).thenAnswer((_) async => true);

      // Act
      final result = await authRepositoryImpl.getUser(() async => user);

      // Assert
      expect(result, equals(Right(user)));
    });

    test(
        'should return Left with Failure when connected and function throws ServerException',
        () async {
      // Arrange
      when(mockConnectionChecker.isConnected).thenAnswer((_) async => true);
      when(mockConnectionChecker.isConnected).thenAnswer((_) async => true);

      // Act
      final result = await authRepositoryImpl
          .getUser(() async => throw const ServerException('Error'));

      // Assert
      expect(result, equals(Left(Failure('Error'))));
    });

    test('should return Left with Failure when not connected', () async {
      // Arrange
      when(mockConnectionChecker.isConnected).thenAnswer((_) async => false);

      // Act
      final result = await authRepositoryImpl
          .getUser(() async => throw const ServerException('Error'));

      // Assert
      expect(result, equals(Left(Failure('No internet connection'))));
    });
  });
}
