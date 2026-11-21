import 'package:flutter/material.dart';
import 'package:semes_project/AuthWrapper.dart';
import 'package:semes_project/ForgotPassword.dart';
import 'package:semes_project/Signin.dart';
import 'package:semes_project/Signup.dart';

class ApppageRoutes {
  static const String SplashRoute = '/';
  static const String SigninRoute = '/signin';
  static const String SignupRoute = '/signup';
  static const String ForgotRoute = '/forgot';

  static final Map<String, WidgetBuilder> routesData = {
    SplashRoute: (context) => AuthWrapper(),
    SigninRoute: (context) => Signin(),
    SignupRoute: (context) => Signup(),
    ForgotRoute: (context) => Forgot(),
  };
}