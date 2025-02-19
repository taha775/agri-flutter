import 'package:agri_connect/data/controllers/product_controller.dart';
import 'package:agri_connect/custom.dart';
import 'package:agri_connect/provider/product_cart_provider.dart';
import 'package:agri_connect/shop_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';


class ProductCartPage extends StatefulWidget {
  const ProductCartPage({super.key});

  @override
  State<ProductCartPage> createState() => _ProductCartPageState();
}

class _ProductCartPageState extends State<ProductCartPage> {
  final _formKey = GlobalKey<FormState>();
  String _street = '';
  String _city = '';
  String _phone = '';
  String _paymentMethod = 'card'; // 'card' or 'cash'

  @override
  Widget build(BuildContext context) {
    ProductCartProvider cartProvider =
        Provider.of<ProductCartProvider>(context);

    return Consumer<ProductCartProvider>(builder: (context, provider, _) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: CustomColor.greenTextColor,
          title: const Text(
            'Agri-Cart',
            style: TextStyle(color: Colors.white, fontSize: 22),
          ),
        ),
        body: provider.items.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_cart_outlined,
                      size: 100,
                      color: CustomColor.greenTextColor,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Your cart is empty!',
                      style: TextStyle(fontSize: 20, color: Colors.black54),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        Get.to(AgricultureShopPage());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CustomColor.greenTextColor1,
                      ),
                      child: const Text(
                        'Shop Now',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      itemCount: provider.items.length,
                      itemBuilder: (context, index) {
                        var product = provider.items[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
                          color: CustomColor.mintForestTextColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 5,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Image.network(
                                  product.image,
                                  width: 60,
                                  height: 60,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Icon(Icons.broken_image, size: 60),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        product.name,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: CustomColor.greenTextColor,
                                        ),
                                      ),
                                      Text(
                                        'weight fhtjgdfkl',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: CustomColor.ashgrey,
                                        ),
                                      ),
                                      Text(
                                        'RS: ${product.price}',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.remove),
                                      onPressed: () {
                                        cartProvider.remove(product);
                                      },
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: CustomColor.greenTextColor,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        '${cartProvider.getQuantity(product)}',
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.add),
                                      onPressed: () {
                                        cartProvider.add(product);
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                      color: CustomColor.greenTextColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 6,
                          offset: const Offset(0, -2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total: RS ${provider.getCartTotal()}",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            _openBottomSheet(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: CustomColor.greenTextColor1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          icon: const Icon(Icons.arrow_forward,
                              color: Colors.white),
                          label: const Text(
                            'BUY',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      );
    });
  }

  // Method to open bottom sheet
  void _openBottomSheet(BuildContext context) {
    ProductController productController = Get.find<ProductController>();
    // Update this line
    ProductCartProvider cartProvider =
        Provider.of<ProductCartProvider>(context, listen: false);

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Enter your details',
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Street'),
                    onChanged: (value) => _street = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Street is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'City'),
                    onChanged: (value) => _city = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'City is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Phone'),
                    keyboardType: TextInputType.phone,
                    onChanged: (value) => _phone = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Phone number is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  Text('Payment Method'),
                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile<String>(
                          title: const Text('Card'),
                          value: 'card',
                          groupValue: _paymentMethod,
                          onChanged: (value) {
                            setState(() {
                              _paymentMethod = value!;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<String>(
                          title: const Text('Cash on Delivery'),
                          value: 'cash',
                          groupValue: _paymentMethod,
                          onChanged: (value) {
                            setState(() {
                              _paymentMethod = value!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        // Process the order here
                        print("Street: $_street");
                        print("City: $_city");
                        print("Phone: $_phone");
                        print("Payment Method: $_paymentMethod");

                        // Close the bottom sheet
                        Navigator.pop(context);

                        var shippingAddress = {
                          "street": _street,
                          "city": _city,
                          "phone": _phone
                        };
                        await productController.orderNow(cartProvider.orderObj,
                            _paymentMethod, shippingAddress);
                        cartProvider.removeAll();
                      }
                    },
                    child: Container(
                      height: 50,
                      width: 300,
                      decoration: BoxDecoration(
                        color: CustomColor.greenTextColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: const Text(
                          "Submit Order",
                          style: TextStyle(
                            fontFamily: "Rubik Regular",
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: CustomColor.mintForestTextColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
