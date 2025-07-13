import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../App Colors/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final Color? textColor;
  final Color? btnColor;
  final double? btnHeight;
  final double? textSize;
  final double? btnWidth;
  final BorderSide? border;
  final Widget? child;
  final Function()? onPressed;
  const CustomButton(
      {super.key,
      this.text,
      this.textColor,
      this.btnColor,
      this.onPressed,
      this.btnHeight,
      this.btnWidth,
      this.border,
      this.textSize,
      this.child});

  @override
  Widget build(BuildContext context) {
    bool responsiveSize = MediaQuery.sizeOf(context).width < 600;

    return SizedBox(
      height: btnHeight ?? 45.h,
      width: btnWidth ?? double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          elevation: 0,
          maximumSize: Size(double.infinity, 50.h),
          minimumSize: Size(double.infinity, 30.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.sp),
            side: border ?? BorderSide.none,
          ),
          backgroundColor: btnColor ?? AppColors.redColor,
          foregroundColor: textColor ?? AppColors.whiteColor,
          disabledBackgroundColor: AppColors.greyColor,
          disabledForegroundColor: AppColors.whiteColor,
        ),
        onPressed: onPressed,
        child: Center(
          child: child ??
              Text(
                text ?? "text",
                style: TextStyle(
                  fontSize: responsiveSize ? textSize : 10.sp,
                  color: textColor ?? AppColors.whiteColor,
                ),
              ),
        ),
      ),
    );
  }
}
