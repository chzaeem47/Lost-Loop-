import 'package:flutter/material.dart';
import 'package:semes_project/Signin.dart';
import 'package:semes_project/Signup.dart';
import 'package:semes_project/Splash.dart';

class ApppageRoutes {
  static const String SplashRoute = '/';
  static const String SigninRoute = '/signin';
  static const String SignupRoute = '/signup';

  static final Map<String, WidgetBuilder> routesData = {
    SplashRoute: (context) => Splash(),
    SigninRoute: (context) => Signin(),
    SignupRoute: (context) => Signup(),
  };
}