import 'package:ecommerce_app/utlis/sizebox_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../App Colors/app_colors.dart';

class CustomTextfield extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final bool? readOnly;
  final bool? obscureText;
  final TextInputType? inputType;
  final TextEditingController controller;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatters;
    final AutovalidateMode? autovalidateMode;

  // final int? maxLength;

  const CustomTextfield({
    super.key,
    this.labelText,
    this.hintText,
    this.readOnly,
    this.inputFormatters,
    this.obscureText,
    this.inputType,
    required this.controller,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.maxLines = 1,
        this.autovalidateMode,

    // this.maxLength = 10,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         if (labelText != null) ...[
  Padding(
    padding: EdgeInsets.only(left: 5.w), 
    child: Text(
      labelText!,
      style: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
    ),
  ),
  6.h.sizedBoxHeight,
],
 TextFormField(
            controller: controller,
            keyboardType: inputType,
            obscureText: obscureText ?? false,
            readOnly: readOnly ?? false,
            onChanged: onChanged,
            validator: validator,
            maxLines: maxLines,
            // maxLength: maxLength,
            inputFormatters: inputFormatters,
            autovalidateMode: autovalidateMode,
            cursorColor: AppColors.redColor,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.black87,
            ),
            onTapOutside: (event) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.blackColor.withOpacity(.5),
              ),
              suffixIcon: suffixIcon,
              filled: true,
              fillColor: AppColors.pureWhite,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.r),
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.r),
                borderSide: BorderSide(
                  color: AppColors.redColor.withOpacity(.4),
                  width: 1.5,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.r),
                borderSide: BorderSide(color: Colors.red.shade300),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.r),
                borderSide: BorderSide(color: Colors.red.shade400),
              ),
              errorStyle: TextStyle(
                fontSize: 10.sp,
                color: AppColors.pureredColor,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
