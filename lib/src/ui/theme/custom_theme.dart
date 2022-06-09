import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// De existir multiples temas en la aplicacion este sería el lugar idoneo para ponerlos
class CustomTheme {
  static const Color primaryColor = Color(0xFF2ecc71);
  static const Color errorColor = Colors.red;
  static const Color warningColor = Colors.yellow;
  static const Color inputBackground = Color(0xFFf5f5f5);
  static const Color scaffoldBackGround = Colors.white;
  static const Color disabledColor = Color(0xFFf0efef);
  static const Color greyTextColor = Color(0xFF888888);
  static const String loremIpsum =
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.";

  static ThemeData get lightTheme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        primary: primaryColor,
      ),
      primaryColor: primaryColor,
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: primaryColor,
      ),
      scaffoldBackgroundColor: Colors.white,
      textTheme: defaultMaterialTextTheme,
      inputDecorationTheme: defaultInputDecorationTheme,
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          primary: primaryColor,
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 5,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            side: BorderSide(
              color: primaryColor,
              width: 2,
            ),
          ),
        ).copyWith(
          side: MaterialStateProperty.resolveWith<BorderSide>(
            (Set<MaterialState> states) {
              return const BorderSide(
                color: primaryColor,
                width: 2,
              );
            },
          ),
        ),
      ),
    );
  }

  static InputDecorationTheme get defaultInputDecorationTheme {
    return InputDecorationTheme(
      fillColor: inputBackground,
      filled: true,
      floatingLabelStyle: MaterialStateTextStyle.resolveWith(
        (states) {
          if (states.contains(MaterialState.error)) {
            return defaultMaterialTextTheme.bodyText1!.copyWith(
              color: errorColor,
            );
          }
          if (states.contains(MaterialState.focused)) {
            return defaultMaterialTextTheme.bodyText1!.copyWith(
              color: primaryColor,
            );
          }

          return defaultMaterialTextTheme.bodyText1!;
        },
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        borderSide: BorderSide(
          style: BorderStyle.none,
        ),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        borderSide: BorderSide(
          style: BorderStyle.none,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: const BorderSide(
          style: BorderStyle.none,
        ),
      ),
    );
  }

  static TextTheme get defaultMaterialTextTheme {
    return TextTheme(
      headline1: GoogleFonts.poppins(
        fontSize: 93,
        fontWeight: FontWeight.w300,
        letterSpacing: -1.5,
        color: Colors.black,
      ),
      headline2: GoogleFonts.poppins(
        fontSize: 58,
        fontWeight: FontWeight.w300,
        letterSpacing: -0.5,
        color: Colors.black,
      ),
      headline3: GoogleFonts.poppins(
        fontSize: 46,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),
      headline4: GoogleFonts.poppins(
        fontSize: 33,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        color: Colors.black,
      ),
      headline5: GoogleFonts.poppins(
        fontSize: 23,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),
      headline6: GoogleFonts.poppins(
        fontSize: 19,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
        color: Colors.black,
      ),
      subtitle1: GoogleFonts.poppins(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15,
        color: Colors.black,
      ),
      subtitle2: GoogleFonts.poppins(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        color: Colors.black,
      ),
      bodyText1: GoogleFonts.openSans(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        color: Colors.black,
      ),
      bodyText2: GoogleFonts.openSans(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        color: Colors.black,
      ),
      button: GoogleFonts.openSans(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.5,
      ),
      caption: GoogleFonts.openSans(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        color: Colors.black,
      ),
      overline: GoogleFonts.openSans(
        fontSize: 10,
        fontWeight: FontWeight.w400,
        letterSpacing: 1.5,
        color: Colors.black,
      ),
    );
  }
}
