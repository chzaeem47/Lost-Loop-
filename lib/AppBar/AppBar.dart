import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppbarWidget({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {

    final user = FirebaseAuth.instance.currentUser;
    final String? photoUrl = user?.photoURL;

    return AppBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(25),
          bottomLeft: Radius.circular(25),
        ),
      ),
      title: Row(
        children: [
          Text(
            'Lost L',
            style: GoogleFonts.ibmPlexSans(
              fontStyle: FontStyle.italic,
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 2, right: 1),
            child: Image.asset(
              'assets/images/infinity_logo.png',
              width: 35,
              height: 35,
              color: Colors.white,
            ),
          ),
          Text(
            "p",
            style: GoogleFonts.ibmPlexSans(
              fontStyle: FontStyle.italic,
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      backgroundColor: Color(0xFF143DF4),
      actions: [
        // BELL ICON
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.notifications,
            color: Colors.white,
            size: 25,
          ),
        ),

        Padding(
          padding: EdgeInsets.only(right: 12),
          child: Container(
            width: 40,
            height: 40,
            padding: const EdgeInsets.all(2.5),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  Color(0xFF143DF4),
                  Colors.white,
                  Colors.blueAccent,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              backgroundImage: photoUrl != null && photoUrl.isNotEmpty
                  ? NetworkImage(photoUrl)
                  : null,
              child: photoUrl == null || photoUrl.isEmpty
                  ? const Icon(
                Icons.person,
                color: Color(0xFF143DF4),
              )
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}
