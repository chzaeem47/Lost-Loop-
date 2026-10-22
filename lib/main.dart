import 'package:flutter/material.dart';
import 'package:semes_project/appPage_routes.dart';

void main() {
  runApp(LostLoop());
}

class LostLoop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.HomePageRoute,
      routes: AppRoutes.routesData,
    );
  }
}