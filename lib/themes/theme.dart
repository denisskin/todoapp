import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppTheme {
  static const supportSeparator = Color(0x33000000);
  static const supportOverlay = Color(0x0F000000);

  static const labelPrimary = Color(0xFF000000);
  static const labelSecondary = Color(0x99000000);
  static const labelTertiary = Color(0x4D000000);
  static const labelDisable = Color(0x26000000);

  static const colorRed = Color(0xFFFF3B30);
  static const colorGreen = Color(0xFF34C759);
  static const colorBlue = Color(0xFF007AFF);
  static const colorGray = Color(0xFF8E8E93);
  static const colorGrayLight = Color(0xFFD1D1D6);
  static const colorWhite = Color(0xFFFFFFFF);

  static const backPrimary = Color(0xFFF7F6F2);
  static const backSecondary = Color(0xFFFFFFFF);
  static const backElevated = Color(0xFFFFFFFF);

  static const cbxHighBorder = BorderSide(color: colorRed, width: 2);

  static final lightAppTheme = ThemeData(
    brightness: Brightness.light,
    colorSchemeSeed: backPrimary,
    appBarTheme: const AppBarTheme(
      backgroundColor: backPrimary,
      foregroundColor: labelPrimary,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      foregroundColor: colorWhite,
      backgroundColor: colorBlue,
      shape: CircleBorder(),
    ),
    scaffoldBackgroundColor: backPrimary,
  );

  static final darkAppTheme = ThemeData(
    brightness: Brightness.dark,
    colorSchemeSeed: DarkThemeColors.backSecondary,
    appBarTheme: const AppBarTheme(
      backgroundColor: DarkThemeColors.backPrimary,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      shape: CircleBorder(),
      foregroundColor: DarkThemeColors.colorWhite,
      backgroundColor: DarkThemeColors.colorBlue,
    ),
    scaffoldBackgroundColor: DarkThemeColors.backPrimary,
  );

  static const iconView = Icon(Icons.visibility_sharp, color: colorBlue);
  static const iconViewAll = Icon(Icons.visibility_off, color: colorBlue);

  static const textDone = TextStyle(
    fontSize: 16,
    color: labelTertiary,
  );

  static final appBarHeader = GoogleFonts.roboto(
    fontSize: 32,
    fontWeight: FontWeight.w500,
    color: labelPrimary,
  );

  static final appBarPrimaryButton = GoogleFonts.roboto(
    color: AppTheme.colorBlue,
    fontSize: 16,
  );

  static final regularBodyText = GoogleFonts.roboto(
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  static final regularHintText = GoogleFonts.roboto(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppTheme.labelTertiary,
  );

  static final buttonNewTask = GoogleFonts.roboto(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: labelSecondary,
  );

  static final itemRegularTextStyle = GoogleFonts.roboto(
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  static final itemCompletedTextStyle = GoogleFonts.roboto(
    color: labelTertiary,
    decoration: TextDecoration.lineThrough,
    decorationColor: labelTertiary,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  static TextStyle smallBodyText = GoogleFonts.roboto(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static TextStyle smallSecondaryText = GoogleFonts.roboto(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: labelTertiary,
  );
}

abstract class DarkThemeColors {
  static const supportSeparator = Color(0x33FFFFFF);
  static const supportOverlay = Color(0x52000000);
  static const labelPrimary = Color(0xFFFFFFFF);
  static const labelSecondary = Color(0x99FFFFFF);
  static const labelTertiary = Color(0x66FFFFFF);
  static const labelDisable = Color(0x26FFFFFF);
  static const colorRed = Color(0xFFFF453A);
  static const colorGreen = Color(0xFF32D74B);
  static const colorBlue = Color(0xFF0A84FF);
  static const colorGray = Color(0xFF8E8E93);
  static const colorGrayLight = Color(0xFF48484A);
  static const colorWhite = Color(0xFFFFFFFF);
  static const backPrimary = Color(0xFF161618);
  static const backSecondary = Color(0xFF252528);
  static const backElevated = Color(0xFF3C3C3F);
  static const customHighImportance = Color.fromRGBO(68, 43, 43, 1.0);
}
