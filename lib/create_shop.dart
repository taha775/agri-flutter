// ignore_for_file: avoid_print

import 'package:agri_connect/data/controllers/shop_controller.dart';
import 'package:agri_connect/custom.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class CreateShop extends StatefulWidget {
  const CreateShop({super.key});

  @override
  State<CreateShop> createState() => _CreateShopState();
}

class _CreateShopState extends State<CreateShop> {
  bool isLoading = false;
  final ShopController _shopController = Get.find<ShopController>();

  // Controllers for login fields
  final TextEditingController shopIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Controllers for bottom sheet fields
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController bottomSheetShopIdController =
      TextEditingController();
  final TextEditingController bottomSheetPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: CustomColor.greenTextColor,
          title: Text(
            "My Agriculture Shop",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 80),
              Center(
                  child: Icon(
                FontAwesomeIcons.shop,
                size: 100,
                color: CustomColor.greenTextColor,
              )),
              SizedBox(height: 10),
              Text(
                "Login as Shop Keeper",
                style:
                    TextStyle(fontSize: 20, color: CustomColor.greenTextColor),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: shopIdController,
                  decoration: InputDecoration(
                    hintText: 'Shop_id',
                    fillColor: const Color(0xffF8F9FA),
                    filled: true,
                    prefixIcon: const Icon(Icons.email_outlined,
                        color: CustomColor.greenTextColor),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xffE4E7EB)),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xffE4E7EB)),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    fillColor: const Color(0xffF8F9FA),
                    filled: true,
                    prefixIcon: const Icon(Icons.lock_outline,
                        color: CustomColor.greenTextColor),
                    suffixIcon: const Icon(Icons.visibility_off_outlined),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xffE4E7EB)),
                      borderRadius: BorderRadius.circular(11),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xffE4E7EB)),
                      borderRadius: BorderRadius.circular(11),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 70),
              GestureDetector(
                onTap: () async {
                  // print("Shop ID: ${shopIdController.text}");
                  // print("Password: ${passwordController.text}");
                  await _shopController.loginShop(
                    shopIdController.text,
                    passwordController.text,
                  );

                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => AddProduct()));
                },
                child: Container(
                  height: 50,
                  width: 300,
                  decoration: BoxDecoration(
                    color: CustomColor.greenTextColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: isLoading
                        ? const SpinKitWave(
                            color: CustomColor.yellowTextColor,
                            size: 24,
                          )
                        : const Text(
                            "Login",
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
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have a Shop?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xff203142),
                      fontFamily: "Rubik Regular",
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showSignUpBottomSheet(context);
                    },
                    child: const Text(
                      " Create Shop ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: "Rubik Medium",
                        color: CustomColor.greenTextColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
    );
  }

  void showSignUpBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            top: 16.0,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  // Profile picture action
                },
                child: CircleAvatar(
                  radius: 55,
                  child: Icon(
                    Icons.camera_alt,
                    size: 42,
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: fullNameController,
                decoration: InputDecoration(labelText: 'Full Name'),
              ),
              TextFormField(
                controller: bottomSheetShopIdController,
                decoration: InputDecoration(labelText: 'Shop Id'),
              ),
              TextFormField(
                controller: bottomSheetPasswordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () async {
                  print("Full Name: ${fullNameController.text}");
                  print("Shop ID: ${bottomSheetShopIdController.text}");
                  print("Password: ${bottomSheetPasswordController.text}");

                  await _shopController.ShopCreate(
                      fullNameController.text,
                      bottomSheetShopIdController.text,
                      bottomSheetPasswordController.text);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: CustomColor.greenTextColor,
                    borderRadius: BorderRadius.circular(11),
                    border: Border.all(
                        color: CustomColor.greenTextColor1, width: 2),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Create Shop",
                      style: TextStyle(
                          fontSize: 16, color: CustomColor.greenTextColor1),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
