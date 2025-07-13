import 'package:ecommerce_app/bloc/auth/auth_state.dart';
import 'package:ecommerce_app/utlis/App%20Colors/app_colors.dart';
import 'package:ecommerce_app/utlis/Global%20Widgets/custom_button.dart';
import 'package:ecommerce_app/utlis/Global%20Widgets/custom_loading_wrapper.dart';
import 'package:ecommerce_app/utlis/Global%20Widgets/custom_snakbar.dart';
import 'package:ecommerce_app/utlis/Global%20Widgets/custom_text_field.dart';
import 'package:ecommerce_app/utlis/constants/app_assets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ecommerce_app/utlis/constants/app_strings.dart';
import 'package:ecommerce_app/utlis/sizebox_extension.dart';
import 'package:ecommerce_app/viewModels/loginview_model.dart';
import 'package:ecommerce_app/views/auth/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart'; 

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  late final LoginViewModel viewModel;
                bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    final authCubit = context.read<AuthCubit>();
    viewModel = LoginViewModel(authCubit);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
  listener: (context, state) {
    if (state is AuthSuccess) {
      Navigator.pushReplacementNamed(context, '/home');
    } else if (state is AuthError) {
      CustomizedSnackbar.show(
        context: context,
        label: AppStrings.alertLabel,
        message: state.message,
      );
    }
  },
  builder: (context, state) {
    return CustomLoadingWrapper(
      isLoading: state is AuthLoading, 
      child: Scaffold(
        backgroundColor: AppColors.pureWhite,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              40.sizedBoxHeight,
              SvgPicture.asset(
                AppAssets.logo,
                height: 220.h,
                width: 220.w,
              ),
              20.sizedBoxHeight,
              CustomTextfield(
                hintText: "Name....",
                controller: usernameController,
                labelText: AppStrings.usernameLabel,
              ),
              16.sizedBoxHeight,
              CustomTextfield(
                controller: passwordController,
                hintText: "Password.....",
                labelText: AppStrings.passwordLabel,
                obscureText: _obscurePassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() => _obscurePassword = !_obscurePassword);
                  },
                ),
              ),
              20.sizedBoxHeight,
              CustomButton(
                btnColor: AppColors.deepPurple,
                onPressed: () {
                  viewModel.login(
                    usernameController.text.trim(),
                    passwordController.text.trim(),
                  );
                },
                child: const Text(
                  AppStrings.loginButton,
                  style: TextStyle(color: AppColors.pureWhite),
                ),
              ),
              10.sizedBoxHeight,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.black54,
                    ),
                  ),
                  4.w.sizedBoxWidth,
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/signup');
                    },
                    child: Text(
                      "Sign up",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.deepPurple,
                        fontWeight: FontWeight.w600,
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
  },
);
}
}
