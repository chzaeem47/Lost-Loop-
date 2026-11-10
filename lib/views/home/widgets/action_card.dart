import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';

class ActionCardsSection extends StatelessWidget {
  final VoidCallback? onLostTap;
  final VoidCallback? onFoundTap;

  const ActionCardsSection({
    super.key,
    this.onLostTap,
    this.onFoundTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Card 1: I Lost something
        Expanded(
          child: _ActionCard(
            title: "I Lost something",
            subtitle: "Report a missing item",
            buttonText: "Report Lost",
            icon: Icons.saved_search_rounded,
            badgeText: "LOST",
            isPrimary: true,
            onTap: onLostTap ?? () {},
          ),
        ),

        const SizedBox(width: 14),

        // Card 2: I Found something
        Expanded(
          child: _ActionCard(
            title: "I Found something",
            subtitle: "Help return an item",
            buttonText: "Report Found",
            icon: Icons.handshake_rounded,
            badgeText: "FOUND",
            isPrimary: false,
            onTap: onFoundTap ?? () {},
          ),
        ),
      ],
    );
  }
}

class _ActionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String buttonText;
  final IconData icon;
  final String badgeText;
  final bool isPrimary;
  final VoidCallback onTap;

  const _ActionCard({
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.icon,
    required this.badgeText,
    required this.isPrimary,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cardBgGradient = isPrimary
        ? const LinearGradient(
            colors: [
              Color(0xFF1E46F7),
              Color(0xFF0922A6),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
        : const LinearGradient(
            colors: [
              Colors.white,
              Color(0xFFF4F7FF),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          );

    final cardBorder = isPrimary
        ? Border.all(color: Colors.white.withOpacity(0.15), width: 1)
        : Border.all(color: AppColors.primaryBlue.withOpacity(0.2), width: 1.5);

    final shadowColor = isPrimary
        ? AppColors.primaryBlue.withOpacity(0.35)
        : Colors.black.withOpacity(0.06);

    final iconColor = isPrimary ? Colors.white : AppColors.primaryBlue;

    final badgeBg = isPrimary
        ? Colors.white.withOpacity(0.15)
        : AppColors.primaryBlue.withOpacity(0.08);

    final badgeTextColor = isPrimary ? Colors.white : AppColors.primaryBlue;

    final titleColor = isPrimary ? Colors.white : AppColors.darkNavy;

    final subtitleColor = isPrimary
        ? Colors.white.withOpacity(0.82)
        : AppColors.darkNavy.withOpacity(0.65);

    final buttonBg = isPrimary ? Colors.white : AppColors.primaryBlue;

    final buttonFg = isPrimary ? AppColors.primaryBlue : Colors.white;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: Stack(
          children: [
            // Decorative background accent circle
            Positioned(
              right: -20,
              top: -20,
              child: Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isPrimary
                      ? Colors.white.withOpacity(0.06)
                      : AppColors.primaryBlue.withOpacity(0.04),
                ),
              ),
            ),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
              decoration: BoxDecoration(
                gradient: cardBgGradient,
                borderRadius: BorderRadius.circular(22),
                border: cardBorder,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Top Row: Bare Icon (No border/bg container) + Badge
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        icon,
                        color: iconColor,
                        size: 40,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: badgeBg,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          badgeText,
                          style: GoogleFonts.tinos(
                            color: badgeTextColor,
                            fontSize: 11,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  // Title
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.tinos(
                      color: titleColor,
                      fontSize: 17,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  // Subtitle
                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.tinos(
                      color: subtitleColor,
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Action Button
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonBg,
                        foregroundColor: buttonFg,
                        elevation: isPrimary ? 3 : 1,
                        shadowColor: isPrimary
                            ? Colors.black.withOpacity(0.2)
                            : AppColors.primaryBlue.withOpacity(0.2),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: onTap,
                      child: Text(
                        buttonText,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.tinos(
                          color: buttonFg,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


