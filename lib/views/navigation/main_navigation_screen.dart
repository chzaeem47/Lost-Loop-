import 'package:flutter/material.dart';
import '../../core/routes/app_routes.dart';
import '../../core/services/auth_service.dart';
import '../home/home_screen.dart';
import '../items/lost_items_screen.dart';
import '../profile/profile_screen.dart';
import 'widgets/custom_bottom_nav.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    // Auth Guard: Redirects to Splash/Auth Screen if user is not logged in
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!AuthService.instance.isLoggedIn) {
        Navigator.pushReplacementNamed(context, AppRoutes.splash);
      }
    });
  }

  final List<Widget> _screens = [
    const HomeScreen(),
    const LostItemsScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: CustomBottomNav(
        selectedIndex: _currentIndex,
        onTabSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
