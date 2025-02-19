import 'package:agri_connect/data/repositories/shop_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShopController extends GetxController {
  final ShopRepository shopRepository;
  ShopController({required this.shopRepository});

  var isLoading = false.obs;

  Future ShopCreate(name, shopCode, password) async {
    isLoading.value = true;
    try {
      bool success = await shopRepository.createShop(name, shopCode, password);
      print(success);
    } catch (err) {
      print(err.toString());
      Get.snackbar('Error', err.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future loginShop(shopCode, password) async {
    try {
      if (shopCode.isEmpty || password.isEmpty) {
        Get.snackbar("Error", "Shop code and Password cannot be empty!",
            backgroundColor: Colors.red, colorText: Colors.white);
        return;
      }
      final result = await shopRepository.shopLogin(
          shopCode, password); // Pass the body directly if needed
      print("result: $result");
    } catch (err) {
      print("Error: $err");
    }
  }
}
