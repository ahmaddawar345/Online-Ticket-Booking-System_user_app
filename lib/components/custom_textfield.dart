import 'package:flutter/material.dart';
import 'package:online_ticket_booking/utils/styles.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool obscureText;
  final VoidCallback? toggleEyeIcon;
  final TextInputType? keyboardType;
  final IconData? suffixIcon;
  final int? lines;
  final FormFieldValidator<String>? validator;
  bool? enabled;
  CustomTextField({
    super.key,
    required this.controller,
    required this.hint,
    this.obscureText = false,
    this.toggleEyeIcon,
    this.keyboardType,
    this.validator,
    this.enabled = true,
    this.suffixIcon,
    this.lines,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
      child: TextFormField(
        maxLines: lines ?? 1,
        obscureText: obscureText,
        validator: validator,
        controller: controller,
        enabled: enabled,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          hintText: hint,
          fillColor: const Color(0xfffce4ec),
          filled: true,
          suffixIcon: GestureDetector(onTap: toggleEyeIcon, child: Icon(suffixIcon, color: AppColors.greenDark)),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xff2D3142)),
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xff2D3142)),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        keyboardType: keyboardType,
      ),
    );
  }
}
