
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:semes_project/Signup.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash>
    with TickerProviderStateMixin {

  late AnimationController _introController;
  late AnimationController _exitController;

  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  bool _showSplash = true;

  @override
  void initState() {
    super.initState();

    // Opening animation
    _introController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 4),
    );

    _scaleAnimation = CurvedAnimation(
      parent: _introController,
      curve: Curves.easeOutBack,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _introController,
      curve: Curves.easeIn,
    );

    // Exit animation
    _exitController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 5000),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(0, -1),
    ).animate(
      CurvedAnimation(
        parent: _exitController,
        curve: Curves.easeInOutSine,
      ),
    );

    // Start intro animation
    _introController.forward();

    // Wait for intro, pause, and then slide upwards
    Future.delayed(Duration(seconds: 5), () async {

      if (!mounted) return;

      // Stay still for 700 milliseconds
      await Future.delayed(Duration(milliseconds: 700));

      if (!mounted) return;

      // Start exit animation
      await _exitController.forward();

      if (!mounted) return;

      // Remove splash and reveal Signup
      setState(() {
        _showSplash = false;
      });
    });
  }

  @override
  void dispose() {
    _introController.dispose();
    _exitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        // Signup screen built underneath the splash
        Positioned.fill(
          child: Signup(),
        ),

        // Splash screen on top
        if (_showSplash)
          Positioned.fill(
            child: SlideTransition(
              position: _slideAnimation,
              child: Scaffold(
                body: Stack(
                  children: [

                    // Background Image
                    Positioned.fill(
                      child: Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              'assets/images/splash_bg.png',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),

                    // Logo and Text Animation
                    Center(
                      child: ScaleTransition(
                        scale: _scaleAnimation,
                        child: FadeTransition(
                          opacity: _fadeAnimation,
                          child: FittedBox(
                            fit: BoxFit.contain,
                            alignment: Alignment.center,
                            child: SizedBox(
                              width: 390,
                              height: 844,
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [

                                  // Lost Heading
                                  Text(
                                    'Lost',
                                    style: GoogleFonts.nunito(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 60,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 4,
                                      shadows: [
                                        Shadow(
                                          color: Colors.black.withValues(
                                            alpha: 0.5,
                                          ),
                                          blurRadius: 10,
                                          offset: Offset(0, 6),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // LostLoop Logo
                                  Transform.translate(
                                    offset: Offset(0, -15),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [

                                        Text(
                                          "L",
                                          style: GoogleFonts.nunito(
                                            fontStyle: FontStyle.italic,
                                            color: const Color(0xff143df4),
                                            fontSize: 80,
                                            fontWeight: FontWeight.w800,
                                            letterSpacing: 4,
                                            shadows: [
                                              Shadow(
                                                color: Colors.black.withValues(
                                                  alpha: 0.5,
                                                ),
                                                blurRadius: 10,
                                                offset: Offset(0, 6),
                                              ),
                                            ],
                                          ),
                                        ),

                                        Image.asset(
                                          "assets/images/infinity_logo.png",
                                          width: 120,
                                          height: 70,
                                          fit: BoxFit.cover,
                                        ),

                                        Text(
                                          "p",
                                          style: GoogleFonts.nunito(
                                            fontStyle: FontStyle.italic,
                                            color: const Color(0xff143df4),
                                            fontSize: 80,
                                            fontWeight: FontWeight.w800,
                                            letterSpacing: 4,
                                            shadows: [
                                              Shadow(
                                                color: Colors.black.withValues(
                                                  alpha: 0.5,
                                                ),
                                                blurRadius: 10,
                                                offset: Offset(0, 6),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Tagline
                                  Transform.translate(
                                    offset: Offset(0, -18),
                                    child: Text(
                                      "Lost Items Found Again",
                                      style: GoogleFonts.nunito(
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.w800,
                                        letterSpacing: 4,
                                        shadows: [
                                          Shadow(
                                            color: Colors.black.withValues(
                                              alpha: 0.5,
                                            ),
                                            blurRadius: 5,
                                            offset: Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
