// lib/widgets/custom_bottom_nav_bar.dart
// ignore_for_file: depend_on_referenced_packages

import 'package:ecommerce_app/utlis/App%20Colors/app_colors.dart';
import 'package:ecommerce_app/utlis/app_routes.dart';            
import 'package:ecommerce_app/utlis/constants/app_assets.dart';
import 'package:ecommerce_app/utlis/constants/app_strings.dart';
import 'package:ecommerce_app/views/auth/cubit/auth_cubit.dart'; 
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';                 
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap; // callback used for the first 4 tabs only

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.whiteColor,
      selectedItemColor: AppColors.deepPurple,
      unselectedItemColor: AppColors.darkgreyColor,
      currentIndex: currentIndex,

      /* ------------------------------------------------------------------ */
      /* Tap handler: 0–3 → delegate, 4 (profile) → pushNamed('/profile')   */
      /* ------------------------------------------------------------------ */
     onTap: (index) async {
  if (index == 4) {
    final auth = context.read<AuthCubit>();
    final user = auth.currentUser; // helper we added earlier

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please log in to view profile')),
      );
      return;
    }

    // use rootNavigator in case you're inside a nested one
    await Navigator.of(context, rootNavigator: true).pushNamed(
      AppRoutes.profile,
      arguments: user.id,
    );
  } else {
    onTap(index); // the callback you already pass down
  }
},
      showSelectedLabels: true,
      showUnselectedLabels: true,
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            AppAssets.homeIcon,
            colorFilter: ColorFilter.mode(
              currentIndex == 0 ? AppColors.pureredColor : Colors.grey,
              BlendMode.srcIn,
            ),
            height: 20,
          ),
          label: AppStrings.homeNavText,
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            AppAssets.trendingIcon,
            colorFilter: ColorFilter.mode(
              currentIndex == 1 ? AppColors.pureredColor : Colors.grey,
              BlendMode.srcIn,
            ),
            height: 20,
          ),
          label: AppStrings.trendingNavText,
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            AppAssets.favouriteIcon,
            colorFilter: ColorFilter.mode(
              currentIndex == 2 ? AppColors.pureredColor : Colors.grey,
              BlendMode.srcIn,
            ),
            height: 20,
          ),
          label: AppStrings.favNavText,
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            AppAssets.cartIcon,
            colorFilter: ColorFilter.mode(
              currentIndex == 3 ? AppColors.pureredColor : Colors.grey,
              BlendMode.srcIn,
            ),
            height: 20,
          ),
          label: AppStrings.cartNavText,
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            AppAssets.profileIcon,
            colorFilter: ColorFilter.mode(
              currentIndex == 4 ? AppColors.pureredColor : Colors.grey,
              BlendMode.srcIn,
            ),
            height: 20,
          ),
          label: AppStrings.profileNavText,
        ),
      ],
    );
  }
}
