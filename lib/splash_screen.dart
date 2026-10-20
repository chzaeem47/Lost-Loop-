
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:semes_project/appPage_routes.dart';
import 'package:semes_project/signup_bottomScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool showSignup = false;
  bool isLogin = false;

  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 4), () {
      if (!mounted) return;

      setState(() {
        showSignup = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/images/splash_bg.png',
              fit: BoxFit.cover,
            ),
          ),

          AnimatedPositioned(
            duration: Duration(milliseconds: 600),
            curve: Curves.easeInOut,
            top: showSignup ? 60 : 0,
            bottom: showSignup ? 400 : 0,
            left: 0,
            right: 0,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Lost", style: GoogleFonts.nunito(
                      fontSize: 45,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.3),
                          offset: Offset(2, 5),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                  ),

                  Transform.translate(
                    offset: Offset(0, -8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 2),
                          child: Text("L", style: GoogleFonts.nunito(
                              fontSize: 58,
                              color: Color(0xFF143DF4),
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.3),
                                  offset: Offset(2, 5),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                          ),
                        ),

                        Container(
                          width: 100,
                          height: 60,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/infinity_logo.png',),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(left: 2),
                          child: Text("p", style: GoogleFonts.nunito(
                              fontSize: 58,
                              color: Color(0xFF143DF4),
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.3),
                                  offset: Offset(2, 5),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Transform.translate(
                    offset: Offset(0, -8),
                    child: Text(
                      "Lost items. Found again",
                      style: GoogleFonts.nunito(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.3),
                            offset: Offset(2, 2),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          AnimatedPositioned(
            duration: Duration(milliseconds: 600),
            curve: Curves.easeOut,
            left: 0,
            right: 0,
            bottom: showSignup ? 0 : -500,
            height: 462,
            child: SignupScreen(),
          ),
        ],
      ),
    );
  }
}
