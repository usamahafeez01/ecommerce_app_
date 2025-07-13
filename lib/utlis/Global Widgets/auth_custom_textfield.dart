// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthCustomTextField extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  final String? hintText;
  final bool obscureText;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final AutovalidateMode autovalidateMode; // Make this non-nullable

  const AuthCustomTextField({
    super.key,
    this.onChanged,
    this.hintText,
    this.obscureText = false,
    required this.controller,
    this.keyboardType, // Make this nullable
    this.validator,
    this.autovalidateMode = AutovalidateMode.disabled, // Default to 'disabled'
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.h),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType ??
            TextInputType.text, // Default to TextInputType.text if null
        obscureText: obscureText,
        style: TextStyle(
          fontSize: 11.sp,
          fontFamily: "OpenSans",
        ),
        validator: validator,
        onChanged: onChanged,
        autovalidateMode: autovalidateMode, // Now this is always a valid value
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontFamily: "OpenSans",
            fontSize: 11.sp,
            color: Colors.grey,
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: 12.h,
            horizontal: 12.w,
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
