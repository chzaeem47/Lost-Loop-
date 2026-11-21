
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth;

        return SizedBox(
          height: 50,
          width: 330,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // TextField: uses the original available width
              Positioned.fill(
                child: Center(
                  child: Container(
                    height: 92,
                    width: width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(60),
                      border: Border.all(
                        color: const Color(0xFFB5B5B5),
                        width: 2.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.20),
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TextField(
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        hintText: 'Search here',
                        hintStyle: const TextStyle(
                          fontSize: 15,
                          color: Color(0xFF858585),
                        ),
                        contentPadding: EdgeInsets.only(
                          left: width*0.33,
                        ),
                        suffixIcon: Transform.translate(
                          offset: Offset(18, 0),
                          child: Container(
                            width: 78,
                            height: 78,
                            margin: const EdgeInsets.all(3),
                            decoration: const BoxDecoration(
                              color: Color(0xFF143DF4),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                'assets/images/search_icon.svg',
                                width: 28,
                                height: 28,
                                colorFilter: const ColorFilter.mode(
                                  Colors.white,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                          ),
                        ),
                        suffixIconConstraints: const BoxConstraints(
                          minWidth: 86,
                          minHeight: 86,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),

              // Cartoon: independently positioned over TextField
              Positioned(
                left: 1,
                top: -79,
                child: IgnorePointer(
                  child: Image.asset(
                    'assets/images/search_icon_3d.png',
                    width: 108,
                    height: 200,
                    fit: BoxFit.contain,
                    alignment: Alignment.centerLeft,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
