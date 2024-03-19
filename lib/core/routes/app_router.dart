import 'package:blog_app/core/routes/app_route_constants.dart';
import 'package:blog_app/features/auth/presentation/pages/signin_pag.dart';
import 'package:blog_app/features/auth/presentation/pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  GoRouter router = GoRouter(
    initialLocation: MyAppRouteConstants.signInRouteName,
    routes: [
      GoRoute(
        name: MyAppRouteConstants.signInRouteName,
        path: '/',
        builder: (context, state) {
          // Return the widget for the sign-in page
          return const SignInPage();
        },
      ),
      GoRoute(
        name: MyAppRouteConstants.signUpRouteName,
        path: '/signUpPage',
        builder: (context, state) {
          return const SignUpPage();
        },
      ),
    ],
  );
}
