import 'package:agri_connect/custom.dart';
import 'package:agri_connect/provider/product_cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductList extends StatelessWidget {
  final List<Map<String, dynamic>> products;

  const ProductList({required this.products});

  @override
  Widget build(BuildContext context) {
    ProductCartProvider cartProvider =
        Provider.of<ProductCartProvider>(context);
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return InkWell(
          onTap: () {},
          child: Card(
            margin: EdgeInsets.all(10),
            color: CustomColor.mintForestTextColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            shadowColor: CustomColor.silverTextColor,
            elevation: 5,
            child: Container(
              height: 160,
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Image.network(
                    product['image'],
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        Icon(Icons.broken_image, size: 120),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          product['name'],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: CustomColor.greenTextColor,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Price: RS ${product['price']}',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Stock: ${product['stock']}',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Rating: ${product['averageRating']} (${product['totalReviews']} reviews)',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                final currentProduct = Product(
                                  name: product['name'],
                                  price: product['price'].toDouble(),
                                  description: product['description'],
                                  image: product['image'],
                                  stock: product['stock'],
                                );
                                // if (cartProvider.items
                                //     .contains(currentProduct)) {
                                //   cartProvider.remove(currentProducct);
                                // } else {
                                //   cartProvider.add(currentProduct);
                                // }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: CustomColor.greenTextColor,
                              ),
                              child: Text(
                                cartProvider.items.contains(Product(
                                        name: product['name'],
                                        price: product['price'].toDouble(),
                                        description: product['description'],
                                        image: product['image'],
                                        stock: product['stock']))
                                    ? 'Remove from Cart'
                                    : 'Add to Cart',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class Product {
  final String name;
  final double price;
  final String description;
  final String image;
  final int stock;

  Product({
    required this.name,
    required this.price,
    required this.description,
    required this.image,
    required this.stock,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
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
