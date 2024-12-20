import 'package:flutter/material.dart';

import '../core.dart';

final themeData = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.kPrimaryColor,
    primary: AppColors.kPrimaryColor,
    onPrimary: Colors.red,
    secondary: Colors.red,
    onSecondary: Colors.white,
  ),
  scaffoldBackgroundColor: AppColors.kBgColor,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.kPrimaryColor,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    ),
  ),
  iconButtonTheme: IconButtonThemeData(
    style: IconButton.styleFrom(
      foregroundColor: AppColors.kPrimaryColor,
    ),
  ),
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    elevation: 0,
    backgroundColor: AppColors.kBgColor,
    foregroundColor: Colors.black,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: AppColors.kNavBarColor,
    type: BottomNavigationBarType.fixed,
    showSelectedLabels: false,
    showUnselectedLabels: false,
    selectedIconTheme: IconThemeData(color: AppColors.kSelectedColor),
    unselectedIconTheme: IconThemeData(color: AppColors.kUnselectedColor),
    elevation: 0,
  ),
  textTheme: const TextTheme(
    titleMedium: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18,
    ),
    bodyLarge: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 16,
    ),
    bodyMedium: TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 14,
    ),
    bodySmall: TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 12,
    ),
  ),
  useMaterial3: true,
);
