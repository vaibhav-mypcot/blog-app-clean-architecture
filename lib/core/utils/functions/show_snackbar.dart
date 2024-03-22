import 'package:blog_app/features/auth/presentation/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String title, String subTitle,
    Color containerBackColor, Color assetColor, String typeImage) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: CustomSnackbar(
        title: title,
        subTitle: subTitle,
        containerBackColor: containerBackColor,
        assetColor: assetColor,
        typeImage: typeImage,
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
      duration: const Duration(seconds: 5),
    ),
  );
}
