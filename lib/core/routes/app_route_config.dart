import 'package:blog_app/core/routes/app_route_constants.dart';
import 'package:blog_app/features/auth/presentation/pages/signin_pag.dart';
import 'package:blog_app/features/auth/presentation/pages/signup_page.dart';
import 'package:go_router/go_router.dart';

class MyAppRoutes {
  GoRouter router = GoRouter(
    routes: [
      GoRoute(
          name: MyAppRouteConstants.signInRouteName,
          path: '/signInPage',
          builder: (context, state) {
            return const SignInPage();
          }),
      GoRoute(
        name: MyAppRouteConstants.signUpRouteName,
        path: '/',
        builder: (context, state) {
          return const SignUpPage();
        },
      ),
    ],
  );
}
