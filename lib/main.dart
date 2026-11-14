import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:semes_project/appPage_routes.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(LostLoop());
}

class LostLoop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: ApppageRoutes.SplashRoute,
      routes: ApppageRoutes.routesData,
    );
  }
}