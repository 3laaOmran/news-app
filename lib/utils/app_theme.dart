import 'package:flutter/material.dart';
import 'package:news_app/utils/app_colors.dart';
import 'package:news_app/utils/text_styles.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.whiteColor,
    drawerTheme: const DrawerThemeData(
      backgroundColor: AppColors.blackColor,
    ),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: AppColors.whiteColor,
      iconTheme: const IconThemeData(
        color: AppColors.blackColor,
      ),
      titleTextStyle: TextStyles.medium20Black,
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyles.bold16Black,
      bodyMedium: TextStyles.medium14Black
    ),
    indicatorColor: AppColors.blackColor,
  );
  static final ThemeData darkTheme = ThemeData(
      scaffoldBackgroundColor: AppColors.blackColor,
      drawerTheme: const DrawerThemeData(
        backgroundColor: AppColors.blackColor,
      ),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        backgroundColor: AppColors.blackColor,
        iconTheme: const IconThemeData(
          color: AppColors.whiteColor,
        ),
        titleTextStyle: TextStyles.medium20White,
      ),
    textTheme: TextTheme(
        bodyLarge: TextStyles.bold16White,
        bodyMedium: TextStyles.medium14White
    ),
    indicatorColor: AppColors.whiteColor,
  );
}
