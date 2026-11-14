
import 'package:flutter/material.dart';

class SignupTextField extends StatelessWidget {
  final String hintText;
  final IconData prefixIcon;
  final IconData? postfixIcon;
  final bool obscureText;

  const SignupTextField({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    this.postfixIcon,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 380,
      child: TextField(
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,

          hintStyle: TextStyle(
            color: Colors.grey.shade500,
            fontSize: 16,
          ),

          prefixIcon: Padding(
            padding: EdgeInsets.all(4),
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xff143df4),
                borderRadius: BorderRadius.circular(40),
              ),
              child: Icon(
                prefixIcon,
                color: Colors.white,
              ),
            ),
          ),

          suffixIcon: postfixIcon != null
              ? Padding(
            padding: EdgeInsets.only(right: 5),
                child: Icon(
                            postfixIcon,
                            color: Color(0xff143df4),
                          ),
              )
              : null,

          filled: true,
          fillColor: Colors.white,

          contentPadding: EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 18,
          ),

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: BorderSide(
              color: Colors.grey.shade300,
            ),
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: BorderSide(
              color: Colors.grey.shade300,
            ),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: BorderSide(
              color: Color(0xFF143DF4),
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}
