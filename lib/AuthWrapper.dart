import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:semes_project/Home.dart';
import 'package:semes_project/Splash.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.userChanges(),

      builder: (context, snapshot) {

        // While Firebase checks the login status
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        // If user is logged in
        if (snapshot.hasData) {
          return Home();
        }

        // If user is not logged in
        return Splash();
      },
    );
  }
}