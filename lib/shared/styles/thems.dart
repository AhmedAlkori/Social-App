import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';


ThemeData lightThem=ThemeData
  (

  fontFamily: 'Janna',

  scaffoldBackgroundColor: Colors.white,
  primarySwatch: Colors.blue,
  appBarTheme: AppBarTheme(
    color: Colors.white,
    elevation: 0.0,
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    titleTextStyle: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 20.0
    ),

    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),


  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.blue,
    unselectedItemColor: Colors.grey,
    showUnselectedLabels: true,
    elevation: 30.0,
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontSize: 20.0,
      fontFamily: 'Janna',
      fontWeight: FontWeight.bold,
      color: Colors.grey,
    ),
    bodyText2: TextStyle(
      fontSize: 26.0,
     fontFamily: 'Janna',
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    subtitle1: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
    ),
  ),

);

ThemeData darkThem=ThemeData
  (
  fontFamily: 'Janna',

  scaffoldBackgroundColor: HexColor('333739'),
  primarySwatch: Colors.blue,
  appBarTheme: AppBarTheme(
    color: HexColor('333739'),
    elevation: 0.0,
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    titleTextStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 20.0
    ),

    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: HexColor('333739'),
      statusBarIconBrightness: Brightness.light,
    ),


  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.blue,
    unselectedItemColor: Colors.grey,
    showUnselectedLabels: true,
    elevation: 30.0,
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontSize: 20.0,
      fontFamily: 'Janna',
      fontWeight: FontWeight.bold,
      color: Colors.grey,
    ),
    bodyText2: TextStyle(
      fontSize: 26.0,
      fontFamily: 'Janna',
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    subtitle1: TextStyle(
         fontSize: 16.0,
      fontWeight: FontWeight.w600,
    ),

  ),

);