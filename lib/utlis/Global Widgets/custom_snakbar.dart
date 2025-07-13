import 'package:ecommerce_app/utlis/App%20Colors/app_colors.dart';
import 'package:ecommerce_app/utlis/sizebox_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomizedSnackbar {
  static bool _isSnackbarVisible = false;

  static void show({
    required BuildContext context,
    required String label,
    required String message,
    Color backgroundColor = Colors.white,
    Color textColor = Colors.black,
    int durationInSeconds = 3,
  }) {
    if (_isSnackbarVisible) return;

    _isSnackbarVisible = true;

    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
      duration: Duration(seconds: durationInSeconds),
      content: TweenAnimationBuilder<Offset>(
        tween: Tween(begin: const Offset(0, 1), end: Offset.zero),
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOut,
        builder: (context, value, child) {
          return Transform.translate(
            offset: value * 50,
            child: child,
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppColors.redColor.withOpacity(0.6),
                blurRadius: 2,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: "OpenSans_Bold",
                  color: textColor.withOpacity(0.9),
                  fontWeight: FontWeight.bold,
                ),
              ),
              4.h.sizedBoxHeight,
              Text(
                message,
                style: TextStyle(
                  fontSize: 11,
                  color: textColor,
                  fontFamily: "OpenSans_Light",
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    ScaffoldMessenger.of(context)
        .showSnackBar(snackBar)
        .closed
        .then((_) => _isSnackbarVisible = false);
  }
}
