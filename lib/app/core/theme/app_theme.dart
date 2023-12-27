import 'package:flutter/material.dart';

import '../values/app_colors.dart';
import 'text_theme.dart';

class AppTheme {
  /// Light Theme
  ThemeData lightTheme = ThemeData.light().copyWith(
    useMaterial3: true,
    brightness: Brightness.light,
    backgroundColor: Colors.white,
    primaryColor: Colors.blue,
    bottomAppBarTheme: BottomAppBarTheme(color: Colors.red),
    textTheme: TextTheme(
      displayLarge: AppTextStyleLight.displayLarge,
      displayMedium: AppTextStyleLight.displayMedium,
      displaySmall: AppTextStyleLight.displaySmall,
      headlineMedium: AppTextStyleLight.headlineMedium,
      headlineSmall: AppTextStyleLight.headlineSmall,
      titleLarge: AppTextStyleLight.titleLarge,
      titleMedium: AppTextStyleLight.titleMedium,
      titleSmall: AppTextStyleLight.titleSmall,
      bodyLarge: AppTextStyleLight.bodyLarge,
      bodyMedium: AppTextStyleLight.bodyMedium,
      bodySmall: AppTextStyleLight.bodySmall,
      labelLarge: AppTextStyleLight.labelLarge,
      labelSmall: AppTextStyleLight.labelSmall,
    ),
    iconTheme: IconThemeData(color: AppColors.grey, size: 25.0),
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.blue,
      disabledColor: Colors.grey,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.white,
      titleTextStyle: const TextStyle(color: Colors.black),
    ),
    drawerTheme: DrawerThemeData(
      backgroundColor: AppColors.white,
    ),
  );

  /// Dark Theme
  ThemeData darkTheme = ThemeData.dark().copyWith(
    useMaterial3: true,
    brightness: Brightness.dark,
    backgroundColor: Colors.black,
    primaryColor: Colors.amber,
    textTheme: TextTheme(
      displayLarge: AppTextStyleDark.displayLarge,
      displayMedium: AppTextStyleDark.displayMedium,
      displaySmall: AppTextStyleDark.displaySmall,
      headlineMedium: AppTextStyleDark.headlineMedium,
      headlineSmall: AppTextStyleDark.headlineSmall,
      titleLarge: AppTextStyleDark.titleLarge,
      titleMedium: AppTextStyleDark.titleMedium,
      titleSmall: AppTextStyleDark.titleSmall,
      bodyLarge: AppTextStyleDark.bodyLarge,
      bodyMedium: AppTextStyleDark.bodyMedium,
      bodySmall: AppTextStyleDark.bodySmall,
      labelLarge: AppTextStyleDark.labelLarge,
      labelSmall: AppTextStyleDark.labelSmall,
    ),
    iconTheme: IconThemeData(color: AppColors.white, size: 25.0),
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.amber,
      disabledColor: Colors.grey,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.black,
      titleTextStyle: const TextStyle(color: Colors.white),
    ),
    drawerTheme: DrawerThemeData(
      backgroundColor: Colors.grey.shade800,
    ),
  );
}
