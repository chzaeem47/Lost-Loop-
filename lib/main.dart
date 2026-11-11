import 'package:flutter/material.dart';
import 'package:semes_project/core/routes/app_routes.dart';
import 'package:semes_project/core/theme/app_theme.dart';

void main() {
  runApp(const LostLoopApp());
}

class LostLoopApp extends StatelessWidget {
  const LostLoopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lost Loop',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.splash,
      routes: AppRoutes.routesData,
    );
  }
}
