import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/services/auth_service.dart';
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
  bool isLoadingGoogle = false;
  bool isLoadingForm = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _nameError;
  String? _emailError;
  String? _passwordError;

  @override
  void initState() {
    super.initState();
    isLogin = widget.initialIsLogin;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _validateInputs() {
    setState(() {
      _nameError = null;
      _emailError = null;
      _passwordError = null;
    });

    bool isValid = true;
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final name = _nameController.text.trim();

    if (!isLogin && name.isEmpty) {
      _nameError = "Please enter your name";
      isValid = false;
    }

    if (email.isEmpty) {
      _emailError = "Email address is required";
      isValid = false;
    } else if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      _emailError = "Please enter a valid email address";
      isValid = false;
    }

    if (password.isEmpty) {
      _passwordError = "Password is required";
      isValid = false;
    } else if (password.length < 6) {
      _passwordError = "Password must be at least 6 characters";
      isValid = false;
    }

    return isValid;
  }

  Future<void> _handleFormSubmit() async {
    if (!_validateInputs()) {
      return;
    }

    setState(() {
      isLoadingForm = true;
    });

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final name = _nameController.text.trim();

    final AuthResult result;
    if (isLogin) {
      result = await AuthService.instance.loginWithEmail(
        email: email,
        password: password,
      );
    } else {
      result = await AuthService.instance.signUpWithEmail(
        email: email,
        password: password,
        name: name,
      );
    }

    setState(() {
      isLoadingForm = false;
    });

    if (!mounted) return;

    if (!result.success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result.message),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(result.message),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );

    Navigator.pushReplacementNamed(context, AppRoutes.home);
  }

  Future<void> _handleGoogleSignIn() async {
    setState(() {
      isLoadingGoogle = true;
    });

    final user = await AuthService.instance.loginWithGoogleFirebase();
    setState(() {
      isLoadingGoogle = false;
    });

    if (user != null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Google login successful! Welcome, ${user.name}"),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );
      Navigator.pushReplacementNamed(context, AppRoutes.home);
      return;
    }

    if (mounted) {
      _showGoogleAccountChooser();
    }
  }

  void _showGoogleAccountChooser() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    SvgPicture.asset(AppAssets.googleLogo, width: 24, height: 24),
                    const SizedBox(width: 10),
                    Text(
                      "Continue with Google",
                      style: GoogleFonts.nunito(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(height: 1),
                const SizedBox(height: 8),

                // Account 1: With Photo (Zaeem)
                ListTile(
                  leading: const CircleAvatar(
                    backgroundImage: AssetImage(AppAssets.userAvatar),
                  ),
                  title: Text(
                    "Zaeem",
                    style: GoogleFonts.nunito(fontWeight: FontWeight.bold),
                  ),
                  subtitle: const Text("zaeem@gmail.com (Has Profile Photo)"),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                  onTap: () {
                    Navigator.pop(context);
                    AuthService.instance.loginWithCustomUser(
                      name: "Zaeem",
                      email: "zaeem@gmail.com",
                      photoUrl: AppAssets.userAvatar,
                      isGoogle: true,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Login successful! Welcome back, Zaeem"),
                        backgroundColor: Colors.green,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                    Navigator.pushReplacementNamed(context, AppRoutes.home);
                  },
                ),

                const Divider(height: 1),

                // Account 2: Without Photo -> Tests user icon fallback
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue.shade100,
                    child: const Icon(Icons.person, color: AppColors.primaryBlue),
                  ),
                  title: Text(
                    "Google User (No Photo)",
                    style: GoogleFonts.nunito(fontWeight: FontWeight.bold),
                  ),
                  subtitle: const Text("user@gmail.com (Shows Person Icon)"),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                  onTap: () {
                    Navigator.pop(context);
                    AuthService.instance.loginWithCustomUser(
                      name: "Google User",
                      email: "user@gmail.com",
                      photoUrl: null, // Shows user icon
                      isGoogle: true,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Login successful! Welcome back, Google User"),
                        backgroundColor: Colors.green,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                    Navigator.pushReplacementNamed(context, AppRoutes.home);
                  },
                ),

                const Divider(height: 1),

                // Custom Account Entry Option
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey.shade200,
                    child: const Icon(Icons.add, color: Colors.black87),
                  ),
                  title: Text(
                    "Use another account",
                    style: GoogleFonts.nunito(fontWeight: FontWeight.w600),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    _showCustomGoogleDialog();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showCustomGoogleDialog() {
    final nameCtrl = TextEditingController(text: "Zaeem");
    final emailCtrl = TextEditingController(text: "zaeem@gmail.com");
    bool includePhoto = true;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Row(
                children: [
                  SvgPicture.asset(AppAssets.googleLogo, width: 22, height: 22),
                  const SizedBox(width: 8),
                  const Text("Google Sign-In"),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameCtrl,
                    decoration: const InputDecoration(labelText: "Display Name"),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: emailCtrl,
                    decoration: const InputDecoration(labelText: "Google Email"),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Checkbox(
                        value: includePhoto,
                        onChanged: (val) {
                          setDialogState(() {
                            includePhoto = val ?? true;
                          });
                        },
                      ),
                      const Expanded(
                        child: Text("Include Profile Photo"),
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    final name = nameCtrl.text.trim();
                    AuthService.instance.loginWithCustomUser(
                      name: name,
                      email: emailCtrl.text.trim(),
                      photoUrl: includePhoto ? AppAssets.userAvatar : null,
                      isGoogle: true,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Login successful! Welcome, $name"),
                        backgroundColor: Colors.green,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                    Navigator.pushReplacementNamed(context, AppRoutes.home);
                  },
                  child: const Text("Continue"),
                ),
              ],
            );
          },
        );
      },
    );
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
                CustomAuthField(
                  label: "Name",
                  hintText: "Name",
                  icon: Icons.person_outline_rounded,
                  controller: _nameController,
                ),
                if (_nameError != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 12, top: 4),
                    child: Text(
                      _nameError!,
                      style: const TextStyle(color: Colors.yellowAccent, fontSize: 12),
                    ),
                  ),
                const SizedBox(height: 12),
              ],

              CustomAuthField(
                label: "Email address",
                hintText: "Email address",
                icon: Icons.mark_email_read_outlined,
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
              ),
              if (_emailError != null)
                Padding(
                  padding: const EdgeInsets.only(left: 12, top: 4),
                  child: Text(
                    _emailError!,
                    style: const TextStyle(color: Colors.yellowAccent, fontSize: 12),
                  ),
                ),

              const SizedBox(height: 12),

              CustomAuthField(
                label: "Password",
                hintText: "Password",
                icon: Icons.vpn_key_outlined,
                isPassword: true,
                isVisible: isVisible,
                controller: _passwordController,
                onToggleVisibility: () {
                  setState(() {
                    isVisible = !isVisible;
                  });
                },
              ),
              if (_passwordError != null)
                Padding(
                  padding: const EdgeInsets.only(left: 12, top: 4),
                  child: Text(
                    _passwordError!,
                    style: const TextStyle(color: Colors.yellowAccent, fontSize: 12),
                  ),
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

              // Primary Button (Login / Signup)
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
                  onPressed: isLoadingForm ? null : _handleFormSubmit,
                  child: isLoadingForm
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
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
                  onPressed: isLoadingGoogle ? null : _handleGoogleSignIn,
                  child: isLoadingGoogle
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Row(
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
                        _nameError = null;
                        _emailError = null;
                        _passwordError = null;
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
