import 'package:agri_connect/custom.dart';
import 'package:agri_connect/data/controllers/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyProductsPage extends StatelessWidget {
  final ProductController productController = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    // Fetch orders when the page is built
    productController.getAllOrders();

    return Scaffold(
      backgroundColor: CustomColor.mutedSageTextColor1,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: CustomColor.greenTextColor,
        title: Obx(() {
          return Text(
            "My All Orders (${productController.orders.length})",
            style: TextStyle(color: Colors.white),
          );
        }),
      ),
      body: Obx(() {
        if (productController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (productController.orders.isEmpty) {
          return const Center(child: Text("No orders found."));
        }

        return ListView.builder(
          itemCount: productController.orders.length,
          itemBuilder: (context, index) {
            final order = productController.orders[index];
            final shippingAddress = order['shippingAddress'];
            final cartItems = order['cartItems'];
            final paymentMethod = order['paymentMethod'];
            final isPaid = order['isPaid'];
            final isDelivered = order['isDelivered'];

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: CustomColor.mutedSageTextColor,
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Order ID and Payment Details
                      Text(
                        "Order ID: ${order['_id']}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text("Payment Method: $paymentMethod"),
                      Text("Paid: ${isPaid ? 'Yes' : 'No'}"),
                      Text("Delivered: ${isDelivered ? 'Yes' : 'No'}"),
                      const SizedBox(height: 10),

                      // Shipping Address
                      Text(
                        "Shipping Address:",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      Text("Street: ${shippingAddress['street']}"),
                      Text("City: ${shippingAddress['city']}"),
                      Text("Phone: ${shippingAddress['phone']}"),
                      const SizedBox(height: 10),

                      // Cart Items
                      Text(
                        "Items:",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      ...cartItems.map<Widget>((item) {
                        final product = item['productId'];
                        return ListTile(
                          contentPadding: const EdgeInsets.all(0),
                          leading: CircleAvatar(
                            backgroundColor: Colors.grey[300],
                            child: const Icon(Icons.shopping_cart),
                          ),
                          title: Text(product['name']),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Price: \$${product['price']}"),
                              Text("Quantity: ${item['quantity']}"),
                              Text("Total: \$${item['price']}"),
                            ],
                          ),
                        );
                      }).toList(),

                      // Cancel Order Button
                      const SizedBox(height: 10),
                      // ElevatedButton(
                      //   onPressed: () {
                      //     print("Cancel Order for ID: ${order['_id']}");
                      //   },
                      //   child: const Text("Cancel Order"),
                      //   style: ElevatedButton.styleFrom(
                      //     backgroundColor: CustomColor.mutedSageTextColor1,
                      //     foregroundColor: CustomColor.greenTextColor,
                      //     padding: const EdgeInsets.symmetric(
                      //       horizontal: 20,
                      //       vertical: 10,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
