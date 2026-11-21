import 'package:flutter/material.dart';

class CustomBottomNavigation extends StatefulWidget {
  final int selectedIndex;
  final ValueChanged<int>? onTabSelected;

  const CustomBottomNavigation({
    super.key,
    this.selectedIndex = 0,
    this.onTabSelected,
  });

  @override
  State<CustomBottomNavigation> createState() => _CustomBottomNavigationState();
}

class _CustomBottomNavigationState extends State<CustomBottomNavigation> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.selectedIndex;
  }

  @override
  void didUpdateWidget(covariant CustomBottomNavigation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedIndex != widget.selectedIndex) {
      _currentIndex = widget.selectedIndex;
    }
  }

  void _handleTabTap(int index) {
    setState(() {
      _currentIndex = index;
    });
    if (widget.onTabSelected != null) {
      widget.onTabSelected!(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Container(
      height: 64 + bottomPadding,
      padding: EdgeInsets.only(bottom: bottomPadding),
      decoration: const BoxDecoration(
        color: Color(0xFF143DF4), // Vibrant Primary Blue
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        border: Border(
          top: BorderSide(
            color: Color(0xFF00C8FF), // Cyan Top Glow Border
            width: 1.8,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Tab 0: Home
          _buildTabItem(
            index: 0,
            child: const Icon(
              Icons.home_outlined,
              color: Colors.white,
              size: 26,
            ),
          ),

          // Tab 1: Search with Yellow Sparkle
          _buildTabItem(
            index: 1,
            child: Stack(
              clipBehavior: Clip.none,
              children: const [
                Icon(
                  Icons.search_rounded,
                  color: Colors.white,
                  size: 26,
                ),
                Positioned(
                  top: -2,
                  right: -3,
                  child: Icon(
                    Icons.auto_awesome,
                    color: Color(0xFFFFE600), // Vibrant Yellow Sparkle
                    size: 12,
                  ),
                ),
              ],
            ),
          ),

          // Tab 2: Link / Matches
          _buildTabItem(
            index: 2,
            child: const Icon(
              Icons.link_rounded,
              color: Colors.white,
              size: 26,
            ),
          ),

          // Tab 3: Document / Reports
          _buildTabItem(
            index: 3,
            child: const Icon(
              Icons.description_outlined,
              color: Colors.white,
              size: 25,
            ),
          ),

          // Tab 4: Profile / User Account
          _buildTabItem(
            index: 4,
            child: const Icon(
              Icons.account_circle_outlined,
              color: Colors.white,
              size: 26,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem({
    required int index,
    required Widget child,
  }) {
    final isSelected = _currentIndex == index;

    return InkWell(
      onTap: () => _handleTabTap(index),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
        width: 54,
        height: 58,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF080D70) : Colors.transparent, // Navy Dome
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(22),
            topRight: Radius.circular(22),
          ),
        ),
        child: child,
      ),
    );
  }
}
