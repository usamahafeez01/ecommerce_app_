class ProductModel {
  final int id;
  final String title;
  final String description;
  final double price;
  final String image;
  final String category;

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.image,
    required this.category,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      image: json['image'],
      category: json['category'],
    );
  }
   Map<String, dynamic> toJson() => {
        'id'        : id,
        'title'     : title,
        'description': description,
        'price'     : price,
        'image'     : image,
        'category'  : category,
      };

  /// 🔹  Optional but convenient for immutable updates
  ProductModel copyWith({
    int? id,
    String? title,
    String? description,
    double? price,
    String? image,
    String? category,
  }) {
    return ProductModel(
      id         : id         ?? this.id,
      title      : title      ?? this.title,
      description: description ?? this.description,
      price      : price      ?? this.price,
      image      : image      ?? this.image,
      category   : category   ?? this.category,
    );
  }
}
