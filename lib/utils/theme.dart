import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  //  primary and secondary colors
  static final Color primaryColor = Colors.orange[400]!;
  static final Color cardColor = Color.fromARGB(255, 255, 255, 255)!;

  static const Color secondaryColor = Color(0xff232220);
  static const Color goldTextColor = Color(0xffA5957E);

  //  make text sizes responsive
  static double _responsiveTextSize(double size, BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return size *
        (screenWidth /
            375.0); // Assuming 375 is the base screen width (e.g., iPhone 11)
  }

  // Function to create responsive icon size
  static double _responsiveIconSize(double size, BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return size * (screenWidth / 375.0); // Adjust based on screen width
  }

  // Define the light theme
  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: Colors.white,
      cardColor: cardColor,
      colorScheme: ColorScheme.light(
        primary: primaryColor,
        secondary: secondaryColor,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          size: _responsiveIconSize(24, context), // Responsive icon size
        ),
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: _responsiveTextSize(20, context), // Responsive title size
          fontWeight: FontWeight.bold,
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryColor,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: secondaryColor,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey,
        selectedIconTheme: IconThemeData(
          size: _responsiveIconSize(30, context), // Responsive icon size
        ),
        unselectedIconTheme: IconThemeData(
          size: _responsiveIconSize(24, context),
        ),
      ),
      textTheme: GoogleFonts.montserratTextTheme(
        TextTheme(
          bodyLarge: TextStyle(
            color: Colors.black,
            fontSize: _responsiveTextSize(16, context), // Responsive text size
          ),
          bodyMedium: TextStyle(
            color: Colors.black54,
            fontSize: _responsiveTextSize(14, context),
          ),
          labelSmall: TextStyle(
            color: goldTextColor,
            fontSize: _responsiveTextSize(11, context),
          ),
          labelMedium: TextStyle(
            color: goldTextColor,
            fontSize: _responsiveTextSize(22, context),
            fontWeight: FontWeight.w500,
          ),
          titleLarge: TextStyle(
            color: Colors.white,
            fontSize: _responsiveTextSize(35, context),
            fontWeight: FontWeight.w800,
          ),
          titleMedium: TextStyle(
            color: Colors.white,
            fontSize: _responsiveTextSize(
              23,
              context,
            ),
            fontWeight: FontWeight.w500,
          ),
          titleSmall: TextStyle(
            color: Colors.white,
            fontSize: _responsiveTextSize(16, context),
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: primaryColor,
      ),
      iconTheme: IconThemeData(
        color: Colors.white,
        size: _responsiveIconSize(24, context), // Default icon size
      ),
    );
  }
}