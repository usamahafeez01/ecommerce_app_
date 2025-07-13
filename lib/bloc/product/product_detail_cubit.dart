import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_app/models/product_model.dart';
import 'package:ecommerce_app/services/product_services.dart';

abstract class ProductDetailsState {}
class ProductDetailsInitial extends ProductDetailsState {}
class ProductDetailsLoading extends ProductDetailsState {}
class ProductDetailsLoaded extends ProductDetailsState {
  final ProductModel product;
  ProductDetailsLoaded(this.product);
}
class ProductDetailsError extends ProductDetailsState {
  final String message;
  ProductDetailsError(this.message);
}

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final ProductService productService;

  ProductDetailsCubit(this.productService) : super(ProductDetailsInitial());

  Future<void> fetchProduct(int id) async {
    emit(ProductDetailsLoading());
    try {
      final product = await productService.fetchProductById(id);
      emit(ProductDetailsLoaded(product));
    } catch (_) {
      emit(ProductDetailsError("Failed to load product details."));
    }
  }
}
