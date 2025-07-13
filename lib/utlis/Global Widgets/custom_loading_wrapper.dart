import 'package:ecommerce_app/utlis/App%20Colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class CustomLoadingWrapper extends StatelessWidget {
  final bool isLoading;
  final Widget child;
  const CustomLoadingWrapper(
      {super.key, required this.isLoading, required this.child});

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
        inAsyncCall: isLoading,
        progressIndicator: const CircularProgressIndicator(
          color: AppColors.deepPurple,
          strokeWidth: 6,
          strokeCap: StrokeCap.round,
        ),
        blur: 2.5,
        child: child);
  }
}
