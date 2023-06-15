import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  final infoIconColor = const Color(0x33000000);
}

class AppThemeDark extends AppTheme {
  final infoIconColor = const Color(0x33000000);
}

final AppTheme themeLight = AppTheme();
final AppTheme themeDark = AppThemeDark();

AppTheme currTheme(BuildContext context) {
  //final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
  final isDark = Theme.of(context).brightness == Brightness.dark;
  return isDark ? themeDark : themeLight;
}

abstract class MyTheme {
  //app
  static final appTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
  );

  static const cbxActiveColor = Colors.green;
  static const cbxHighBorder = BorderSide(color: Colors.red, width: 2);

  static const supportSeparator = Color(0x33000000);
  static const supportOverlay = Color(0x0F000000);
  static const labelPrimary = Color(0xFF000000);
  static const labelSecondary = Color(0x99000000);
  static const labelTertiaryColor = Color(0x4D000000);

  static const infoIconColor = Color(0x4D000000);

  static const infoIcon = Icon(
    Icons.info_outline,
    color: infoIconColor,
    size: 27,
  );

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
  static const customHighImportance = Color.fromRGBO(250, 225, 223, 1.0);

  static final itemRegularTextStyle = GoogleFonts.roboto(
    fontSize: 18.0,
    fontWeight: FontWeight.w400,
  );
  static final itemCompletedTextStyle = GoogleFonts.roboto(
    color: Color(0x4D000000), //LightThemeColors.labelTertiary,
    decoration: TextDecoration.lineThrough,
    decorationColor: Color(0x4D000000), // LightThemeColors.labelTertiary,
    fontSize: 18.0,
    fontWeight: FontWeight.w400,
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

abstract class AppTextStyles {
  static TextStyle appBarTextStyle = GoogleFonts.roboto(
    fontSize: 32.0,
    fontWeight: FontWeight.w500,
  );

  static TextStyle listTextStyle = GoogleFonts.roboto(
    fontSize: 18.0,
    fontWeight: FontWeight.w400,
  );

  static TextStyle appbarAcionTextStyle = GoogleFonts.roboto(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
  );

  static TextStyle regylarBodyText = GoogleFonts.roboto(
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
  );

  static TextStyle smallBodyText = GoogleFonts.roboto(
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
  );
}
