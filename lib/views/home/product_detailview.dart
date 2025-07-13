// ignore_for_file: deprecated_member_use

import 'package:ecommerce_app/bloc/cart/cart_cubit.dart';
import 'package:ecommerce_app/bloc/product/product_detail_cubit.dart';
import 'package:ecommerce_app/utlis/App%20Colors/app_colors.dart';
import 'package:ecommerce_app/utlis/Global%20Widgets/custom_button.dart';
import 'package:ecommerce_app/utlis/Global%20Widgets/custom_snakbar.dart';
import 'package:ecommerce_app/utlis/sizebox_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pureWhite,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.pureWhite,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          'Details',
          style: TextStyle(
            color: AppColors.blackColor,
            fontWeight: FontWeight.normal,
            fontFamily: "OpenSanS_Light",
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              backgroundColor: Colors.black.withOpacity(.05),
              child: IconButton(
                icon: const Icon(Icons.share, color: AppColors.blackColor),
                splashRadius: 15,
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
      body: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
        builder: (context, state) {
          if (state is ProductDetailsLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.deepPurple,
                strokeWidth: 4,
                strokeCap: StrokeCap.round,
              ),
            );
          } else if (state is ProductDetailsError) {
            return Center(child: Text(state.message));
          } else if (state is ProductDetailsLoaded) {
            final product = state.product;
            final cart = context.watch<CartCubit>();
            final alreadyInCart = cart.state.items
                .any((item) => item.productId == product.id);

            return Column(
              children: [
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                        child: Image.network(
                          product.image,
                          height: 200.h,
                          width: double.infinity,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).padding.top + 40,
                      left: 20,
                      right: 25,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CircleAvatar(
                            backgroundColor: AppColors.whiteColor,
                            child: IconButton(
                              icon: const Icon(Icons.favorite_border,
                                  color: AppColors.blackColor),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.title,
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: AppColors.darkgreyColor,
                            fontFamily: "OpenSans",
                          ),
                        ),
                        8.sizedBoxHeight,
                        Text(
                          "\$${product.price.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: AppColors.blackColor,
                            fontWeight: FontWeight.w600,
                            fontFamily: "OpenSans",
                          ),
                        ),
                        10.sizedBoxHeight,
                        Text(
                          product.description,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.blackColor,
                            overflow: TextOverflow.ellipsis,
                            fontFamily: "OpenSans_Light",
                          ),
                          maxLines: 3,
                        ),
                        24.sizedBoxHeight,
                        Row(
                          children: [
                            Expanded(
                              child: CustomButton(
                                text: alreadyInCart ? "Added" : "Add to Cart",
                                btnColor: alreadyInCart
                                    ? Colors.grey
                                    : AppColors.deepPurple,
                                textColor: AppColors.whiteColor,
                                onPressed: alreadyInCart
                                    ? null
                                    : () {
  cart.addToCart(product); 
  CustomizedSnackbar.show(context: context, label: "Alert", message: 'Added to cart!');
                                       
                                      },
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: CustomButton(
                                text: "Buy Now",
                                btnColor: AppColors.darkgreyColor,
                                textColor: AppColors.blackColor,
                                onPressed: () {
                                  // Implement buy now logic
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
