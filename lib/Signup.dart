import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:semes_project/appPage_routes.dart';
import 'package:semes_project/custom_widgets/TextField.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Signup extends StatefulWidget {
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            'assets/images/signup-bg.png',
            fit: BoxFit.cover,
          ),

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
                            child: Text(
                              'Sign Up',
                              style: GoogleFonts.ibmPlexSerif(
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
                              child: Text(
                                'Create your account to\ncontinue',
                                style: GoogleFonts.roboto(
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
                            child: Text(
                              'Already have an\naccount?',
                              style: GoogleFonts.ibmPlexSans(
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
                                child: Text(
                                  'Sign In',
                                  style: GoogleFonts.ibmPlexSerif(
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
                                onPressed: () {
                                  // Create account
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                child: Text(
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
                              child: Row(
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
}