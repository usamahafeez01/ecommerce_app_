import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ecommerce_app/utlis/constants/api_constant.dart';

class CartService {
  final Dio _dio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));

  Future<Map<String, dynamic>> fetchUserCart(int userId) async {
    final response = await _dio.get('/carts/user/$userId');
  log("📦 API Status Code: ${response.statusCode}");
    log("📦 API Status Code: ${response.statusCode}");
("📦 API Response: ${response.data}");
    if (response.statusCode == 200 && (response.data as List).isNotEmpty) {
      return response.data.last; 
    } else {
      throw Exception("Cart not found or empty");
    }
  }

  Future<void> updateCartItemQuantity({
    required int cartId,
    required int productId,
    required int quantity,
  }) async {
    final response = await _dio.put('/carts/$cartId', data: {
      "products": [
        {
          "productId": productId,
          "quantity": quantity,
        }
      ]
    });

    if (response.statusCode != 200) {
      throw Exception("Failed to update item quantity");
    }
  }

  Future<void> removeCartItem({
    required int cartId,
    required List<Map<String, dynamic>> remainingProducts,
  }) async {
    final response = await _dio.put('/carts/$cartId', data: {
      "products": remainingProducts,
    });

    if (response.statusCode != 200) {
      throw Exception("Failed to remove item from cart");
    }
  }
}
