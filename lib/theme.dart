import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  final infoIconColor = const Color(0x33000000);

  static final AppTheme themeLight = AppTheme();
  static final AppTheme themeDark = AppThemeDark();

  static AppTheme of(BuildContext context) {
    //final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? themeDark : themeLight;
  }
}

class AppThemeDark extends AppTheme {
  final infoIconColor = const Color(0x33000000);
}

abstract class MyTheme {
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
    // useMaterial3: true,
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
    useMaterial3: true,
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

  static final textAppBar = GoogleFonts.roboto(
    fontSize: 32.0,
    fontWeight: FontWeight.w500,
    color: labelPrimary,
  );
  static final buttonNewTask = GoogleFonts.roboto(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: labelSecondary,
  );

  static const textAppbarPrimaryButton = TextStyle(
    color: MyTheme.colorBlue,
    fontSize: 16,
  );

  static const infoIcon = Icon(
    Icons.info_outline,
    color: labelTertiary,
    size: 27,
  );

  static final itemRegularTextStyle = GoogleFonts.roboto(
    fontSize: 18.0,
    fontWeight: FontWeight.w400,
  );
  static final itemCompletedTextStyle = GoogleFonts.roboto(
    color: labelTertiary,
    decoration: TextDecoration.lineThrough,
    decorationColor: labelTertiary,
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
    fontSize: 32,
    fontWeight: FontWeight.w500,
  );

  static TextStyle listTextStyle = GoogleFonts.roboto(
    fontSize: 18,
    fontWeight: FontWeight.w400,
  );

  static TextStyle appbarActionTextStyle = GoogleFonts.roboto(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  static TextStyle regularBodyText = GoogleFonts.roboto(
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  static TextStyle regularHintText = GoogleFonts.roboto(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: MyTheme.labelTertiary,
  );

  static TextStyle smallBodyText = GoogleFonts.roboto(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );
}
