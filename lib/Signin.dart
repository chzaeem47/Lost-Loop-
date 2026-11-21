
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:semes_project/appPage_routes.dart';
import 'package:semes_project/custom_widgets/TextField.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Signin extends StatefulWidget {
  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoading = false;
  bool isGoogleLoading = false;

  // EMAIL AND PASSWORD SIGN IN
  Future<void> signinUser() async {

    setState(() {
      isLoading = true;
    });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      if (!mounted) return;

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
          content: Text(e.message ?? 'Login failed!'),
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

  // GOOGLE SIGN IN
  Future<void> signInWithGoogle() async {

    // Start loading
    setState(() {
      isGoogleLoading = true;
    });

    try {

      // 1. Select Google account
      final GoogleSignInAccount googleUser =
      await GoogleSignIn.instance.authenticate();

      // 2. Get Google authentication information
      final GoogleSignInAuthentication googleAuth =
          googleUser.authentication;

      // 3. Get ID token
      final String? idToken = googleAuth.idToken;

      if (idToken == null) {
        throw Exception('Google ID token is missing!');
      }

      // 4. Create Firebase credential
      final OAuthCredential credential =
      GoogleAuthProvider.credential(
        idToken: idToken,
      );

      // 5. Sign in to Firebase
      await FirebaseAuth.instance.signInWithCredential(credential);

      if (!mounted) return;

      emailController.clear();
      passwordController.clear();

      // Navigate to AuthWrapper
      Navigator.pushNamedAndRemoveUntil(
        context,
        ApppageRoutes.SplashRoute,
            (route) => false,
      );

    } on GoogleSignInException catch (e) {

      if (!mounted) return;

      // Ignore cancellation
      if (e.code != GoogleSignInExceptionCode.canceled) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.description ?? 'Google Sign In failed!',
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
            e.message ?? 'Firebase authentication failed!',
          ),
          backgroundColor: Colors.red,
        ),
      );

    } catch (e) {

      if (!mounted) return;

      debugPrint('Google Sign In Error: $e');

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

          // Full-screen background image
          Image.asset(
            'assets/images/signup-bg.png',
            fit: BoxFit.cover,
          ),

          // Responsive content
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
                        clipBehavior: Clip.hardEdge,
                        children: [

                          // Sign In heading
                          Positioned(
                            left: 22,
                            top: 164,
                            child: Text(
                              "Sign In",
                              style: GoogleFonts.ibmPlexSans(
                                fontWeight: FontWeight.w500,
                                fontSize: 45,
                                color: Colors.white,
                              ),
                            ),
                          ),

                          // Subtitle
                          Positioned(
                            left: 24,
                            top: 225,
                            child: SizedBox(
                              width: 160,
                              child: Text(
                                "Enter your credentials to\ncontinue",
                                style: GoogleFonts.roboto(
                                  color: Colors.grey.shade300,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),

                          // Don't have an account?
                          Positioned(
                            left: 22,
                            top: 268,
                            child: Text(
                              "Don't have an\naccount?",
                              style: GoogleFonts.ibmPlexSans(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Colors.white,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),

                          // Sign Up button
                          Positioned(
                            left: 14,
                            top: 315,
                            width: 123,
                            height: 38,
                            child: TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  ApppageRoutes.SignupRoute,
                                );
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: Color(0xff07076C),
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.zero,
                                minimumSize: Size.zero,
                                tapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(100),
                                ),
                              ),
                              child: Text(
                                "SignUp",
                                style: GoogleFonts.ibmPlexSans(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ),

                          // Email field
                          Positioned(
                            left: 14,
                            top: 415,
                            width: 332,
                            height: 52,
                            child: SignupTextField(
                              hintText: "Enter your Email",
                              prefixIcon: Icons.email_outlined,
                              controller: emailController,
                            ),
                          ),

                          // Password field
                          Positioned(
                            left: 14,
                            top: 493,
                            width: 332,
                            height: 52,
                            child: SignupTextField(
                              hintText: "Enter your Password",
                              prefixIcon: Icons.lock_rounded,
                              postfixIcon: Icons.remove_red_eye,
                              obscureText: true,
                              controller: passwordController,
                            ),
                          ),

                          // Forgot password
                          Positioned(
                            right: 25,
                            top: 558,
                            child: TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  ApppageRoutes.ForgotRoute,
                                );
                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: Size.zero,
                                tapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: Text(
                                "Forgot password?",
                                style: GoogleFonts.ibmPlexSans(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ),

                          // Sign In button
                          Positioned(
                            left: 101,
                            top: 587,
                            width: 158,
                            height: 48,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xff07076C),
                                borderRadius: BorderRadius.circular(40),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xff143DF4)
                                        .withOpacity(0.3),
                                    blurRadius: 15,
                                    offset: Offset(0, 6),
                                  ),
                                ],
                              ),

                              child: TextButton(
                                onPressed:
                                (isLoading || isGoogleLoading)
                                    ? null
                                    : signinUser,

                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(40),
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
                                  "Sign In",
                                  style: GoogleFonts.ibmPlexSans(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // Continue with Google button
                          Positioned(
                            left: 14,
                            top: 660,
                            width: 332,
                            height: 44,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                BorderRadius.circular(199),
                              ),

                              child: TextButton(
                                onPressed:
                                (isGoogleLoading || isLoading)
                                    ? null
                                    : signInWithGoogle,

                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  backgroundColor: Colors.transparent,
                                  foregroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(199),
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
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [

                                    SvgPicture.asset(
                                      "assets/images/devicon_google.svg",
                                      width: 23,
                                      height: 23,
                                    ),

                                    SizedBox(width: 12),

                                    Text(
                                      "Continue with Google",
                                      textAlign: TextAlign.center,
                                      style:
                                      GoogleFonts.ibmPlexSans(
                                        fontSize: 19,
                                        fontStyle: FontStyle.italic,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          // Footer
                          Positioned(
                            top: 758,
                            left: 0,
                            right: 0,
                            child: Column(
                              children: [
                                Text(
                                  "© 2026 all rights reserved",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),

                                Text(
                                  "Made with ♡ by ZS Developer's",
                                  style: TextStyle(
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
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
