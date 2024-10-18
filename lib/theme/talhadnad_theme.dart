import 'package:flutter/material.dart';

const Color oxfordBlue = Color(0xFF042F40);
const Color mountainMeadow = Color(0xFF1FBF83);
const Color zomp = Color(0xFF36A690);
const Color prussianBlue = Color(0xFF03314B);
const Color white = Color.fromARGB(255, 245, 245, 245);

double getResponsiveFontSize(BuildContext context, double baseSize,
    {double maxSize = 10}) {
  double screenWidth = MediaQuery.of(context).size.width;
  double baseScreenWidth = 430.0;
  double calculatedSize = baseSize * (screenWidth / baseScreenWidth);
  return calculatedSize > maxSize ? maxSize : calculatedSize;
}

ThemeData customTheme(BuildContext context) {
  return ThemeData(
    primaryColor: prussianBlue,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: mountainMeadow,
    ),
    scaffoldBackgroundColor: prussianBlue,
    textTheme: TextTheme(
      labelLarge: TextStyle(
        fontSize: getResponsiveFontSize(context, 32, maxSize: 40),
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontFamily: 'Quicksand',
      ),
      labelMedium: TextStyle(
        fontSize: getResponsiveFontSize(context, 24, maxSize: 30),
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontFamily: 'Quicksand',
      ),
      labelSmall: TextStyle(
        fontSize: getResponsiveFontSize(context, 15, maxSize: 20),
        fontWeight: FontWeight.normal,
        fontFamily: 'Quicksand',
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: oxfordBlue,
      titleTextStyle: TextStyle(
          color: mountainMeadow,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontFamily: 'Quicksand'),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(mountainMeadow),
        foregroundColor: WidgetStateProperty.all(Colors.white),
      ),
    ),
  );
}

ThemeData whiteTheme(BuildContext context) {
  return ThemeData(
    primaryColor: const Color(0xFFf0f1f3),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: mountainMeadow, // Include the secondary color
    ),
    scaffoldBackgroundColor: Colors.white, // Set the background color to white
    textTheme: TextTheme(
      labelLarge: TextStyle(
        fontSize: getResponsiveFontSize(context, 32, maxSize: 40),
        color: oxfordBlue, // Set text color to oxfordBlue
        fontWeight: FontWeight.bold,
        fontFamily: 'Quicksand',
      ),
      labelMedium: TextStyle(
        fontSize: getResponsiveFontSize(context, 24, maxSize: 30),
        color: oxfordBlue, // Set text color to oxfordBlue
        fontWeight: FontWeight.bold,
        fontFamily: 'Quicksand',
      ),
      labelSmall: TextStyle(
        fontSize: getResponsiveFontSize(context, 15, maxSize: 20),
        color: oxfordBlue, // Set text color to oxfordBlue
        fontWeight: FontWeight.normal,
        fontFamily: 'Quicksand',
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: oxfordBlue, // Keep AppBar color consistent
      titleTextStyle: TextStyle(
        color: Colors.white, // AppBar title text color
        fontSize: 20,
        fontWeight: FontWeight.bold,
        fontFamily: 'Quicksand',
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor:
            WidgetStateProperty.all(mountainMeadow), // Button background color
        foregroundColor:
            WidgetStateProperty.all(Colors.white), // Button text color
      ),
    ),
  );
}
