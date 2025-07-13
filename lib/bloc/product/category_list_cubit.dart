import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_app/services/product_services.dart';

class CategoryListCubit extends Cubit<List<String>> {
  final ProductService productService;

  CategoryListCubit(this.productService) : super([]);

  Future<void> fetchCategories() async {
    try {
      final categories = await productService.fetchCategories();
      emit(categories);
    } catch (e) {
      emit([]);
    }
  }
}
