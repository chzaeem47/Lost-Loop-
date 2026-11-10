import 'package:flutter/material.dart';
import '../../views/auth/splash_screen.dart';
import '../../views/navigation/main_navigation_screen.dart';

class AppRoutes {
  static const String splash = "/";
  static const String home = "/home";

  static const String SplashPageRoute = splash;
  static const String HomePageRoute = home;

  static Map<String, WidgetBuilder> get routesData => {
    splash: (context) => const SplashScreen(),
    home: (context) => const MainNavigationScreen(),
  };
}
