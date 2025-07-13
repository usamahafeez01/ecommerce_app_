import 'package:ecommerce_app/bloc/cart/cart_cubit.dart';
import 'package:ecommerce_app/bloc/navigation/bottom_nav_cubit.dart';
import 'package:ecommerce_app/bloc/product/category_cubit.dart';
import 'package:ecommerce_app/bloc/product/product_cubit.dart';
import 'package:ecommerce_app/bloc/product/product_state.dart';
import 'package:ecommerce_app/utlis/App%20Colors/app_colors.dart';
import 'package:ecommerce_app/utlis/Global%20Widgets/bottom_navigation.dart';
import 'package:ecommerce_app/utlis/Global%20Widgets/custom_appbar.dart';
import 'package:ecommerce_app/utlis/Global%20Widgets/custom_snakbar.dart';
import 'package:ecommerce_app/views/home/product_cardview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
 @override
@override
Widget build(BuildContext context) {
  // Fetch products and categories once
  context.read<ProductCubit>().fetchAllProducts();
  context.read<CategoryCubit>().fetchCategories();

  return Scaffold(
    backgroundColor: AppColors.pureWhite,

    appBar: PreferredSize(
      preferredSize: const Size.fromHeight(130),
      child: BlocBuilder<CategoryCubit, CategoryState>(
        builder: (context, categoryState) {
          return CustomHomeAppBar(
            onFilterTap: () {
              showModalBottomSheet(
                backgroundColor: AppColors.pureWhite,
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                builder: (_) {
                  return ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    children: categoryState.categories.map((cat) {
                      final isSelected = categoryState.selectedCategory == cat;
                      return ListTile(
                        title: Text(
                          cat,
                          style: TextStyle(
                            color: isSelected
                                ? AppColors.deepPurple
                                : Colors.black87,
                            fontWeight:
                                isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                        trailing: isSelected
                            ? const Icon(Icons.check, color: AppColors.deepPurple)
                            : null,
                        onTap: () {
                          Navigator.pop(context);
                          context.read<CategoryCubit>().selectCategory(cat);
                          context
                              .read<ProductCubit>()
                              .fetchProductsByCategory(cat);
                        },
                      );
                    }).toList(),
                  );
                },
              );
            },
            categories: categoryState.categories,
            selectedCategory: categoryState.selectedCategory,
            onCategorySelected: (value) {
              context.read<CategoryCubit>().selectCategory(value);
              // ignore: unnecessary_null_comparison
              if (value == null) {
                context.read<ProductCubit>().fetchAllProducts();
              } else {
                context.read<ProductCubit>().fetchProductsByCategory(value);
              }
            },
          );
        },
      ),
    ),

    body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          return RefreshIndicator(
            color: AppColors.deepPurple,
            onRefresh: () async {
              final selectedCategory =
                  context.read<CategoryCubit>().state.selectedCategory;
              if (selectedCategory == null) {
                await context.read<ProductCubit>().fetchAllProducts();
              } else {
                await context
                    .read<ProductCubit>()
                    .fetchProductsByCategory(selectedCategory);
              }
            },
            child: Builder(
              builder: (context) {
                if (state is ProductLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.deepPurple,
                      strokeWidth: 4,
                      strokeCap: StrokeCap.round,
                    ),
                  );
                } else if (state is ProductError) {
                  return Center(child: Text(state.message));
                } else if (state is ProductLoaded) {
                  return GridView.builder(
                    padding: const EdgeInsets.only(top: 12),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.65,
                    ),
                    itemCount: state.products.length,
                    itemBuilder: (context, index) {
                      final product = state.products[index];
final cartProductIds = context.watch<CartCubit>().state.items.map((e) => e.productId).toSet();
final cartItems = context.watch<CartCubit>().state.items;
final isInCart = cartItems.any((item) => item.productId == product.id);

 return ProductCard(
  imageUrl: product.image,
  title: product.title,
  description: product.description,
  price: product.price,
  isInCart: isInCart,
  onTap: () {
    Navigator.pushNamed(context, '/product-details', arguments: product.id);
  },
  onCartTap: () {
    final cart = context.read<CartCubit>();

    if (isInCart) {
      cart.removeCartItem(product.id);
      CustomizedSnackbar.show(
        context: context,
        label: "Removed",
        message: "Item removed from cart",
      );
    } else {
      cart.addToCart(product); 
      CustomizedSnackbar.show(
        context: context,
        label: "Added",
        message: "Item added to cart",
      );
    }
  },
);
                    });
                } else {
                  return const SizedBox();
                }
              },
            ),
          );
        },
      ),
    ),

    bottomNavigationBar: BlocBuilder<BottomNavCubit, int>(
      builder: (context, currentIndex) {
        return CustomBottomNavBar(
          currentIndex: currentIndex,
          onTap: (index) {
            if (index == 3) {
              // Navigate to Cart screen with user ID (replace with actual logged-in user ID)
              Navigator.pushNamed(context, '/cart', arguments: 1);
            } else {
              context.read<BottomNavCubit>().updateIndex(index);
            }
          },
        );
      },
    ),
  );
}
}