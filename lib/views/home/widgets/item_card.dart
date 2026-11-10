import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../models/item_model.dart';

class ItemCard extends StatelessWidget {
  final ItemModel item;

  const ItemCard({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFE8EEF8),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.darkNavy.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Image with rounded corners matching template
            Expanded(
              flex: 55,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: SizedBox(
                  width: double.infinity,
                  child: Image.network(
                    item.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: const Color(0xFFF1F5F9),
                      child: const Center(
                        child: Icon(
                          Icons.image_not_supported_outlined,
                          color: Color(0xFF94A3B8),
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 6),

            // Item Details Section
            Expanded(
              flex: 45,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Title & Color Subtitle
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.tinos(
                            color: AppColors.darkNavy,
                            fontSize: 13,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          item.color,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.tinos(
                            color: const Color(0xFF708099),
                            fontSize: 11,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),

                    // Location & Date Rows
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on_rounded,
                              size: 11.5,
                              color: Color(0xFF708099),
                            ),
                            const SizedBox(width: 3),
                            Expanded(
                              child: Text(
                                item.location,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.tinos(
                                  color: const Color(0xFF708099),
                                  fontSize: 10,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_today_rounded,
                              size: 10.5,
                              color: Color(0xFF708099),
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                item.date,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.tinos(
                                  color: const Color(0xFF708099),
                                  fontSize: 10,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ],
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
    );
  }
}
