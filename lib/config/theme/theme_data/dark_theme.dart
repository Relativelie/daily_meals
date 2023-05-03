import 'package:daily_meals/config/theme/templates/colors.dart';
import 'package:daily_meals/config/theme/templates/text_styles.dart';
import 'package:flutter/material.dart';


final ThemeData darkTheme = ThemeData().copyWith(
    primaryColor: themeColors["orange2"],
    highlightColor: themeColors["coffee"],
    unselectedWidgetColor: themeColors["white"],
    appBarTheme: AppBarTheme(color: themeColors["coffee"]),
    progressIndicatorTheme:
        ProgressIndicatorThemeData(color: themeColors["coffee"]),
    textTheme: TextTheme(
      titleLarge: TextStyles.titleLarge.copyWith(color: themeColors["white"]),
      titleMedium: TextStyles.titleMedium.copyWith(color: themeColors["white"]),
      titleSmall: TextStyles.titleSmall.copyWith(color: themeColors["white"]),
      bodyLarge: TextStyles.bodyLarge.copyWith(color: themeColors["white"]),
      bodyMedium: TextStyles.bodyMedium.copyWith(color: themeColors["white"]),
      bodySmall: TextStyles.bodySmall.copyWith(color: themeColors["white"]),
      headlineSmall:
          TextStyles.bodyLargeCursive.copyWith(color: themeColors["white"]),
    ),
    colorScheme: const ColorScheme.dark().copyWith(
      background: themeColors["coffee3"],
      onBackground: themeColors["black"],
      secondary: themeColors["coffee2"],
      onPrimary: themeColors["white"],
      primary: themeColors["coffee"],
      error: themeColors["red"],
    ));
