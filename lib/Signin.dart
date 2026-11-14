
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:semes_project/appPage_routes.dart';
import 'package:semes_project/custom_widgets/TextField.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Signin extends StatefulWidget {
  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
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
                                Navigator.pushNamed(context,ApppageRoutes.SignupRoute);
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
                            ),
                          ),

                          // Forgot password
                          Positioned(
                            right: 25,
                            top: 558,
                            child: TextButton(
                              onPressed: () {},
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
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(40),
                                  ),
                                ),
                                child: Text(
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
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    "assets/images/devicon_google.svg",
                                    width: 23,
                                    height: 23,
                                  ),

                                  SizedBox(width: 5),

                                  Text(
                                    "Continue with Google",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.ibmPlexSans(
                                      fontSize: 19,
                                      fontStyle: FontStyle.italic,
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
