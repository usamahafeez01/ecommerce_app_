// ignore_for_file: deprecated_member_use

import 'package:ecommerce_app/bloc/cart/cart_cubit.dart';
import 'package:ecommerce_app/bloc/cart/cart_state.dart';            // ← no “hide”
import 'package:ecommerce_app/models/cart_model.dart';
import 'package:ecommerce_app/utlis/App%20Colors/app_colors.dart';
import 'package:ecommerce_app/utlis/sizebox_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

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
          'Cart',
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
      ),

      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state.items.isEmpty) {
            return const Center(child: Text('Your cart is empty.'));
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                child: Row(
                  children: [
                    Text(
                      '${state.items.length} item${state.items.length > 1 ? 's' : ''} in cart',
                      style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        'See All',
                        style: TextStyle(
                          color: AppColors.blueColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              4.sizedBoxHeight,
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: state.items.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final item = state.items[index];
                    return _CartItemTile(
                      key: ValueKey(item.productId),
                      item: item,
                      onIncrement: () {
                        // Optional: Handle quantity increase if supported
                      },
                      onDecrement: () {
                        context.read<CartCubit>().removeCartItem(item.productId);
                      },
                      onRemove: () {
                        context.read<CartCubit>().removeCartItem(item.productId);
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),

      bottomNavigationBar: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          final total = state.items.fold<double>(
            0,
            (sum, item) => sum + (item.quantity * (item.product?.price ?? 0)),
          );

          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: const BoxDecoration(
              color: AppColors.pureWhite,
              boxShadow: [BoxShadow(blurRadius: 5, color: Colors.black12)],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total:',
                    style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
                Text(
                  '\$${total.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

/* ────────────────────── Row widget ────────────────────── */
class _CartItemTile extends StatelessWidget {
  const _CartItemTile({
    super.key,
    required this.item,
    required this.onIncrement,
    required this.onDecrement,
    required this.onRemove,
  });

  final CartItem item;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onRemove;

  @override
 @override
Widget build(BuildContext context) {
  final product = item.product;

  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Image
      ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: product != null && product.image.isNotEmpty
            ? Image.network(
                product.image,
                width: 60.w,
                height: 60.h,
                fit: BoxFit.cover,
              )
            : Container(
                width: 60.w,
                height: 60.h,
                color: Colors.grey.shade200,
                child: const Icon(Icons.shopping_bag),
              ),
      ),
      12.sizedBoxWidth,

      // Title & Price
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product?.title ?? 'Item ${item.productId}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
              ),
            ),
            4.sizedBoxHeight,
            Text(
              product != null
                  ? '\$${product.price.toStringAsFixed(2)}'
                  : '--',
              style: TextStyle(
                color: AppColors.blueColor,
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
      ),

      // Quantity Controls
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _QtyButton(
            icon: Icons.remove,
            onTap: item.quantity == 1 ? onRemove : onDecrement,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              '${item.quantity}',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
          _QtyButton(
            icon: Icons.add,
            onTap: onIncrement,
          ),
        ],
      ),
    ],
  );
}
}

class _QtyButton extends StatelessWidget {
  const _QtyButton({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(6),
      onTap: onTap,
      child: Container(
        width: 28.w,
        height: 28.h,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(icon, size: 15.sp, color: AppColors.blackColor),
      ),
    );
  }
}
