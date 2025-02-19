import 'package:agri_connect/custom.dart';
import 'package:agri_connect/data/controllers/product_controller.dart';
import 'package:agri_connect/product_cart_page.dart';
import 'package:agri_connect/shop_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'provider/product_cart_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;
  ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final TextEditingController _reviewController = TextEditingController();
  ProductController productController = Get.find<ProductController>();

  var _product; // Local state to hold product details

  @override
  void initState() {
    super.initState();
    // _product = widget.product; // Initialize with passed product
    _loadProductDetails();
  }

  Future<void> _loadProductDetails() async {
    // try {
    final detailedProduct =
        await productController.getProductByID(widget.product.id);
    setState(() {
      _product = detailedProduct;
    });
    // } catch (e) {
    //   print("Error loading product details: $e");
    //   Get.snackbar("Error", "Failed to load product details");
    // }
  }

  // List<Map<String, dynamic>> reviews = [
  //   {"review": "Great app!", "rating": 5},
  //   {"review": "Very useful for farmers.", "rating": 4},
  //   {"review": "Needs some improvements.", "rating": 3},
  // ];

  // Variable to store the rating
  int _rating = 0;

  // Function to open the review bottom sheet
  void _openReviewBottomSheet() {
    int localRating = 0; // Local state for the bottom sheet
    TextEditingController reviewController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                top: 16,
              ),
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Add a Review",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        return IconButton(
                          icon: Icon(
                            index < localRating
                                ? Icons.star
                                : Icons.star_border,
                            color: Colors.amber,
                            size: 40,
                          ),
                          onPressed: () {
                            setModalState(() {
                              localRating = index + 1;
                            });
                          },
                        );
                      }),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: reviewController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: "Write your review...",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () async {
                        if (reviewController.text.isNotEmpty &&
                            localRating > 0) {
                          Navigator.pop(context);
                          await productController.writeReview(
                            widget.product.id,
                            reviewController.text,
                            localRating.toString(),
                          );
                          // Refresh product details after review
                          await _loadProductDetails();
                        } else {
                          Get.snackbar("Error", "Please add rating and review");
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CustomColor.greenTextColor,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 12),
                      ),
                      child: const Text(
                        "Add Review",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  // Function to open the View review bottom sheet
  void showViewReviewBottomSheet(BuildContext context, reviews) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16),
          height: 400,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Reviews & Ratings",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: reviews.length,
                  itemBuilder: (context, index) {
                    var review=  reviews[index];
                    return Container(
                      margin: EdgeInsets.only(bottom: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.black12,
                      ),
                      child: ListTile(
                        leading: Icon(Icons.star, color: Colors.amber),
                        title: Text(review["text"]),
                        subtitle: Text("Rating: ${review["rating"]}/5"),
                      ),
                    );
                  },
                ),
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _openReviewBottomSheet,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CustomColor.greenTextColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 12),
                  ),
                  child: const Text(
                    "Add Review",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ProductCartProvider cartProvider =
        Provider.of<ProductCartProvider>(context);
    print(_product);
    print(_product['reviews'].length);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColor.greenTextColor,
        title: Text(
          widget.product.name,
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProductCartPage()),
              );
            },
            icon: const Icon(
              FontAwesomeIcons.cartPlus,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 10),
          IconButton(
            icon: const Icon(Icons.reviews, color: Colors.white),
            onPressed: _openReviewBottomSheet,
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image
                Card(
                  shadowColor: Colors.black26,
                  elevation: 8,
                  child: Container(
                    height: 250,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white70,
                    ),
                    child:
                        Image.network(widget.product.image, fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(height: 16),

                // Product Details
                Text(
                  "Rs. ${widget.product.price}",
                  style: TextStyle(
                    fontSize: 24,
                    color: CustomColor.greenTextColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Ratings & Reviews " +
                          "(${_product['reviews'].length.toString()})",
                      style:
                          const TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                    InkWell(
                      onTap: () {
                        showViewReviewBottomSheet(context,
                            _product['reviews']); // not working this line
                      },
                      child: Row(
                        children: [
                          //  Text("4.5"),
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          Text(">")
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Description
                const Text(
                  "Description:",
                  style: TextStyle(fontSize: 20, color: Colors.black54),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.product.description ?? "No description available.",
                  style: const TextStyle(fontSize: 16, color: Colors.black87),
                ),
                const SizedBox(height: 20),

                // Price Breakdown
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey, width: 1),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Delivery Charges:",
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                          Text(
                            "Rs.199",
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ],
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Total:",
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                          Text(
                            "Rs. ${widget.product.price + 199}",
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black87),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Add/Remove from Cart Button
                InkWell(
                  onTap: () {
                    if (cartProvider.items.contains(widget.product)) {
                      cartProvider.remove(widget.product);
                    } else {
                      cartProvider.add(widget.product);
                    }
                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: CustomColor.greenTextColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        cartProvider.items.contains(widget.product)
                            ? 'Remove from Cart'
                            : 'Add to Cart',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // ElevatedButton(
                //   onPressed: _openReviewBottomSheet,
                //   style: ElevatedButton.styleFrom(
                //     backgroundColor: CustomColor.greenTextColor,
                //     padding: const EdgeInsets.symmetric(
                //         horizontal: 40, vertical: 12),
                //   ),
                //   child: const Text(
                //     "Add Review",
                //     style: TextStyle(fontSize: 18, color: Colors.white),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
