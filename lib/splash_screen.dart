import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:semes_project/appPage_routes.dart';

class SplashScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    Timer(Duration(seconds: 4), (){
      Navigator.pushReplacementNamed(context,AppRoutes.HomePageRoute);
    });
    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/splash_bg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
                    mainAxisSize: MainAxisSize.min,
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
                            image: AssetImage('assets/images/infinity_logo.png'),
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
                  child: Text("Lost items. Found again",style: GoogleFonts.nunito(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.3),
                        offset: Offset(2, 2),
                        blurRadius: 10,
                      ),
                    ],)
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}
