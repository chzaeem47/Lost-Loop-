import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/routes/app_routes.dart';
import 'custom_auth_field.dart';

class AuthBottomSheet extends StatefulWidget {
  final bool initialIsLogin;

  const AuthBottomSheet({
    super.key,
    this.initialIsLogin = false,
  });

  @override
  State<AuthBottomSheet> createState() => _AuthBottomSheetState();
}

class _AuthBottomSheetState extends State<AuthBottomSheet> {
  late bool isLogin;
  bool isVisible = false;

  @override
  void initState() {
    super.initState();
    isLogin = widget.initialIsLogin;
  }

  void _navigateToHome() {
    Navigator.pushReplacementNamed(context, AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.primaryBlue,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 20,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                isLogin ? "Welcome Back" : "Create Account",
                style: AppTextStyles.authTitle,
              ),
              const SizedBox(height: 2),
              Text(
                "Let's help bring lost things home",
                style: AppTextStyles.authSubTitle,
              ),

              const SizedBox(height: 18),

              // Inputs
              if (!isLogin) ...[
                const CustomAuthField(
                  label: "Name",
                  hintText: "Name",
                  icon: Icons.person_outline_rounded,
                ),
                const SizedBox(height: 12),
              ],

              const CustomAuthField(
                label: "Email address",
                hintText: "Email address",
                icon: Icons.mark_email_read_outlined,
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 12),

              CustomAuthField(
                label: "Password",
                hintText: "Password",
                icon: Icons.vpn_key_outlined,
                isPassword: true,
                isVisible: isVisible,
                onToggleVisibility: () {
                  setState(() {
                    isVisible = !isVisible;
                  });
                },
              ),

              if (isLogin) ...[
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(0, 30),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: () {},
                    child: Text(
                      "Forgot password?",
                      style: GoogleFonts.tinos(
                        color: AppColors.cyanAccent,
                        fontSize: 15,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),
              ] else ...[
                const SizedBox(height: 16),
              ],

              const SizedBox(height: 12),

              // Login / Signup Primary Button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.darkNavy,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: _navigateToHome,
                  child: Text(
                    isLogin ? "Login" : "Signup",
                    style: AppTextStyles.buttonText.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Continue with Google Button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.inputBg,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: _navigateToHome,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AppAssets.googleLogo,
                        width: 22,
                        height: 22,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "Continue with Google",
                        style: GoogleFonts.tinos(
                          fontStyle: FontStyle.italic,
                          fontSize: 18,
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Bottom Toggle Row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    isLogin ? "New here? " : "Already have a account? ",
                    style: GoogleFonts.tinos(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isLogin = !isLogin;
                      });
                    },
                    child: Text(
                      isLogin ? "Signup" : "Login",
                      style: GoogleFonts.tinos(
                        fontSize: 17,
                        color: AppColors.cyanAccent,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
