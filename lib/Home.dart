
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:semes_project/AppBar/AppBar.dart';
import 'package:semes_project/Auth_Functions/Signout_User.dart';
import 'package:semes_project/bottomNavigation/bottom_navigation.dart';
import 'package:semes_project/custom_widgets/SearchBar.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // Get current Firebase user
    final user = FirebaseAuth.instance.currentUser;

    // Get profile picture
    final String fullName = user?.displayName?.trim() ?? '';

    final String firstName = fullName.isEmpty
        ? 'User'
        : fullName.split(' ').first;

    return Scaffold(
      appBar: AppbarWidget(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 30,
              right: 30,
              top: 30,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                // LEFT SIDE: TEXT
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Hi $firstName",
                        style: GoogleFonts.lilyScriptOne(
                          color: Color(0xff07076C),
                          fontSize: 33,
                        ),
                      ),

                      Transform.translate(
                        offset: Offset(0, -8),
                        child: Text(
                          "lets find what are you looking for",
                          style: GoogleFonts.tinos(
                            color: Color(0xff143DF4),
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 20),

          CustomSearchBar(),

          SizedBox(height: 10),

          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [

                // LOST CARD
                Container(
                  width: 165,
                  height: 178,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),

                    // Glossy blue 3D surface
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF8EB2FF),
                        Color(0xFF376CFF),
                        Color(0xFF143DF4),
                        Color(0xFF0926AD),
                      ],
                      stops: [0.0, 0.25, 0.65, 1.0],
                    ),

                    boxShadow: [
                      // Blue outer glow
                      BoxShadow(
                        color: Color(0xFF143DF4)
                            .withValues(alpha: 0.30),
                        blurRadius: 22,
                        spreadRadius: 2,
                        offset: Offset(0, 8),
                      ),

                      // Top-left glossy highlight
                      BoxShadow(
                        color: Colors.white
                            .withValues(alpha: 0.65),
                        blurRadius: 12,
                        offset: Offset(-4, -4),
                      ),
                    ],
                  ),

                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Stack(
                      children: [

                        // Glossy white reflection
                        Positioned(
                          top: -35,
                          left: -25,
                          child: Container(
                            width: 155,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: RadialGradient(
                                colors: [
                                  Colors.white.withValues(alpha: 0.45),
                                  Colors.white.withValues(alpha: 0.0),
                                ],
                              ),
                            ),
                          ),
                        ),

                        // Soft blue reflection
                        Positioned(
                          bottom: -50,
                          right: -40,
                          child: Container(
                            width: 130,
                            height: 115,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: RadialGradient(
                                colors: [
                                  Color(0xFF071D9B)
                                      .withValues(alpha: 0.35),
                                  Color(0xFF071D9B)
                                      .withValues(alpha: 0.0),
                                ],
                              ),
                            ),
                          ),
                        ),

                        // Original content - unchanged
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/bag.png",
                              width: 130,
                              height: 100,
                            ),

                            Transform.translate(
                              offset: Offset(3, -7),
                              child: Center(
                                child: Text(
                                  "Lost Something?",
                                  style: GoogleFonts.tinos(
                                    fontSize: 18,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),

                            Transform.translate(
                              offset: Offset(0, -5),
                              child: Center(
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor: Color(0xff143df4),
                                  ),
                                  onPressed: () {},
                                  child: Text(
                                    "Report Lost",
                                    style: GoogleFonts.tinos(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(width: 10),

                // FOUND CARD
                Container(
                  width: 165,
                  height: 178,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),

                    // Glossy white and blue 3D surface
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.blueAccent,
                        Color(0xFFF0F5FF),
                        Color(0xFFDCE7FF),
                        Colors.blueAccent,
                      ],
                      stops: [0.0, 0.35, 0.75, 1.0],
                    ),

                    boxShadow: [
                      // Soft blue outer glow
                      BoxShadow(
                        color: Color(0xFF143DF4)
                            .withValues(alpha: 0.18),
                        blurRadius: 22,
                        spreadRadius: 2,
                        offset: Offset(0, 8),
                      ),

                      // Top-left glossy highlight
                      BoxShadow(
                        color: Colors.white
                            .withValues(alpha: 0.9),
                        blurRadius: 12,
                        offset: Offset(-4, -4),
                      ),
                    ],
                  ),

                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Stack(
                      children: [

                        // White glossy reflection
                        Positioned(
                          top: -35,
                          right: -25,
                          child: Container(
                            width: 145,
                            height: 105,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: RadialGradient(
                                colors: [
                                  Colors.blueAccent.withValues(alpha: 0.9),
                                  Colors.blue.withValues(alpha: 0.0),
                                ],
                              ),
                            ),
                          ),
                        ),

                        // Soft blue reflection
                        Positioned(
                          bottom: -45,
                          left: -35,
                          child: Container(
                            width: 140,
                            height: 110,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: RadialGradient(
                                colors: [
                                  Colors.blueAccent.withValues(alpha: 0.7),
                                  Color(0xFF143DF4)
                                      .withValues(alpha: 0.0),
                                ],
                              ),
                            ),
                          ),
                        ),

                        // Original content - unchanged
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/box.png",
                              width: 130,
                              height: 100,
                            ),

                            Transform.translate(
                              offset: Offset(0, -7),
                              child: Center(
                                child: Text(
                                  "Found Something?",
                                  style: GoogleFonts.tinos(
                                    fontSize: 18,
                                    fontStyle: FontStyle.italic,
                                    color: Color(0xff143df4),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),

                            Transform.translate(
                              offset: Offset(0, -5),
                              child: Center(
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: Color(0xff143df4),
                                    foregroundColor: Colors.white,
                                  ),
                                  onPressed: () {},
                                  child: Text(
                                    "Report Found",
                                    style: GoogleFonts.tinos(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          ElevatedButton(
            onPressed: () async {
              await signOutUser(context);
            },
            child: Text("Signout"),
          ),
        ],
      ),

      bottomNavigationBar: CustomBottomNavigation(
        selectedIndex: 0,
        onTabSelected: (index) {},
      ),
    );
  }
}
