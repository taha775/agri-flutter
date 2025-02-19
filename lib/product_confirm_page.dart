import 'package:agri_connect/custom.dart';
import 'package:agri_connect/provider/product_cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductConfirmPage extends StatefulWidget {
  @override
  _ProductConfirmPage createState() => _ProductConfirmPage();
}

class _ProductConfirmPage extends State<ProductConfirmPage> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedProvince;
  String? _selectedCity;
  bool cashOnDelivery = false;

  final List<String> provinces = ['Sindh', 'Punjab', 'Balochistan'];
  final List<String> cities = ['Karachi', 'Hyderabad', 'Jamshoro'];

  @override
  Widget build(BuildContext context) {
    // ProductCartProvider cartProvider =
    //     Provider.of<ProductCartProvider>(context);
    return Consumer<ProductCartProvider>(builder: (context, provider, _) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Confirm Product',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.green,
        ),
        body: Padding(
          padding:
              const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 16),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child: Text(
                    "Add Shipping Address",
                    style: TextStyle(color: Colors.grey),
                  )),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Full Name',
                      border: OutlineInputBorder(),
                      prefixIcon:
                          Icon(Icons.person, color: CustomColor.greenTextColor),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your full name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(),
                      prefixIcon:
                          Icon(Icons.phone, color: CustomColor.greenTextColor),
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Province',
                      border: OutlineInputBorder(),
                    ),
                    value: _selectedProvince,
                    items: provinces.map((String province) {
                      return DropdownMenuItem(
                        value: province,
                        child: Text(province),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedProvince = value;
                      });
                    },
                    validator: (value) =>
                        value == null ? 'Please select a province' : null,
                  ),
                  SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'City',
                      border: OutlineInputBorder(),
                    ),
                    value: _selectedCity,
                    items: cities.map((String city) {
                      return DropdownMenuItem(
                        value: city,
                        child: Text(city),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCity = value;
                      });
                    },
                    validator: (value) =>
                        value == null ? 'Please select a city' : null,
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Address',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(
                        Icons.home,
                        color: CustomColor.greenTextColor,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your address';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: cashOnDelivery,
                        onChanged: (bool? value) {
                          setState(() {
                            cashOnDelivery = value!;
                          });
                        },
                      ),
                      Text('Cash on Delivery'),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12, top: 60),
                    child: Text(
                      '15 days easy return',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Text(
                      'Total Price: Rs. ${provider.getCartTotal()}',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 24),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Processing Data')),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Confirm Order',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
