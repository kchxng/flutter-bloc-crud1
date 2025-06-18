import 'package:ticketbooking_app/modules/product/domain/entity/product.dart';

class ProductModel extends Product {
  // Constructor
  const ProductModel({
    required super.id,
    required super.name,
    required super.description,
    required super.price,
    required super.category,
    required super.stock,
    super.imageUrl,
    super.imagePath,
    required super.isActive,
  });

  // Factory
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] ?? 0.0).toDouble(),
      category: json['category'] ?? 'General',
      stock: json['stock']?['count'] ?? 0,
      imageUrl: json['image'],
      isActive: true,
    );
  }

  // toJson
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'category': category,
      'image': imageUrl,
      'stock': stock,
      'isActive': isActive,
    };
  }

  // CopyWith
  ProductModel copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    String? category,
    String? imageUrl,
    String? imagePath,
    int? stock,
    bool? isActive,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      category: category ?? this.category,
      imageUrl: imageUrl ?? this.imageUrl,
      imagePath: imageUrl ?? imagePath,
      stock: stock ?? this.stock,
      isActive: isActive ?? this.isActive,
    );
  }
}
