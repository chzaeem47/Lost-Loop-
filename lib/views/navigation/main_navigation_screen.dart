import 'package:flutter/material.dart';
import '../../core/routes/app_routes.dart';
import '../../core/services/auth_service.dart';
import '../home/home_screen.dart';
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
    const _PlaceholderScreen(title: "Search Screen"),
    const _PlaceholderScreen(title: "Matches / Links Screen"),
    const _PlaceholderScreen(title: "Reports Screen"),
    const _PlaceholderScreen(title: "Profile Screen"),
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

class _PlaceholderScreen extends StatelessWidget {
  final String title;
  const _PlaceholderScreen({required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
