import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/colors.dart';

class TextStyles {
  final ThemeData textTheme = ThemeData(
    fontFamily: GoogleFonts.oxygen().fontFamily,
    textTheme: const TextTheme(
      ///
      headlineLarge: TextStyle(
        fontSize: 33,
        fontWeight: FontWeight.w700,
        color: AppColors.secondaryColor,
      ),
      headlineMedium: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.w700,
        color: AppColors.secondaryColor,
      ),
      headlineSmall: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.w700,
        color: AppColors.secondaryColor,
      ),
      titleLarge: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.w600,
        color: AppColors.secondaryColor,
      ),
      titleMedium: TextStyle(
        fontSize: 20.63,
        fontWeight: FontWeight.w400,
        color: AppColors.secondaryColor,
      ),
      titleSmall: TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.w400,
        color: AppColors.secondaryColor,
      ),
      bodyLarge: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
        color: AppColors.secondaryColor,
      ),
      bodyMedium: TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.normal,
        color: AppColors.secondaryColor,
      ),
      bodySmall: TextStyle(
        fontSize: 8.0,
        fontWeight: FontWeight.w500,
        color: AppColors.secondaryColor,
      ),
      labelLarge: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.w500,
        color: AppColors.secondaryColor,
      ),
      labelMedium: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
        color: AppColors.secondaryColor,
      ),
      labelSmall: TextStyle(
        fontSize: 8.0,
        fontWeight: FontWeight.normal,
        color: AppColors.secondaryColor,
      ),
    ),
  );
}
