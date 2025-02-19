import 'package:agri_connect/data/controllers/farmer_controller.dart';
import 'package:agri_connect/farmer_home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'custom.dart';

class CreateFarmerProfile extends StatefulWidget {
  const CreateFarmerProfile({super.key});

  @override
  State<CreateFarmerProfile> createState() => _CreateFarmerProfileState();
}

class _CreateFarmerProfileState extends State<CreateFarmerProfile> {
  FarmerController farmerController = Get.find<FarmerController>();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _pricePerDayController = TextEditingController();
  final TextEditingController _pricePerMonthController =
      TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  String? _selectedProvince;
  String? _selectedCity;

  final List<String> provinces = ["Sindh", "Punjab", "Balochistan", "KPK"];
  final List<String> cities = ["Mirpurkhas,", "Hyderabad", "Dadu", "Jamshoro"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Create Farmer Profile',
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
          backgroundColor: CustomColor.greenTextColor,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Handle profile picture tap
                    },
                    child: Icon(
                      Icons.image,
                      size: 80,
                      color: CustomColor.mutedSageTextColor,
                    ),
                  ),
                  SizedBox(height: 16),
                  _buildTextFormField(
                    controller: _fullNameController,
                    labelText: 'Full Name',
                    prefixIcon: Icons.person,
                    keyboardType: TextInputType.text,
                  ),
                  _buildTextFormField(
                    controller: _descriptionController,
                    labelText: 'Description',
                    prefixIcon: Icons.description,
                    keyboardType: TextInputType.text,
                  ),
                  _buildTextFormField(
                    controller: _phoneNumberController,
                    labelText: 'Phone Number',
                    prefixIcon: Icons.phone,
                    keyboardType: TextInputType.phone,
                  ),
                  _buildTextFormField(
                    controller: _pricePerDayController,
                    labelText: 'Price/day',
                    prefixIcon: Icons.monetization_on,
                    keyboardType: TextInputType.number,
                  ),
                  _buildTextFormField(
                    controller: _pricePerMonthController,
                    labelText: 'Price/month',
                    prefixIcon: Icons.monetization_on,
                    keyboardType: TextInputType.number,
                  ),
                  _buildDropdownFormField(
                    labelText: 'Province',
                    items: provinces,
                    value: _selectedProvince,
                    onChanged: (value) {
                      setState(() {
                        _selectedProvince = value;
                      });
                    },
                  ),
                  _buildDropdownFormField(
                    labelText: 'City',
                    items: cities,
                    value: _selectedCity,
                    onChanged: (value) {
                      setState(() {
                        _selectedCity = value;
                      });
                    },
                  ),
                  _buildTextFormField(
                    controller: _addressController,
                    labelText: 'Address',
                    hintText: "Enter Current Location",
                    prefixIcon: Icons.home,
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CustomColor.greenTextColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(11),
                        side: BorderSide(
                          color: CustomColor.greenTextColor1,
                          width: 2,
                        ),
                      ),
                      elevation: 5,
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        // Perform save action
                        print('Full Name: ${_fullNameController.text}');
                        print('Description: ${_descriptionController.text}');
                        print('Phone: ${_phoneNumberController.text}');
                        print('Price/day: ${_pricePerDayController.text}');
                        print('Price/month: ${_pricePerMonthController.text}');
                        print('Province: $_selectedProvince');
                        print('City: $_selectedCity');
                        print('Address: ${_addressController.text}');
                        var farmer = {
                          "profileImage":
                              "https://example.com/profile-image.jpg",
                          "description": _descriptionController.text,
                          "pricePerDay": _pricePerDayController.text,
                          "pricePerMonth": _pricePerMonthController.text,
                          "contactDetails": {
                            "phone": _phoneNumberController.text,
                            "address": _addressController.text
                          },
                          "availability": true
                        };
                        await farmerController.completeFarmerProfile(farmer);
                        Get.to(FarmerHomePage());
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          "Save Detail",
                          style: TextStyle(
                            fontSize: 16,
                            color: CustomColor.greenTextColor1,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 18),
                ],
              ),
            ),
          ),
        ));
  }
}

Widget _buildTextFormField({
  required TextEditingController controller,
  required String labelText,
  IconData? prefixIcon,
  String? hintText,
  TextInputType keyboardType = TextInputType.text,
}) {
  return Column(
    children: [
      TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          border: OutlineInputBorder(),
          prefixIcon: prefixIcon != null
              ? Icon(prefixIcon, color: CustomColor.greenTextColor)
              : null,
        ),
        keyboardType: keyboardType,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $labelText';
          }
          return null;
        },
      ),
      SizedBox(height: 10),
    ],
  );
}

Widget _buildDropdownFormField({
  required String labelText,
  required List<String> items,
  required String? value,
  required ValueChanged<String?> onChanged,
}) {
  return Column(
    children: [
      DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(),
        ),
        value: value,
        items: items.map((String item) {
          return DropdownMenuItem(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
        validator: (value) => value == null ? 'Please select $labelText' : null,
      ),
      SizedBox(height: 10),
    ],
  );
}
