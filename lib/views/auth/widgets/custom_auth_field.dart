import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

class CustomAuthField extends StatelessWidget {
  final String label;
  final String hintText;
  final IconData icon;
  final bool isPassword;
  final bool isVisible;
  final VoidCallback? onToggleVisibility;
  final TextEditingController? controller;
  final TextInputType? keyboardType;

  const CustomAuthField({
    super.key,
    required this.label,
    required this.hintText,
    required this.icon,
    this.isPassword = false,
    this.isVisible = false,
    this.onToggleVisibility,
    this.controller,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.inputLabel,
        ),
        const SizedBox(height: 5),
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: AppColors.inputBg,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryBlue,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: controller,
                  obscureText: isPassword && !isVisible,
                  keyboardType: keyboardType,
                  style: AppTextStyles.inputText,
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: AppTextStyles.inputText.copyWith(
                      color: Colors.black45,
                    ),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
              if (isPassword)
                Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: IconButton(
                    icon: Icon(
                      isVisible ? Icons.visibility : Icons.visibility_off,
                      color: AppColors.primaryBlue,
                      size: 22,
                    ),
                    onPressed: onToggleVisibility,
                  ),
                )
              else
                const SizedBox(width: 12),
            ],
          ),
        ),
      ],
    );
  }
}
