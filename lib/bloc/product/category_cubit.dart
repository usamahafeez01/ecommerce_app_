import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_app/services/product_services.dart';

class CategoryState {
  final List<String> categories;
  final String? selectedCategory;

  CategoryState({required this.categories, this.selectedCategory});

  CategoryState copyWith({
    List<String>? categories,
    String? selectedCategory,
  }) {
    return CategoryState(
      categories: categories ?? this.categories,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }
}

class CategoryCubit extends Cubit<CategoryState> {
  final ProductService productService;

  CategoryCubit(this.productService)
      : super(CategoryState(categories: [], selectedCategory: null));

  Future<void> fetchCategories() async {
    try {
      final categories = await productService.fetchCategories();
      emit(state.copyWith(categories: categories));
    } catch (e) {
      emit(state.copyWith(categories: [])); // or handle error appropriately
    }
  }

  void selectCategory(String? category) {
    emit(state.copyWith(selectedCategory: category));
  }
}
