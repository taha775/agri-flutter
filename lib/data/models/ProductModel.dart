// product_model.dart

class ProductModel {
  final String name;
  final String description;
  final double price;
  final int stock;
  final String image;
  final String category;

  ProductModel({
    required this.name,
    required this.description,
    required this.price,
    required this.stock,
    required this.image,
    required this.category,
  });

  // Factory constructor for creating a ProductModel from a map
  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      price: (map['price'] is num ? (map['price'] as num).toDouble() : 0.0),
      stock: map['stock'] is int ? map['stock'] : 0,
      image: map['image'] ?? '',
      category: map['category'] ?? '',
    );
  }

  // Method to convert ProductModel to a map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'stock': stock,
      'image': image,
      'category': category,
    };
  }

  // Convert ProductModel to JSON string
  String toJson() {
    return '''
    {
      "name": "$name",
      "description": "$description",
      "price": $price,
      "stock": $stock,
      "image": "$image",
      "category": "$category"
    }
    ''';
  }

  @override
  String toString() {
    return 'ProductModel(name: $name, description: $description, price: $price, stock: $stock, image: $image, category: $category)';
  }
}
