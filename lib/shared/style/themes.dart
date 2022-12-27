import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData darkMode = ThemeData(
  inputDecorationTheme: const InputDecorationTheme(
      iconColor: Colors.white, labelStyle: TextStyle(color: Colors.white)),
  textTheme: const TextTheme(
      bodyText1: TextStyle(
          color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w300)),
  scaffoldBackgroundColor: HexColor('222D3D'),
  primarySwatch: Colors.teal,
  floatingActionButtonTheme:
      const FloatingActionButtonThemeData(backgroundColor: Colors.teal),
  appBarTheme: AppBarTheme(
      titleSpacing: 20.0,
      iconTheme: const IconThemeData(
        color: Colors.white,
        size: 30.0,
      ),
      titleTextStyle: const TextStyle(
          color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
// backwardsCompatibility: false,
      backgroundColor: HexColor('222D3D'),
      elevation: 0.0,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: HexColor('222D3D'),
          statusBarIconBrightness: Brightness.light)),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.teal,
      elevation: 20.0,
      backgroundColor: HexColor('222D3D'),
      unselectedItemColor: Colors.grey),
);
ThemeData lightTheme = ThemeData(
  fontFamily: 'MyFont',
  textTheme: const TextTheme(
      bodyText1: TextStyle(
          color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.w300)),
  primarySwatch: Colors.amber,
  floatingActionButtonTheme:
      FloatingActionButtonThemeData(backgroundColor: Colors.orange[400]),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
      titleSpacing: 20.0,
      iconTheme: IconThemeData(
        color: Colors.grey,
        size: 30.0,
      ),
      titleTextStyle: TextStyle(
          color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
      backgroundColor: Colors.white,
      elevation: 0.0,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark)),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.amber,
      elevation: 20.0),
);
