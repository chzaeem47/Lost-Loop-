import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// Standalone function to sign out the user from Google & Firebase.
/// Call this from anywhere in the app using: `await signOutUser(context);`
Future<void> signOutUser(BuildContext context) async {
  try {
    // 1. Sign out from Google
    try {
      await GoogleSignIn.instance.signOut();
    } catch (e) {
      debugPrint('Google sign out error: $e');
    }

    // 2. Sign out from Firebase
    await FirebaseAuth.instance.signOut();

    // Note: AuthWrapper automatically detects sign out and displays Splash screen.
  } on FirebaseAuthException catch (e) {
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(e.message ?? 'Sign out failed!'),
        backgroundColor: Colors.red,
      ),
    );
  } catch (e) {
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Something went wrong!'),
        backgroundColor: Colors.red,
      ),
    );
  }
}
