// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, duplicate_import

import 'package:agri_connect/custom.dart';
import 'package:agri_connect/data/controllers/product_controller.dart';
import 'package:agri_connect/my_products.dart';
import 'package:agri_connect/product_cart_page.dart';
import 'package:agri_connect/product_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'provider/product_cart_provider.dart';
import 'calculator.dart';
import 'home_screen.dart';
import 'ownerProfile.dart';
import 'package:flutter/material.dart';

class AgricultureShopPage extends StatefulWidget {
  const AgricultureShopPage({Key? key}) : super(key: key);

  @override
  _AgricultureShopPageState createState() => _AgricultureShopPageState();
}

class _AgricultureShopPageState extends State<AgricultureShopPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Future<List<Map<String, dynamic>>> _productsFuture;
  bool _isLoading = true;
  String? _errorMessage;
  ProductController productController = Get.find<ProductController>();
  List<Map<String, dynamic>> allProducts = [];
  List<Map<String, dynamic>> filteredProducts = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    // Add listener to handle tab changes
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) return;
      // Call filter method based on selected tab index
      switch (_tabController.index) {
        case 0:
          _filterProductsByCategory("seed");
          break;
        case 1:
          _filterProductsByCategory("cropprotection");
          break;
      }
    });
    _fetchProducts();
    // Initial filter for the first tab
    _filterProductsByCategory("seed");
  }

  @override
  void dispose() {
    // Dispose of the TabController when the widget is destroyed
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _fetchProducts() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      var allProductsData = await productController.getAllProducts();

      print("allProducts: $allProductsData");

      // Map the response to the required format
      final List<Map<String, dynamic>> fetchedProducts =
          (allProductsData as List)
              .map((product) => {
                    'name': product['name'],
                    'price': product['price'],
                    'description': product['description'],
                    'image': product['image'],
                    'stock': product['stock'],
                    'id': product['_id'],
                    'category':
                        product['category'], // Assuming category is available
                  })
              .toList();

      setState(() {
        allProducts = fetchedProducts;
        filteredProducts = fetchedProducts; // Initially show all products
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Failed to fetch products. Please try again later.';
      });
    }
  }

  void _filterProductsByCategory(String category) {
    setState(() {
      if (category == 'seed') {
        filteredProducts = allProducts.where((product) {
          return product['category'] == 'seed';
        }).toList();
      } else if (category == 'cropprotection') {
        filteredProducts = allProducts.where((product) {
          return product['category'] == 'cropprotection';
        }).toList();
      } else {
        filteredProducts = allProducts;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'Shop',
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
        backgroundColor:
            CustomColor.greenTextColor, // Custom color for the AppBar
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: CustomColor
              .yellowTextColor, // Indicator color for the selected tab
          indicatorWeight: 4.0, // Thickness of the indicator
          labelColor: Colors.white, // Color for the active tab text
          unselectedLabelColor:
              Colors.white70, // Color for the inactive tab text
          labelStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold), // Active tab text style
          unselectedLabelStyle:
              TextStyle(fontSize: 14), // Inactive tab text style
          tabs: [
            Tab(
              text: 'Seeds',
              icon: Icon(FontAwesomeIcons.seedling), // Icon for Seeds tab
            ),
            Tab(
              text: 'Crop Protection',
              icon: Icon(Icons.shield), // Icon for Crop Protection tab
            ),
          ],
        ),
        actions: [
          const Icon(
            FontAwesomeIcons.magnifyingGlass,
            color: Colors.white,
          ),
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyProductsPage()));
              },
              icon: Icon(
                FontAwesomeIcons.stackOverflow,
                color: Colors.white,
              )),
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProductCartPage()));
              },
              icon: Icon(
                FontAwesomeIcons.cartPlus,
                color: Colors.white,
              )),
          PopupMenuButton(
            icon: Icon(
              Icons.more_vert_outlined,
              color: Colors.white,
            ),
            itemBuilder: (context) => [
              PopupMenuItem(value: 1, child: Text("ENGLISH")),
              PopupMenuItem(value: 2, child: Text("URDU")),
            ],
          ),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        key: GlobalKey(),
        index: 2,
        height: 60,
        color: CustomColor.greenTextColor,
        buttonBackgroundColor: CustomColor.greenTextColor,
        backgroundColor: Colors.white,
        items: const [
          Icon(
            Icons.home,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.calculate_outlined,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.qr_code_2_sharp,
            size: 40,
            color: Colors.white,
          ),
          Icon(
            Icons.add_card,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.perm_identity_outlined,
            size: 30,
            color: Colors.white,
          ),
        ],
        onTap: (index) {
          setState(() {});
          switch (index) {
            case 0:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const MyHomePage()));
              break;
            case 1:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Calculator()));
              break;
            case 2:
              break;
            case 3:
              break;
            case 4:
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const OwnerProfile()));
              break;
          }
        },
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _errorMessage!,
                        style: const TextStyle(color: Colors.red),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _fetchProducts,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : FutureBuilder<List<Map<String, dynamic>>>(
                  future: Future.value(filteredProducts),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          'Something went wrong: ${snapshot.error}',
                          style: const TextStyle(color: Colors.red),
                        ),
                      );
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text('No products available at the moment.'),
                      );
                    }

                    return ProductList(products: snapshot.data!);
                  },
                ),
    );
  }
}

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
          onTap: () {
            print("product ${product.toString()}");
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailPage(
                  product: Product(
                    name: product['name'] ?? "no name",
                    price: product['price'].toDouble() ?? "no name",
                    description: product['description'] ?? "no name",
                    image: product['image'] ?? "no name",
                    stock: product['stock'] ?? "no name",
                    id: product['id'] ?? "no name",
                  ),
                ),
              ),
            );
          },
          child: Card(
            margin: EdgeInsets.all(10),
            color: CustomColor.mintForestTextColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            shadowColor: CustomColor.silverTextColor,
            elevation: 5,
            child: Container(
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Consumer<ProductCartProvider>(
                              builder: (context, cartProvider, child) {
                                bool isInCart = cartProvider.items
                                    .any((item) => item.id == product['id']);

                                return ElevatedButton(
                                  onPressed: () {
                                    final productItem = Product(
                                      id: product['id'],
                                      name: product['name'],
                                      price: product['price'].toDouble(),
                                      description: product['description'],
                                      image: product['image'],
                                      stock: product['stock'],
                                    );

                                    if (isInCart) {
                                      cartProvider.remove(productItem);
                                    } else {
                                      cartProvider.add(productItem);
                                    }
                                  },
                                  child: Text(isInCart
                                      ? 'Remove from Cart'
                                      : 'Add to Cart'),
                                );
                              },
                            ),
                          ],
                        )
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
  final String id;

  Product({
    required this.name,
    required this.price,
    required this.description,
    required this.image,
    required this.stock,
    required this.id,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Product && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
