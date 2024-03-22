import 'package:blog_app/core/utils/constants/colors.dart';
import 'package:blog_app/core/utils/theme/custom_themes/appbar_theme.dart';
import 'package:blog_app/core/utils/theme/custom_themes/chep_theme.dart';
import 'package:blog_app/core/utils/theme/custom_themes/tabbar_theme.dart';
import 'package:blog_app/core/utils/theme/custom_themes/text_theme.dart';
import 'package:flutter/material.dart';

class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    fontFamily: 'helvetica-regular',
    primaryColor: TColors.primary,
    scaffoldBackgroundColor: Colors.white,
    textTheme: TTextTheme.lightTextTheme,
    appBarTheme: TAppbarTheme.lightAppbarTheme,
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: TColors.primary.withOpacity(0.3),
      selectionHandleColor: TColors.primary,
    ),
    tabBarTheme: TTabBarTheme.lightTabBarTheme,
    chipTheme: TChipThemeData.lightAppbarTheme,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    fontFamily: 'helvetica-regular',
    primaryColor: TColors.primary,
    scaffoldBackgroundColor: TColors.blackBg,
    textTheme: TTextTheme.darkTextTheme,
    appBarTheme: TAppbarTheme.darkAppbarTheme,
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: TColors.primary.withOpacity(0.3),
      selectionHandleColor: TColors.primary,
    ),
    tabBarTheme: TTabBarTheme.darkTabBarTheme,
    chipTheme: TChipThemeData.darkAppbarTheme,
  );
}
