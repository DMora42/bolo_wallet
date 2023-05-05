import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Constants {
  static Color lightPrimary = Color(0xfffcfcff);
  static Color darkPrimary = Colors.black;
  static Color lightAccent = Colors.blue;
  static Color darkAccent = Colors.blueAccent;
  static Color lightBG = Color(0xfffcfcff);
  static Color darkBG = Colors.black;

  static ThemeData lightModeTheme = ThemeData(
    brightness: Brightness.light,
    backgroundColor: lightBG,
    primaryColor: lightPrimary,
    secondaryHeaderColor: const Color(0xff3b22a1),
    textTheme: TextTheme(
      bodyMedium: GoogleFonts.poppins(color: Colors.black),
    ),
    cardColor: Colors.white,
  );

  static ThemeData darkModeTheme = ThemeData(
    brightness: Brightness.dark,
    backgroundColor: darkBG,
    primaryColor: darkPrimary,
    secondaryHeaderColor: const Color(0xff3b22a1),
    textTheme: TextTheme(
      bodyMedium: GoogleFonts.poppins(color: Colors.white),
    ),
    cardColor: const Color(0xff070606),
  );
}
