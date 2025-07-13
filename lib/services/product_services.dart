import 'package:dio/dio.dart';
import 'package:ecommerce_app/models/cart_model.dart';
import 'package:ecommerce_app/utlis/constants/api_constant.dart';
import '../models/product_model.dart';

class ProductService {
  final Dio _dio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));

  Future<List<ProductModel>> fetchAllProducts() async {
    final response = await _dio.get('/products');
    return (response.data as List)
        .map((item) => ProductModel.fromJson(item))
        .toList();
  }

  Future<List<ProductModel>> fetchProductsByCategory(String category) async {
    final response = await _dio.get('/products/category/$category');
    return (response.data as List)
        .map((item) => ProductModel.fromJson(item))
        .toList();
  }
Future<ProductModel> fetchProductById(int id) async {
  final response = await _dio.get('/products/$id');
  return ProductModel.fromJson(response.data);
}


  Future<List<String>> fetchCategories() async {
    final response = await _dio.get('/products/categories');
    return (response.data as List).map((e) => e.toString()).toList();
  }
 Future<List<CartItem>> fetchUserCart(int userId) async {
  final response = await _dio.get('/carts/user/$userId');
  final carts = response.data as List;

  if (carts.isEmpty) {
    throw Exception('No cart found');
  }

  final latestCart = carts.last;
  final products = latestCart['products'] as List;

  List<CartItem> cartItems = [];

  for (var item in products) {
    final productId = item['productId'];
    final quantity = item['quantity'];

    final productResponse = await _dio.get('/products/$productId');
    final product = ProductModel.fromJson(productResponse.data);

    cartItems.add(CartItem(
      productId: productId,
      quantity: quantity,
      product: product,
    ));
  }

  return cartItems;
}

  // Optional future methods
  Future<void> removeCartItem(int cartId, int productId) async {
    // API does not support actual remove, but you can simulate for UI
  }

  Future<void> updateQuantity(int cartId, int productId, int newQuantity) async {
    // FakeStore API does not support updates; you’d simulate this
  }
}
