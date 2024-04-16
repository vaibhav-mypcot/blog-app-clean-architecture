import 'package:blog_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/core/utils/theme/app_theme.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/pages/signin_pag.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_app/features/blog/presentation/pages/blog_page.dart';
import 'package:blog_app/features/pagingnation/presentation/bloc/user_data_bloc.dart';
import 'package:blog_app/features/pagingnation/presentation/pages/users_list_screen.dart';
import 'package:blog_app/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<UserDataBloc>(
            create: (BuildContext context) => UserDataBloc()),
        BlocProvider(create: (_) => serviceLocator<AppUserCubit>()),
        BlocProvider(create: (_) => serviceLocator<AuthBloc>()),
        BlocProvider(create: (_) => serviceLocator<BlogBloc>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<AuthBloc>().add(AuthIsUserLoggedIn());
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      ensureScreenSize: true,
      useInheritedMediaQuery: true,
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Blog App',
        themeMode: ThemeMode.system,
        theme: TAppTheme.lightTheme,
        home: const UsersListScreen(),
        // home: BlocSelector<AppUserCubit, AppUserState, bool>(
        //   selector: (state) {
        //     return state is AppUserLoggedIn;
        //   },
        //   builder: (context, isLoggedIn) {
        //     if (isLoggedIn) {
        //       return const BlogPage();
        //     }
        //     return const SignInPage();
        //   },
        // ),
        // routeInformationParser: AppRouter.returnRouter().routeInformationParser,
        // routeInformationProvider:
        //     AppRouter.returnRouter().routeInformationProvider,
        // routerDelegate: AppRouter.returnRouter().routerDelegate,
        // routerConfig: AppRouter.returnRouter(),
      ),
    );
  }
}
