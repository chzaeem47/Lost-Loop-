import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:semes_project/Footer/rights_footer.dart';
import 'package:semes_project/custom_widgets/TextField.dart';

class Forgot extends StatefulWidget {
  const Forgot({super.key});

  @override
  State<Forgot> createState() => _ForgotState();
}

class _ForgotState extends State<Forgot> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [

          // Full-screen background and content
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/signup-bg.png"),
                fit: BoxFit.cover,
              ),
            ),

            child: Column(
              children: [

                // Email field and reset button
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 50),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [

                          SignupTextField(
                            hintText: "Enter your email to get a reset link",
                            prefixIcon: Icons.email,
                          ),

                          SizedBox(height: 20),

                          TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              backgroundColor: Color(0xFF07076C),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              padding: EdgeInsets.all(11),
                            ),
                            child: Text(
                              "Get Reset Link",
                              style: GoogleFonts.ibmPlexSans(
                                color: Colors.white,
                                fontStyle: FontStyle.italic,
                                fontSize: 16,
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),

                // Footer
                RightsFooter(),

                SizedBox(height: 15),
              ],
            ),
          ),

          // Back button overlay
          Positioned(
            top: 10,
            left: 3,
            child: SafeArea(
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
