class ProductCardModel {
  final String name;
  final double price;
  final String description;
  final String image;
  final int stock;

  ProductCardModel({
    required this.name,
    required this.price,
    required this.description,
    required this.image,
    required this.stock,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductCardModel &&
        other.name == name &&
        other.price == price &&
        other.description == description &&
        other.image == image &&
        other.stock == stock;
  }

  @override
  int get hashCode {
    return name.hashCode ^
    price.hashCode ^
    description.hashCode ^
    image.hashCode ^
    stock.hashCode;
  }
}