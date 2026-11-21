import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:semes_project/appPage_routes.dart';
import 'package:semes_project/custom_widgets/TextField.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Signup extends StatefulWidget {
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  bool isGoogleLoading = false;

  Future<void> signupUser() async {
    setState(() {
      isLoading = true;
    });

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      await userCredential.user!.updateDisplayName(
        nameController.text.trim(),
      );

      if (!mounted) return;

      nameController.clear();
      emailController.clear();
      passwordController.clear();

      Navigator.pushNamedAndRemoveUntil(
        context,
        ApppageRoutes.SplashRoute,
            (route) => false,
      );

    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message ?? 'Registration failed!'),
          backgroundColor: Colors.red,
        ),
      );

    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Something went wrong!'),
          backgroundColor: Colors.red,
        ),
      );

    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }


  Future<void> signUpWithGoogle() async {

    // Start loading
    setState(() {
      isGoogleLoading = true;
    });

    try {

      // 1. Select Google account
      final GoogleSignInAccount googleUser = await GoogleSignIn.instance.authenticate();
      // 2. Get Google authentication information
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;
      // 3. Get ID token
      final String? idToken = googleAuth.idToken;
      if (idToken == null) {
        throw Exception('Google ID token is missing!');
      }
      // 4. Create Firebase credential
      final OAuthCredential credential = GoogleAuthProvider.credential(
        idToken: idToken,
      );

      // 5. Create account or sign in with Firebase
      final UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(
        credential,
      );

      if (!mounted) return;

      // Check Firebase user
      final user = userCredential.user;

      debugPrint('Google User Created/Authenticated');
      debugPrint('Name: ${user?.displayName}');
      debugPrint('Email: ${user?.email}');
      debugPrint('UID: ${user?.uid}');
      debugPrint('Photo: ${user?.photoURL}');

      // 6. Navigate to AuthWrapper
      Navigator.pushNamedAndRemoveUntil(
        context,
        ApppageRoutes.SplashRoute,
            (route) => false,
      );

    } on GoogleSignInException catch (e) {

      if (!mounted) return;

      // Ignore user cancellation
      if (e.code != GoogleSignInExceptionCode.canceled) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.description ?? 'Google Sign Up failed!',
            ),
            backgroundColor: Colors.red,
          ),
        );
      }

    } on FirebaseAuthException catch (e) {

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.message ?? 'Firebase registration failed!',
          ),
          backgroundColor: Colors.red,
        ),
      );

    } catch (e) {

      if (!mounted) return;

      debugPrint('Google Sign Up Error: $e');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Something went wrong!'),
          backgroundColor: Colors.red,
        ),
      );

    } finally {

      // Stop loading
      if (mounted) {
        setState(() {
          isGoogleLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset('assets/images/signup-bg.png', fit: BoxFit.cover),

          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SizedBox(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 360,
                      height: 810,
                      child: Stack(
                        children: [
                          // Heading
                          Positioned(
                            left: 22,
                            top: 164,
                            child: Text('Sign Up', style: GoogleFonts.ibmPlexSerif(
                                fontSize: 45,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),

                          // Subtitle
                          Positioned(
                            left: 24,
                            top: 225,
                            child: SizedBox(
                              width: 200,
                              child: Text('Create your account to\ncontinue', style: GoogleFonts.roboto(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),

                          // Already have an account?
                          Positioned(
                            left: 22,
                            top: 268,
                            child: Text('Already have an\naccount?', style: GoogleFonts.ibmPlexSans(
                                fontSize: 14,
                                fontStyle: FontStyle.italic,
                                color: Colors.white,
                              ),
                            ),
                          ),

                          // Sign In small button
                          Positioned(
                            left: 14,
                            top: 315,
                            child: SizedBox(
                              width: 123,
                              height: 38,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, ApppageRoutes.SigninRoute);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF07076C),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  padding: EdgeInsets.zero,
                                ),
                                child: Text('Sign In', style: GoogleFonts.ibmPlexSerif(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // Full Name Field
                          Positioned(
                            left: 14,
                            top: 390,
                            child: SizedBox(
                              width: 332,
                              height: 52,
                              child: SignupTextField(
                                hintText: 'Full Name',
                                prefixIcon: Icons.person_outline,
                                controller: nameController,
                              ),
                            ),
                          ),

                          // Email Field
                          Positioned(
                            left: 14,
                            top: 458,
                            child: SizedBox(
                              width: 332,
                              height: 52,
                              child: SignupTextField(
                                hintText: 'Email Address',
                                prefixIcon: Icons.email_outlined,
                                controller: emailController,
                              ),
                            ),
                          ),

                          // Password Field
                          Positioned(
                            left: 14,
                            top: 526,
                            child: SizedBox(
                              width: 332,
                              height: 52,
                              child: SignupTextField(
                                hintText: 'Password',
                                prefixIcon: Icons.lock_rounded,
                                postfixIcon: Icons.remove_red_eye,
                                obscureText: true,
                                controller: passwordController,
                              ),
                            ),
                          ),

                          // Main Sign Up Button
                          Positioned(
                            left: 101,
                            top: 600,
                            child: Container(
                              width: 158,
                              height: 48,
                              decoration: BoxDecoration(
                                color: Color(0xFF07076C),
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFF143DF4).withOpacity(0.5),
                                    blurRadius: 12,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: ElevatedButton(
                                onPressed: isLoading ? null : signupUser,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                child: isLoading
                                    ? SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                                    : Text(
                                  'Sign Up',
                                  style: GoogleFonts.ibmPlexSerif(
                                    fontSize: 24,
                                    fontStyle: FontStyle.italic,
                                    letterSpacing: 1.5,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // Google Sign Up Button
                          Positioned(
                            left: 14,
                            top: 670,
                            child: Container(
                              width: 332,
                              height: 44,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                              ),

                              child: TextButton(
                                onPressed: (isGoogleLoading || isLoading)
                                    ? null
                                    : signUpWithGoogle,

                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  foregroundColor: Colors.black,
                                  padding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),

                                child: isGoogleLoading
                                    ? SizedBox(
                                  width: 22,
                                  height: 22,
                                  child: CircularProgressIndicator(
                                    color: Color(0xFF143DF4),
                                    strokeWidth: 2,
                                  ),
                                )
                                    : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/devicon_google.svg',
                                      width: 23,
                                      height: 23,
                                    ),

                                    SizedBox(width: 12),

                                    Text(
                                      'Continue with Google',
                                      style: GoogleFonts.ibmPlexSerif(
                                        fontSize: 19,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 758,
                            left: 0,
                            right: 0,
                            child: Column(
                              children: [
                                Text("© 2026 all rights reserved", style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                                ),
                                Text("Made with ♡ by ZS Developer's", style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }
}