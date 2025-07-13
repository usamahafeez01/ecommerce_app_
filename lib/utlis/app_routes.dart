

import 'package:ecommerce_app/bloc/product/product_detail_cubit.dart';
import 'package:ecommerce_app/services/product_services.dart';
import 'package:ecommerce_app/views/auth/cubit/auth_cubit.dart';
import 'package:ecommerce_app/views/auth/loginview.dart';
import 'package:ecommerce_app/views/cart/cartview.dart';
import 'package:ecommerce_app/views/home/homeview.dart';
import 'package:ecommerce_app/views/home/product_detailview.dart';
import 'package:ecommerce_app/views/profile/profileview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRoutes {
  // Route Names
  static const String home = '/home';

  static const String login = '/login';
  static const String signup = '/signup';
  static const String cart = '/cart';
    static const String profile  = '/profile';       

  
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
  return MaterialPageRoute(
    builder: (context) => BlocProvider.value(
      value: context.read<AuthCubit>(), 
      child: const LoginScreen(),
    ),
  );
case profile:
        // We expect the caller to pass the user‑id as an int
        final int? userId = settings.arguments as int?;
        if (userId == null) {
          return _errorRoute('profile route requires an int userId argument');
        }
        return MaterialPageRoute(
          builder: (_) => ProfileScreen(userId: userId),
        );
    case AppRoutes.cart:
  return MaterialPageRoute(
    builder: (_) => const CartScreen(),
  );


       case home:
         return MaterialPageRoute(builder: (_) =>  HomeScreen());
      case '/product-details':
  final int id = settings.arguments as int;
  return MaterialPageRoute(
    builder: (_) => BlocProvider(
      create: (_) => ProductDetailsCubit(ProductService())..fetchProduct(id),
      child: ProductDetailsView(),
    ),
  );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Page not found')),
          ),
        );
    }
  }
  static MaterialPageRoute _errorRoute(String message) => MaterialPageRoute(
  builder: (_) => Scaffold(
    appBar: AppBar(title: const Text('Error')),
    body: Center(child: Text(message)),
  ),
);
}
