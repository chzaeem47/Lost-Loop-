import 'package:flutter/material.dart';
import '../../views/auth/splash_screen.dart';
import '../../views/navigation/main_navigation_screen.dart';

class AppRoutes {
  static const String splash = "/";
  static const String home = "/home";

  static Map<String, WidgetBuilder> get routesData => {
    splash: (context) => SplashScreen(),
    home: (context) => const MainNavigationScreen(),
  };
}
