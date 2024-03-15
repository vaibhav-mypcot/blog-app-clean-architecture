import 'package:blog_app/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';


class TTabBarTheme {
  // -- Light Theme
  static TabBarTheme lightTabBarTheme = const TabBarTheme(
    indicatorColor: TColors.white,
    dividerColor: Colors.transparent,
    labelColor: TColors.white,
    unselectedLabelColor: Colors.grey,
  );

  // -- Dark Theme
  static TabBarTheme darkTabBarTheme = const TabBarTheme(
    indicatorColor: TColors.primary,
    dividerColor: Colors.transparent,
    labelColor: TColors.primary,
    unselectedLabelColor: Colors.grey,
  );
}
