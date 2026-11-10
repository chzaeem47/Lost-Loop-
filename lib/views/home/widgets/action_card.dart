import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';

class ActionCardsSection extends StatelessWidget {
  const ActionCardsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Card 1: I Lost something
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primaryBlue,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryBlue.withOpacity(0.35),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Top Icon
                Image.asset(
                  AppAssets.bagIcon,
                  width: 36,
                  height: 36,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.shopping_bag_outlined,
                    color: Colors.white,
                    size: 36,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "I Lost something",
                  style: GoogleFonts.nunito(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Report a missing",
                  style: GoogleFonts.nunito(
                    color: const Color(0xFF80D8FF),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  height: 36,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppColors.primaryBlue,
                      elevation: 2,
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      "Report Found",
                      style: GoogleFonts.tinos(
                        color: AppColors.primaryBlue,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(width: 14),

        // Card 2: I Found something
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppColors.primaryBlue,
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Top Icon
                Image.asset(
                  AppAssets.groupHandIcon,
                  width: 36,
                  height: 36,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.volunteer_activism_outlined,
                    color: AppColors.primaryBlue,
                    size: 36,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "I Found something",
                  style: GoogleFonts.nunito(
                    color: AppColors.primaryBlue,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Help return an item",
                  style: GoogleFonts.nunito(
                    color: AppColors.primaryBlue.withOpacity(0.8),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  height: 36,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryBlue,
                      foregroundColor: Colors.white,
                      elevation: 2,
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      "Report Found",
                      style: GoogleFonts.tinos(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
