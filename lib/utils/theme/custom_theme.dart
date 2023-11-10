import 'package:flutter/material.dart';

import 'custom_color.dart';

class CustomTheme {
  static ThemeData theme() {
    return ThemeData(
      colorScheme: ColorScheme(
        onPrimary: CustomColor.primaryColorLighter,
        primary: CustomColor.primaryColorDefault,
        secondary: CustomColor.secondaryColorDefault,
        onSurface: CustomColor.blackColor,
        surface: CustomColor.secondaryColorDefault,
        onSecondary: CustomColor.secondaryColorLighter,
        error: CustomColor.colorError,
        shadow: CustomColor.greyLight,
        tertiary: CustomColor.blackColor,
        onTertiary: CustomColor.bgColorDefault,
        background: CustomColor.bgColorDefault,
        onError: CustomColor.blackColor,
        onBackground: CustomColor.bgColorDefault,
        brightness: Brightness.light,
        outline: CustomColor.greyLight,
      ),
      useMaterial3: true,
      scaffoldBackgroundColor: CustomColor.bgColorDefault,
      appBarTheme: AppBarTheme(
        backgroundColor: CustomColor.primaryColorDefault,
        iconTheme: IconThemeData(
          color: CustomColor.bgColorDefault,
        ),
      ),
      textTheme: TextTheme(
        bodySmall: TextStyle(
          color: CustomColor.textColorDefault,
          fontSize: 14,
        ),
        bodyMedium: TextStyle(
          color: CustomColor.textColorDefault,
          fontSize: 16,
        ),
        bodyLarge: TextStyle(
          color: CustomColor.bgColorDefault,
          fontSize: 18,
        ),
      ),
    );
  }
}
