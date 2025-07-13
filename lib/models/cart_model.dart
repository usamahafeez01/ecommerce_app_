// lib/models/cart_item.dart  (or wherever you keep it)
import 'package:ecommerce_app/models/product_model.dart';

class CartItem {
  final int productId;
  final int quantity;
  final ProductModel? product;

  CartItem({
    required this.productId,
    required this.quantity,
    this.product,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      productId: json['productId'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'quantity': quantity,
    };
  }

  CartItem copyWith({
    int? productId,
    int? quantity,
    ProductModel? product,
  }) {
    return CartItem(
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      product: product ?? this.product,
    );
  }
}
