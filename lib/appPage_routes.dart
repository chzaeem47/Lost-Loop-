import 'package:flutter/material.dart';
import 'package:semes_project/homePage_Screen.dart';
import 'package:semes_project/splash_screen.dart';

class AppRoutes {
  static const String SplashPageRoute = "/";
  static const String HomePageRoute = "/home";

  static Map<String, WidgetBuilder> routesData = {
    SplashPageRoute: (context) => SplashScreen(),
    HomePageRoute: (context) => HomepageScreen(),
  };
}