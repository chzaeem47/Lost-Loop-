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
                      Text("Hi $firstName", style: GoogleFonts.lilyScriptOne(
                          color: Color(0xff07076C),
                          fontSize: 33,
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(0, -8),
                        child: Text("lets find what are you looking for", style: GoogleFonts.tinos(
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
          ElevatedButton(
            onPressed:() async{
              await signOutUser(context);
            },
          child: Text("Signout")
          )

        ],
      ),
      bottomNavigationBar: CustomBottomNavigation(
        selectedIndex: 0,
        onTabSelected: (index){},
      ),
    );
  }
}
