
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ActionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String buttonText;
  final String imageAsset;
  final bool isPrimary;
  final VoidCallback? onTap;

  const ActionCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.imageAsset,
    this.isPrimary = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color blue = const Color(0xFF143DF4);

    final Color titleColor =
    isPrimary ? Colors.white : const Color(0xFF101B55);

    final Color subtitleColor =
    isPrimary ? const Color(0xFFDCE5FF) : const Color(0xFF65739B);

    final Color badgeColor =
    isPrimary ? Colors.white.withOpacity(0.15) : blue.withOpacity(0.08);

    final Color badgeTextColor =
    isPrimary ? Colors.white : blue;

    final Color buttonColor =
    isPrimary ? Colors.white : blue;

    final Color buttonTextColor =
    isPrimary ? blue : Colors.white;

    return LayoutBuilder(
      builder: (context, constraints) {
        final bool compact = constraints.maxWidth < 155;

        return Container(
          height: 205,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: isPrimary
                ? const LinearGradient(
              colors: [
                Color(0xFF2450FF),
                Color(0xFF143DF4),
                Color(0xFF102CBF),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )
                : const LinearGradient(
              colors: [
                Colors.white,
                Color(0xFFF1F5FF),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(
              color: isPrimary
                  ? Colors.white.withOpacity(0.25)
                  : const Color(0xFFDCE5FF),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: isPrimary
                    ? blue.withOpacity(0.22)
                    : const Color(0xFF143DF4).withOpacity(0.10),
                blurRadius: 16,
                offset: const Offset(0, 7),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(24),
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(24),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Stack(
                  children: [
                    // Decorative background glow
                    Positioned(
                      top: 25,
                      right: -25,
                      child: Container(
                        width: 110,
                        height: 110,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isPrimary
                              ? Colors.white.withOpacity(0.07)
                              : blue.withOpacity(0.045),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Category badge
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 9,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: badgeColor,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  isPrimary
                                      ? Icons.search_off_rounded
                                      : Icons.check_circle_outline_rounded,
                                  size: 12,
                                  color: badgeTextColor,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  isPrimary ? 'LOST ITEM' : 'FOUND ITEM',
                                  style: GoogleFonts.nunito(
                                    fontSize: 9,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 0.8,
                                    color: badgeTextColor,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 3),

                          // 3D illustration
                          SizedBox(
                            height: 69,
                            width: double.infinity,
                            child: Center(
                              child: Image.asset(
                                imageAsset,
                                height: 78,
                                width: 110,
                                fit: BoxFit.contain,
                                filterQuality: FilterQuality.high,
                                errorBuilder: (context, error, stackTrace) {
                                  return Icon(
                                    isPrimary
                                        ? Icons.backpack_rounded
                                        : Icons.inventory_2_rounded,
                                    size: 48,
                                    color: isPrimary
                                        ? Colors.white
                                        : blue,
                                  );
                                },
                              ),
                            ),
                          ),

                          const SizedBox(height: 4),

                          // Title
                          Text(
                            title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.nunito(
                              fontSize: compact ? 14 : 16,
                              fontWeight: FontWeight.w900,
                              color: titleColor,
                              height: 1.1,
                            ),
                          ),

                          const SizedBox(height: 3),

                          // Subtitle
                          Text(
                            subtitle,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.nunito(
                              fontSize: compact ? 10 : 11,
                              fontWeight: FontWeight.w600,
                              color: subtitleColor,
                              height: 1.2,
                            ),
                          ),

                          const Spacer(),

                          // Action button
                          Container(
                            height: 34,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: buttonColor,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: isPrimary
                                      ? Colors.black.withOpacity(0.10)
                                      : blue.withOpacity(0.20),
                                  blurRadius: 7,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: Text(
                                    buttonText,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.nunito(
                                      color: buttonTextColor,
                                      fontSize: compact ? 11 : 12,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Icon(
                                  Icons.arrow_forward_rounded,
                                  size: 15,
                                  color: buttonTextColor,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
