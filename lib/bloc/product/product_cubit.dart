import 'package:ecommerce_app/services/product_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductService _productService;

  ProductCubit(this._productService) : super(ProductInitial());

  Future<void> fetchAllProducts() async {
    emit(ProductLoading());
    try {
      final products = await _productService.fetchAllProducts();
      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductError("Failed to load products."));
    }
  }

  Future<void> fetchByCategory(String category) async {
    emit(ProductLoading());
    try {
      final products = await _productService.fetchProductsByCategory(category);
      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductError("Failed to filter products."));
    }
  }
  Future<void> fetchProductsByCategory(String category) async {
    emit(ProductLoading());
    try {
      final products = await _productService.fetchProductsByCategory(category);
      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductError("Failed to filter products."));
    }
  }
  
}
