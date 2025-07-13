// lib/screens/profile_screen.dart
// ignore_for_file: deprecated_member_use, unused_element

import 'package:ecommerce_app/bloc/profile/profile_state.dart';
import 'package:ecommerce_app/models/user_profile_model.dart';
import 'package:ecommerce_app/utlis/App%20Colors/app_colors.dart';
import 'package:ecommerce_app/utlis/Global%20Widgets/custom_text_field.dart';
import 'package:ecommerce_app/utlis/constants/app_assets.dart';
import 'package:ecommerce_app/utlis/sizebox_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required this.userId});
  final int userId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (c) => ProfileCubit(context.read())..load(userId),
      child: Scaffold(
        backgroundColor: AppColors.pureWhite,
       appBar: AppBar(
    elevation: 0,                          
    backgroundColor: AppColors.pureWhite,
    centerTitle: true,
    automaticallyImplyLeading: false,       
    title: const Text(
      'Profile',
      style: TextStyle(
        color: AppColors.blackColor,
        fontWeight: FontWeight.normal,
        fontFamily: "OpenSanS_Light"
      ),
    ),
    leading: Padding(
      padding: const EdgeInsets.only(left: 16),
      child: CircleAvatar(
        backgroundColor: Colors.black.withOpacity(.05),
        child: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.blackColor),
          splashRadius: 15,
          onPressed: () => Navigator.pop(context),
        ),
      ),
    ),

   ),
     body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator(
                      color: AppColors.deepPurple,
                      strokeWidth: 4,
                      strokeCap: StrokeCap.round,
                    ),
                  );
            }
            if (state.error != null) {
              return Center(child: Text(state.error!));
            }

            final user = state.user;
            if (user == null) return const SizedBox.shrink();

            return _ProfileBody(user: user);
          },
        ),
      ),
    );
  }
}


class _ProfileBody extends StatelessWidget {
  const _ProfileBody({required this.user});
  final UserProfile user;

  @override
  Widget build(BuildContext context) {
    final fullName = '${user.firstName} ${user.lastName}';
    final address = '${user.address.street}, ${user.address.city}';
    final geo = '${user.address.geo.lat}, ${user.address.geo.long}';

    Widget field(String label, String value) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: CustomTextfield(
          labelText: label,
          controller: TextEditingController(text: value),
          readOnly: true,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
20.sizedBoxHeight,          CircleAvatar(
    radius: 40,
    backgroundColor: Colors.grey[200],
    child: ClipOval(
      child: SvgPicture.asset(
        AppAssets.profileImage,
        width: 60.w,
        height: 60.h,
        fit: BoxFit.cover,
      ),
     )), 20.sizedBoxHeight,
          Text(
            fullName,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(
            '@${user.username}',
            style: Theme.of(context)
                .textTheme
                .labelSmall
                ?.copyWith(color: AppColors.greyColor),
          ),
16.sizedBoxHeight,          field('Email', user.email),
          field('Phone', user.phone),
          field('Address', address),
          field('Geo', geo),
        ],
      ),
    );
  }
}

/* ────────────────────────── Row helper ───────────────────────── */

class _Row extends StatelessWidget {
  const _Row({required this.label, required this.value});
  final String label, value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$label: ',
              style: const TextStyle(fontWeight: FontWeight.w600)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
