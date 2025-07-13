// ignore_for_file: depend_on_referenced_packages, deprecated_member_use

import 'package:dio/dio.dart';
import 'package:ecommerce_app/bloc/cart/cart_cubit.dart';
import 'package:ecommerce_app/bloc/navigation/bottom_nav_cubit.dart';
import 'package:ecommerce_app/bloc/product/category_cubit.dart';
import 'package:ecommerce_app/bloc/product/product_cubit.dart';
import 'package:ecommerce_app/bloc/theme/theme_cubit.dart';
import 'package:ecommerce_app/repositories/user_repository.dart';
import 'package:ecommerce_app/services/auth_service.dart';
import 'package:ecommerce_app/services/product_services.dart';
import 'package:ecommerce_app/utlis/app_routes.dart';
import 'package:ecommerce_app/utlis/constants/api_constant.dart';
import 'package:ecommerce_app/views/auth/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) {
        return MultiRepositoryProvider(
          providers: [
            RepositoryProvider<Dio>(
              create: (_) => Dio(
                BaseOptions(baseUrl: ApiConstants.baseUrl),
              ),
            ),

            RepositoryProvider<UserRepository>(
              create: (c) => UserRepository(c.read<Dio>()),
            ),
          ],

          child: MultiBlocProvider(
            providers: [
              BlocProvider<AuthCubit>(
                create: (_) => AuthCubit(AuthService()),
              ),
              BlocProvider<ProductCubit>(
                create: (_) => ProductCubit(ProductService()),
              ),
              BlocProvider<CategoryCubit>(
                create: (_) => CategoryCubit(ProductService()),
              ),
              BlocProvider<BottomNavCubit>(
                create: (_) => BottomNavCubit(),
              ),
                      BlocProvider(create: (_) => CartCubit()),
BlocProvider(
      create: (_) => ThemeCubit(),)

            ],

            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              initialRoute: '/login',
              onGenerateRoute: AppRoutes.generateRoute,
              builder: (context, widget) => MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: widget!,
              ),
            ),
          ),
        );
      },
      child: const SizedBox(),
    );
  }
}
