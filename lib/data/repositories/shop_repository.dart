import 'package:agri_connect/add_product.dart';
import 'package:agri_connect/data/services/api_service.dart';
import 'package:agri_connect/utils/global_contants.dart';
import 'package:get/get.dart';

class ShopRepository {
  final ApiService _apiService;
  ShopRepository({required ApiService apiService}) : _apiService = apiService;

  Future<bool> createShop(String name, shopCode, password) async {
    try {
      // final body = shop.toJson();
      // print("$name, $shopCode, $password, $token");
      // Make the API request
      final response = await _apiService.post(
          "/user/create-shop",
          {
            "name": name,
            "shop_code": shopCode,
            "password": password,
            "email": email
          },
          token: token);
// print("response ${response.body.toString()}");
      // Handle the response
      if (response.statusCode == 200) {
        Get.snackbar("Shop Created", "Shop created successfully...!");
        print("Shop created successfully!");
        return true;
      } else if (response.statusCode == 400) {
        Get.snackbar("ERROR", "Shop already exsists...!");
        return false;
      } else {
        throw Exception("Shop failed. Please check your credentials.");
      }
    } catch (err) {
      print("Error: $err");
      rethrow;
    }
  }

  Future<bool> shopLogin(shopCode, password) async {
      token = await prefs?.getString("token");
  try {
      final body = {
        "shop_code": shopCode,
        "password": password.toString(),
      };
      print("$body, $token");
      print(body);
      final response = await _apiService.post(
          "/user/login-shop",
          {
            "shop_code": shopCode,
            "password": password,
          },
          token: token);
      print("response ${response.body.toString()}");
      if (response.statusCode == 200) {
        Get.snackbar("Shop Login", "Shop login successfully...!");
        Get.off(AddProduct());
        print("Shop loggedin successfully!");
        return true;
      } else {
        throw Exception("Shop login failed. Please check your credentials.");
      }
    } catch (err) {
      print("Error: ${err.toString()}");
      Get.snackbar("Error", err.toString());

      rethrow;
    }
  }
}
