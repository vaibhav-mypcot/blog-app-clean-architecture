import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:blog_app/core/routes/app_route_constants.dart';
import 'package:blog_app/core/routes/app_router.dart';
import 'package:blog_app/core/utils/constants/colors.dart';
import 'package:blog_app/core/utils/constants/image_strings.dart';
import 'package:blog_app/core/utils/constants/validation_mixin.dart';
import 'package:blog_app/core/utils/functions/show_snackbar.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/pages/signin_pag.dart';
import 'package:blog_app/core/common/widgets/custom_textfield.dart';
import 'package:blog_app/features/auth/presentation/widgets/custom_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with ValidationsMixin {
  final signUpKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          // physics: const ClampingScrollPhysics(),
          child: BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
            if (state is AuthFailure) {
              return showSnackBar(
                context,
                "Oh snap!",
                "Something went wrong! Please try again",
                TColors.failedBackgroundColor,
                TColors.failedAssetsColor,
                TImages.failure,
              );
            } else if (state is AuthSuccess) {
              return showSnackBar(
                context,
                "Congratulations!",
                "You have successfully become a member. Welcome to our community!",
                TColors.successBackgroundColor,
                TColors.successAssetsColor,
                TImages.success,
              );
            }
          }, builder: (context, state) {
            if (state is AuthLoading) {
              return const Loader();
            }
            return SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                        height: 198.h,
                        width: 198.w,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: TColors.primary,
                        ),
                      ),
                      SvgPicture.asset(
                        TImages.signUpIllustration,
                        fit: BoxFit.cover,
                        height: 222.h,
                        width: 222.w,
                      )
                    ],
                  ),
                  Text(
                    "Become a member!",
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30.w),
                    child: Form(
                      key: signUpKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //-- User name field

                          SizedBox(height: 16.h),
                          Text(
                            "Your name",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color(0XFF9391A5),
                            ),
                          ),
                          SizedBox(height: 6.h),
                          CustomTextField(
                            controller: nameController,
                            textAlignVertical: TextAlignVertical.bottom,
                            hintText: "Enter your name",
                            suffixIcon: Container(
                              width: double.minPositive,
                              alignment: Alignment.centerLeft,
                              child: Icon(
                                Icons.person_outline,
                                size: 20.h,
                              ),
                            ),
                            hintStyle: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                            validator: validatedName,
                          ),

                          //-- email  field

                          SizedBox(height: 16.h),
                          Text(
                            "E-mail address",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color(0XFF9391A5),
                            ),
                          ),
                          SizedBox(height: 6.h),
                          CustomTextField(
                            controller: emailController,
                            textAlignVertical: TextAlignVertical.bottom,
                            hintText: "Enter your email",
                            suffixIcon: Container(
                              width: double.minPositive,
                              alignment: Alignment.centerLeft,
                              child: Icon(
                                Icons.email_outlined,
                                size: 20.h,
                              ),
                            ),
                            hintStyle: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                            validator: validateEmail,
                          ),

                          //-- password  field

                          SizedBox(height: 16.h),
                          Text(
                            "Password",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color(0XFF9391A5),
                            ),
                          ),
                          SizedBox(height: 6.h),
                          CustomTextField(
                            controller: passwordController,
                            textAlignVertical: TextAlignVertical.bottom,
                            hintText: "Enter your password",
                            suffixIcon: Container(
                              width: double.minPositive,
                              alignment: Alignment.centerLeft,
                              child: Icon(
                                Icons.visibility_outlined,
                                size: 20.h,
                              ),
                            ),
                            hintStyle: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                            validator: validatePassword,
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 18.h),

                  // -- Divider
                  Row(
                    children: [
                      const Expanded(
                        child: Divider(
                          color: Color(0XFFCED4F7),
                          thickness: 1.4,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18.0.w),
                        child: Text(
                          'or',
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey),
                        ),
                      ),
                      const Expanded(
                        child: Divider(
                          color: Color(0XFFCED4F7),
                          thickness: 1.4,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 18.h),

                  //-- social media login

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      iconBox(TImages.googleIc),
                      SizedBox(width: 18.w),
                      iconBox(TImages.facebookIc),
                      SizedBox(width: 18.w),
                      iconBox(TImages.appleIc),
                    ],
                  ),

                  SizedBox(height: 28.h),

                  //-- create ac button

                  CustomButton(
                    label: "Create an account",
                    icons: const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      if (signUpKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(
                              AuthSignUp(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                                name: nameController.text.trim(),
                              ),
                            );
                      }
                    },
                  ),

                  SizedBox(height: 18.h),

                  //--

                  Text.rich(
                    TextSpan(
                      text: "Already hav an account? ",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      children: [
                        TextSpan(
                          text: "Sign in",
                          style: const TextStyle(
                            color: Color(0XFF2F66ED),
                            fontWeight: FontWeight.w600,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const SignInPage()));
                              // GoRouter.of(context)
                              //     .goNamed(MyAppRouteConstants.signInRouteName);

                              // GoRouter.of(context).pushNamed(
                              //     MyAppRouteConstants.signInRouteName);

                              // AppRouter.returnRouter()
                              //     .go(MyAppRouteConstants.signInRouteName);

                              // context
                              //     .goNamed(MyAppRouteConstants.signInRouteName);
                            },
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 18.h),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget iconBox(String icon) {
    return Container(
      padding: EdgeInsets.all(12.h),
      decoration: BoxDecoration(
        color: TColors.primary,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: const Color(0XFFCED4F7),
        ),
      ),
      child: SvgPicture.asset(
        icon,
        fit: BoxFit.cover,
        height: 21.h,
        width: 21.w,
      ),
    );
  }
}
