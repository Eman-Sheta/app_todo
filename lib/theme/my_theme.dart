import 'package:flutter/material.dart';

class MyTheme {
  static Color backgroundlight = Color(0xffDFECDB);
  static Color primarylight = Color(0xff5D9CEC);
  static Color greencolor = Color(0xff61E757);
  static Color redcolor = Color(0xffE43737);
  static Color blackcolor = Color(0xff060E1E);
  static Color greycolor = Color.fromARGB(255, 85, 85, 85);
  static Color whitecolor = Color(0xffFFFFFF);
  static Color primarydark = Color(0xff141922);
  static Color backgrounddark = Color(0xff060E1E);
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: backgroundlight,
    appBarTheme: AppBarTheme(
      backgroundColor: primarylight,
      elevation: 0,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedItemColor: primarylight,
        unselectedItemColor: greycolor),
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: primarylight),
    bottomSheetTheme: BottomSheetThemeData(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
      topLeft: Radius.circular(18),
      topRight: Radius.circular(18),
    ))),
    textTheme: TextTheme(
        titleLarge: TextStyle(
            fontSize: 22, fontWeight: FontWeight.bold, color: whitecolor),
        titleMedium: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: blackcolor),
        titleSmall: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: blackcolor)),
  );
  static ThemeData darkMode = ThemeData(
    scaffoldBackgroundColor: backgrounddark,
    appBarTheme: AppBarTheme(
      backgroundColor: primarylight,
      elevation: 0,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedItemColor: primarylight,
        unselectedItemColor: whitecolor),
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: primarylight),
    bottomSheetTheme: BottomSheetThemeData(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18), topRight: Radius.circular(18)))),
    textTheme: TextTheme(
        titleLarge: TextStyle(
            fontSize: 22, fontWeight: FontWeight.bold, color: blackcolor),
        titleMedium: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: blackcolor),
        titleSmall: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: whitecolor)),
  );
}
