import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  static TextStyle greetingTitle = GoogleFonts.lilyScriptOne(
    color: AppColors.darkNavy,
    fontSize: 32,
    fontWeight: FontWeight.bold,
  );

  static TextStyle greetingSubtitle = GoogleFonts.tinos(
    color: AppColors.primaryBlue,
    fontSize: 15,
    fontStyle: FontStyle.italic,
  );

  static TextStyle sectionTitle = GoogleFonts.tinos(
    color: AppColors.darkNavy,
    fontSize: 18,
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.bold,
  );

  static TextStyle seeAllLink = GoogleFonts.tinos(
    color: AppColors.primaryBlue,
    fontSize: 15,
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.w600,
  );

  static TextStyle authTitle = GoogleFonts.nunito(
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.bold,
    fontSize: 26,
    color: Colors.white,
    shadows: [
      Shadow(
        color: Colors.black.withOpacity(0.3),
        offset: const Offset(2, 2),
        blurRadius: 10,
      ),
    ],
  );

  static TextStyle authSubTitle = GoogleFonts.nunito(
    fontStyle: FontStyle.italic,
    fontSize: 15,
    color: Colors.white,
    shadows: [
      Shadow(
        color: Colors.black.withOpacity(0.3),
        offset: const Offset(2, 2),
        blurRadius: 10,
      ),
    ],
  );

  static TextStyle inputLabel = GoogleFonts.tinos(
    color: Colors.white,
    fontStyle: FontStyle.italic,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static TextStyle inputText = GoogleFonts.tinos(
    color: Colors.black87,
    fontSize: 15,
  );

  static TextStyle buttonText = GoogleFonts.tinos(
    fontStyle: FontStyle.italic,
    letterSpacing: 1.5,
    fontSize: 19,
    fontWeight: FontWeight.w600,
  );
}
