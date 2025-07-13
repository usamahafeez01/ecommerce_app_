import 'package:ecommerce_app/bloc/cart/cart_state.dart';
import 'package:ecommerce_app/models/cart_model.dart';
import 'package:ecommerce_app/models/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartState());

  /// Locally add item with full product model
  void addToCart(ProductModel product, {int quantity = 1}) {
    final exists = state.items.any((item) => item.productId == product.id);
    if (exists) return;

    final newItem = CartItem(
      productId: product.id,
      quantity: quantity,
      product: product,
    );

    final updatedItems = [...state.items, newItem];
    emit(state.copyWith(items: updatedItems));
  }

  /// Remove item from cart
  void removeCartItem(int productId) {
    final updatedItems = state.items.where((item) => item.productId != productId).toList();
    emit(state.copyWith(items: updatedItems));
  }

  /// Change quantity (optional - now hard limited to +1 only)
  void updateQuantity(int productId, int quantity) {
    final updatedItems = state.items.map((item) {
      if (item.productId == productId) {
        return item.copyWith(quantity: quantity);
      }
      return item;
    }).toList();

    emit(state.copyWith(items: updatedItems));
  }

  /// Clear all items (optional utility)
  void clearCart() {
    emit(state.copyWith(items: []));
  }
}