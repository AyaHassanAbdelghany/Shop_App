import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_app/shared/components/constants.dart';

 ThemeData darkTheme = ThemeData(
primarySwatch: primaryColor,
scaffoldBackgroundColor: Colors.black54,
appBarTheme: const AppBarTheme(
elevation: 0.0,
backgroundColor: Colors.black54,
systemOverlayStyle: SystemUiOverlayStyle(
statusBarColor: Colors.black54,
statusBarIconBrightness: Brightness.light
),
iconTheme: IconThemeData(
color: Colors.white,
),
titleTextStyle: TextStyle(
color: Colors.white,
fontSize: 25.0,
fontWeight: FontWeight.bold,
),
),
bottomNavigationBarTheme: const BottomNavigationBarThemeData(
type: BottomNavigationBarType.fixed,
unselectedItemColor: Colors.white,
selectedItemColor: primaryColor,
backgroundColor: Colors.grey,
elevation: 20.0,
),
textTheme: const TextTheme(
bodyText1: TextStyle(
color: Colors.white,
fontSize: 18.0,
fontWeight: FontWeight.bold,
),
)
);

 ThemeData lightTheme = ThemeData(
primarySwatch: primaryColor,
scaffoldBackgroundColor: Colors.white,
appBarTheme: const AppBarTheme(
elevation: 0.0,
backgroundColor: Colors.white,
systemOverlayStyle: SystemUiOverlayStyle(
statusBarColor: Colors.white,
statusBarIconBrightness: Brightness.dark
),
iconTheme: IconThemeData(
color: Colors.black,
),
titleTextStyle: TextStyle(
color: Colors.black,
fontSize: 25.0,
fontWeight: FontWeight.bold,
)
),
bottomNavigationBarTheme: const BottomNavigationBarThemeData(
type: BottomNavigationBarType.fixed,
selectedItemColor: primaryColor,
unselectedItemColor: Colors.grey,
elevation: 20.0,
backgroundColor: Colors.white
),
textTheme: const TextTheme(
bodyText1: TextStyle(
color: Colors.black,
fontSize: 18.0,
fontWeight: FontWeight.bold,
),
)
);

