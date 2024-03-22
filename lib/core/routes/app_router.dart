import 'package:blog_app/core/routes/app_route_constants.dart';
import 'package:blog_app/features/auth/presentation/pages/signin_pag.dart';
import 'package:blog_app/features/auth/presentation/pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static GoRouter returnRouter() {
    return GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          name: MyAppRouteConstants.signInRouteName,
          path: '/',
          pageBuilder: (context, state) {
            return const MaterialPage(child: SignInPage());
          },
        ),
        GoRoute(
          name: MyAppRouteConstants.signUpRouteName,
          path: '/signUpPage',
          pageBuilder: (context, state) {
            return const MaterialPage(child: SignUpPage());
          },
        ),
      ],
    );
  }
}
