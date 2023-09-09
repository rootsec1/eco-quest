import 'package:ecoquest/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

const Color primaryColor = Color(0xFF651fff);
const Color backgroundColor = Color(0xFFF8F4EF);
const Color defaultTextColor = Color(0xFF212121);

final ThemeData appTheme = ThemeData(
  colorScheme: const ColorScheme.light().copyWith(
    primary: primaryColor,
    secondary: backgroundColor,
    background: backgroundColor,
  ),
  cardTheme: const CardTheme(
    surfaceTintColor: backgroundColor,
    color: Colors.white,
  ),
  useMaterial3: true,
  primaryColor: primaryColor,
  secondaryHeaderColor: backgroundColor,
  scaffoldBackgroundColor: backgroundColor,
  fontFamily: GoogleFonts.poppins().fontFamily,
  textTheme: TextTheme(
    bodyLarge: GoogleFonts.poppins(),
    bodyMedium: GoogleFonts.poppins(),
    titleMedium: GoogleFonts.poppins(),
  ).apply(
    bodyColor: defaultTextColor,
    displayColor: defaultTextColor,
  ),
  textSelectionTheme: const TextSelectionThemeData(cursorColor: primaryColor),
  inputDecorationTheme: const InputDecorationTheme(
    counterStyle: TextStyle(
      fontSize: 10,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(standardSeparation / 2)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: primaryColor),
      borderRadius: BorderRadius.all(Radius.circular(standardSeparation / 2)),
    ),
  ),
  appBarTheme: const AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle.dark,
    backgroundColor: Colors.transparent,
    surfaceTintColor: backgroundColor,
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: backgroundColor,
    surfaceTintColor: backgroundColor,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: primaryColor,
  ),
  dialogTheme: const DialogTheme(
    backgroundColor: backgroundColor,
    surfaceTintColor: backgroundColor,
  ),
  timePickerTheme: const TimePickerThemeData(backgroundColor: backgroundColor),
  navigationBarTheme: const NavigationBarThemeData(
    backgroundColor: backgroundColor,
    surfaceTintColor: backgroundColor,
    indicatorColor: primaryColor,
    elevation: standardSeparation,
    shadowColor: Colors.black,
  ),
  snackBarTheme: const SnackBarThemeData(
    backgroundColor: defaultTextColor,
    actionTextColor: primaryColor,
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    circularTrackColor: Colors.transparent,
    linearTrackColor: Colors.transparent,
  ),
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: <TargetPlatform, PageTransitionsBuilder>{
      TargetPlatform.android: ZoomPageTransitionsBuilder(),
    },
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      iconColor: MaterialStateProperty.all(backgroundColor),
      backgroundColor: MaterialStateProperty.all(primaryColor),
      foregroundColor: MaterialStateProperty.all(backgroundColor),
    ),
  ),
);
