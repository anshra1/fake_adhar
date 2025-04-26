import 'package:baby_package/baby_package.dart';
import 'package:fake_adhar/src/core/design_system/colors.dart';
import 'package:flutter/material.dart';

class LightTheme {
  static ThemeData get theme => ThemeData(
        scaffoldBackgroundColor: AppColors.lightBackgroundPrimary,
        brightness: Brightness.light,
        useMaterial3: true,
        elevatedButtonTheme: _elevatedButtonTheme,
        outlinedButtonTheme: _outlinedButtonTheme,
        textButtonTheme: _textButtonTheme,
        inputDecorationTheme: _inputDecorationTheme,
        cardTheme: _cardTheme,
        appBarTheme: _appBarTheme,
        dividerTheme: _dividerTheme,
        dialogTheme: _dialogTheme,
        tooltipTheme: _tooltipTheme,
        colorScheme: const ColorScheme.light(
          primary: AppColors.primaryMain,
          primaryContainer: AppColors.primaryLight,
          secondary: AppColors.secondary,
          secondaryContainer: AppColors.secondaryLight,
          error: AppColors.error,
          onSecondary: AppColors.lightTextInverse,
          onSurface: AppColors.lightTextPrimary,
        ),
        textTheme: TextTheme(
          displayLarge: AppFonts.displayLarge.copyWith(color: AppColors.lightTextPrimary),
          displayMedium:
              AppFonts.displayMedium.copyWith(color: AppColors.lightTextPrimary),
          displaySmall: AppFonts.displaySmall.copyWith(color: AppColors.lightTextPrimary),
          headlineLarge:
              AppFonts.headlineLarge.copyWith(color: AppColors.lightTextPrimary),
          headlineMedium:
              AppFonts.headlineMedium.copyWith(color: AppColors.lightTextPrimary),
          headlineSmall:
              AppFonts.headlineSmall.copyWith(color: AppColors.lightTextPrimary),
          titleLarge: AppFonts.titleLarge.copyWith(color: AppColors.lightTextPrimary),
          titleMedium: AppFonts.titleMedium.copyWith(color: AppColors.lightTextPrimary),
          titleSmall: AppFonts.titleSmall.copyWith(color: AppColors.lightTextPrimary),
          labelLarge: AppFonts.labelLarge.copyWith(color: AppColors.lightTextPrimary),
          labelMedium: AppFonts.labelMedium.copyWith(color: AppColors.lightTextPrimary),
          labelSmall: AppFonts.labelSmall.copyWith(color: AppColors.lightTextPrimary),
          bodyLarge: AppFonts.bodyLarge.copyWith(color: AppColors.lightTextPrimary),
          bodyMedium: AppFonts.bodyMedium.copyWith(color: AppColors.lightTextPrimary),
          bodySmall: AppFonts.bodySmall.copyWith(color: AppColors.lightTextPrimary),
        ),
      );

  // Elevated Button Theme
  static final _elevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 1, // ElevationTokens.level1
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ), // Spacing.md16, Spacing.sm12
      minimumSize: const Size(64, 40), // AppSize.minButtonWidth64, AppSize.buttonMD40
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ), // AppSize.radiusMD8
      backgroundColor: AppColors.primaryMain,
      foregroundColor: AppColors.lightTextInverse,
    ),
  );

  // Outlined Button Theme
  static final _outlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ), // Spacing.md16, Spacing.sm12
      minimumSize: const Size(64, 40), // AppSize.minButtonWidth64, AppSize.buttonMD40
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ), // AppSize.radiusMD8
      side: const BorderSide(color: AppColors.lightBorder),
      foregroundColor: AppColors.lightTextPrimary,
    ),
  );

  // Text Button Theme
  static final _textButtonTheme = TextButtonThemeData(
    style: TextButton.styleFrom(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 4,
      ), // Spacing.sm12, Spacing.xxs4
      minimumSize: const Size(64, 32), // AppSize.minButtonWidth64, AppSize.buttonSM32
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ), // AppSize.radiusMD8
      foregroundColor: AppColors.lightTextPrimary,
    ),
  );

  // Input Decoration Theme
  static final _inputDecorationTheme = InputDecorationTheme(
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 12,
    ), // Spacing.md16, Spacing.sm12
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8), // AppSize.radiusMD8
      borderSide: const BorderSide(color: AppColors.lightBorder),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8), // AppSize.radiusMD8
      borderSide: const BorderSide(color: AppColors.lightBorder),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8), // AppSize.radiusMD8
      borderSide: const BorderSide(color: AppColors.lightBorderFocus, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8), // AppSize.radiusMD8
      borderSide: const BorderSide(color: AppColors.lightBorderError),
    ),
    filled: true,
    fillColor: AppColors.lightBackgroundSecondary,
  );

  // Card Theme
  static final _cardTheme = CardTheme(
    elevation: 1, // ElevationTokens.level1
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ), // AppSize.radiusLG16
    margin: const EdgeInsets.all(12), // Spacing.sm12
    color: AppColors.lightSurface,
  );

  // AppBar Theme
  static const _appBarTheme = AppBarTheme(
    elevation: 0, // ElevationTokens.level0
    centerTitle: true,
    backgroundColor: AppColors.lightSurface,
    foregroundColor: AppColors.lightTextPrimary,
  );

  // Divider Theme
  static const _dividerTheme = DividerThemeData(
    color: AppColors.lightBorder,
    space: 1,
    thickness: 1,
  );

  // Dialog Theme
  static final _dialogTheme = DialogTheme(
    backgroundColor: AppColors.lightSurface,
    elevation: 1, // ElevationTokens.level1
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ), // AppSize.radiusLG16
  );

  // Tooltip Theme
  static final _tooltipTheme = TooltipThemeData(
    textStyle: AppFonts.bodyMedium.copyWith(color: AppColors.lightTextInverse),
    decoration: BoxDecoration(
      color: AppColors.lightOverlay,
      borderRadius: BorderRadius.circular(8), // AppSize.radiusMD8
    ),
  );
}
