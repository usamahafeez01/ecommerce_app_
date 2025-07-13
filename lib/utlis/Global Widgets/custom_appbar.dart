import 'package:ecommerce_app/bloc/auth/auth_state.dart';
import 'package:ecommerce_app/bloc/theme/theme_cubit.dart';
import 'package:ecommerce_app/utlis/App%20Colors/app_colors.dart';
import 'package:ecommerce_app/utlis/constants/app_assets.dart';
import 'package:ecommerce_app/utlis/constants/app_strings.dart';
import 'package:ecommerce_app/utlis/sizebox_extension.dart';
import 'package:ecommerce_app/views/auth/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onFilterTap;
  final List<String> categories;
  final String? selectedCategory;
  final void Function(String category) onCategorySelected;

  const CustomHomeAppBar({
    super.key,
    required this.onFilterTap,
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Size get preferredSize => const Size.fromHeight(170);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          // Profile Image
          CircleAvatar(
            radius: 20.r,
            backgroundColor: Colors.transparent,
            child: ClipOval(
              child: SvgPicture.asset(
                AppAssets.profileImage,
                height: 40.r,
                width: 40.r,
                fit: BoxFit.cover,
              ),
            ),
          ),
          10.sizedBoxWidth,

          // Greeting Text
          Expanded(
            child: BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                String greeting = 'Hi, Guest';
                if (state is AuthSuccess) {
                  final user = state.user;
                  greeting = 'Hi, ${user.firstName}';
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      greeting,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                    Text(
                      '${AppStrings.welcomeText} 👋',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontFamily: 'OpenSans_Light',
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

          IconButton(
    icon: Icon(Icons.brightness_6, color: Colors.black),
    onPressed: () {
      context.read<ThemeCubit>().toggleTheme();
    },
  ),
          
        ],
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              8.h.sizedBoxHeight,
              Container(
                height: 45.h,
                decoration: BoxDecoration(
                  color: AppColors.greyColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: Colors.black87),
                    8.sizedBoxWidth,
                    const Expanded(
                      child: Text(
                        "Search something...",
                        style: TextStyle(color: Colors.black26),
                      ),
                    ),
                    GestureDetector(
                      onTap: onFilterTap,
                      child: const Icon(Icons.tune),
                    )
                  ],
                ),
              ),

              if (categories.isNotEmpty) ...[
                10.h.sizedBoxHeight,
                SizedBox(
                  height: 30.h,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    physics: const BouncingScrollPhysics(),
                    separatorBuilder: (_, __) => 8.sizedBoxWidth,
                    itemBuilder: (context, index) {
                      final cat = categories[index];
                      final isSelected = cat == selectedCategory;

                      return GestureDetector(
                        onTap: () => onCategorySelected(cat),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 4.sp),
                          decoration: BoxDecoration(
                            color: isSelected ? AppColors.deepPurple : Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            cat,
                            style: TextStyle(
                              color: isSelected ? AppColors.whiteColor : Colors.black87,
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
