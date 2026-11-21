
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:semes_project/Footer/rights_footer.dart';
import 'package:semes_project/custom_widgets/TextField.dart';

class Forgot extends StatefulWidget {
  const Forgot({super.key});

  @override
  State<Forgot> createState() => _ForgotState();
}

class _ForgotState extends State<Forgot> {

  TextEditingController emailController = TextEditingController();
  bool isLoading = false;

  Future<void> sendResetLink() async {
    final email = emailController.text.trim();

    // Check empty email
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please enter your email to get the reset link",
            style: TextStyle(color: Colors.white),
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );

      return;
    }
    // Start loading
    setState(() {
      isLoading = true;
    });
    try {
      // Send password reset email through Firebase
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: email,
      );
      if (!mounted) return;
      // Success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("If an account exists for this email, a reset link will be sent.", style: TextStyle(color: Colors.white),),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 3),
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      // Firebase error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.message ?? "Unable to send reset link!",
            style: TextStyle(color: Colors.white),
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      // Other errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Something went wrong!",
            style: TextStyle(color: Colors.white),
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    } finally {
      // Stop loading
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Full-screen background
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/signup-bg.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Responsive content
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                // Original width: 332px
                // Smaller screens automatically reduce it
                final double contentWidth =
                (constraints.maxWidth - 28)
                    .clamp(0.0, 332.0)
                    .toDouble();
                // Reduce top spacing on shorter screens
                final double topPadding =
                constraints.maxHeight < 650 ? 20 : 50;
                return SingleChildScrollView(
                  keyboardDismissBehavior:
                  ScrollViewKeyboardDismissBehavior.onDrag,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        children: [
                          // Email field and reset button
                          Expanded(
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.only(
                                  top: topPadding,
                                ),
                                child: SizedBox(
                                  width: contentWidth,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [

                                      SignupTextField(
                                        hintText:
                                        "Enter your email to get a reset link",
                                        prefixIcon: Icons.email,
                                        controller: emailController,
                                      ),

                                      SizedBox(height: 20),

                                      TextButton(
                                        onPressed: isLoading
                                            ? null
                                            : sendResetLink,

                                        style: TextButton.styleFrom(
                                          backgroundColor:
                                          Color(0xFF07076C),

                                          shape:
                                          RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(30),
                                          ),

                                          padding: EdgeInsets.all(11),
                                        ),

                                        child: isLoading
                                            ? SizedBox(
                                          width: 22,
                                          height: 22,
                                          child:
                                          CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2,
                                          ),
                                        )
                                            : Padding(
                                          padding:
                                          EdgeInsets.all(5),

                                          child: Text(
                                            "Get Reset Link",

                                            style: GoogleFonts
                                                .ibmPlexSans(
                                              color: Colors.white,
                                              fontStyle:
                                              FontStyle.italic,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // Footer
                          RightsFooter(),

                          SizedBox(height: 15),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Back button overlay
          Positioned(
            top: 10,
            left: 3,

            child: SafeArea(
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },

                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}
