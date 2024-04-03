import 'package:blog_app/core/network/connection_checker.dart';
import 'package:blog_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:blog_app/features/auth/domain/usecases/current_user.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_in.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:mockito/annotations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@GenerateMocks(
  [
    // data source from data layer
    AuthRemoteDataSource,
    // repository from domain layer
    AuthRepository,
    // use cases from domain layer
    CurrentUser,
    UserSignIn,
    UserSignUp,
    //--
    ConnectionChecker,
    SupabaseClient,
    Session,
  ],
)
void main() {}
