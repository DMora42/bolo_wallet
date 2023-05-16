import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Constants {
  static Color lightPrimary = Colors.black;
  static Color darkPrimary = Colors.white;
  static Color lightAccent = Colors.blue;
  static Color darkAccent = Colors.blueAccent;
  static Color lightBG = const Color(0xfff8f8f8);
  static Color darkBG = const Color(0xff06090d);

  static ThemeData lightModeTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      elevation: 0.0,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 20,
      ),
    ),
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
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(
        color: Colors.white,
      ),
    ),
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
