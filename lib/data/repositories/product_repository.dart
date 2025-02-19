import 'package:agri_connect/data/models/ProductModel.dart';
import 'package:agri_connect/data/services/api_service.dart';
import 'package:agri_connect/utils/global_contants.dart';
import 'package:get/get.dart';

import 'dart:convert';

class ProductRepository {
  final ApiService _apiService;
  ProductRepository({required ApiService apiService})
      : _apiService = apiService;

  Future<bool> CreateProduct(ProductModel product) async {
    try {
      final body = product.toMap();
      print(body.toString());
      final response = await _apiService
          .post("/products/create-shop-product", body, token: token);

      print("${response.body.toString()} , ${token}");
      print(response.statusCode);
      if (response.statusCode == 201) {
        Get.snackbar("Product Created", "Product created successfully...!");
        print("Product created successfully!");
        return true;
      } else {
        throw Exception("Product failed. Please check your fields.");
      }
    } catch (err) {
      print(err.toString());
      throw err;
    }
  }

  Future getMyProduct() async {
    try {
      final response =
          await _apiService.get("/products/get-mystoreproducts", token: token);
      print("response.body ${response.body}");

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        // print(responseData);

        return responseData['products'];
      }

      throw Exception("Product fetch failed. Please try again.");
    } catch (err) {
      print("Error fetching products: ${err.toString()}");
      throw err;
    }
  }

  Future getAllProduct() async {
    try {
      final response =
          await _apiService.get("/products/getallproducts", token: token);
      // print("response.body ${response.body}");

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        // print(responseData);

        return responseData['products'];
      }
    } catch (err) {
      print("err: ${err.toString()}");
      rethrow;
    }
  }

  Future getProductbyId(id) async {
    try {
      final response = await _apiService
          .get("/products/getproductdetails/${id}", token: token);
      // print("response.body ${response.body}");

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print("get details pof porduct ${responseData['product']}");

        return responseData['product'];
      }
    } catch (err) {
      print("err: ${err.toString()}");
      rethrow;
    }
  }

  Future<bool> UpdateProduct(ProductModel product, String prodcutId) async {
    try {
      final body = product.toMap();
      print(body.toString());
      final response = await _apiService
          .post("/products/updateproduct/${prodcutId}", body, token: token);

      print(response.body.toString());
      print(response.statusCode);
      if (response.statusCode == 200) {
        Get.snackbar(
            "Product update successfully", "Product update successfully...!");
        print("Product update successfully!");
        return true;
      } else {
        throw Exception("Product failed. Please check your fields.");
      }
    } catch (err) {
      print(err.toString());
      throw err;
    }
  }

  Future<bool> DeleteProduct(String prodcutId) async {
    try {
      final response = await _apiService
          .delete("/products/delete-products/${prodcutId}", token: token);
      print(response.body.toString());
      print(response.statusCode);
      if (response.statusCode == 200) {
        Get.snackbar(
            "Product deleted successfully", "Product deleted successfully...!");
        print("Product deleted successfully!");
        return true;
      } else {
        throw Exception("Product delete failed. Please check your fields.");
      }
    } catch (err) {
      print(err.toString());
      throw err;
    }
  }

  Future<bool> orderProduct(cart, paymentMethod, shippingAddress) async {
    try {
      print("cart $cart");
      print("paymentMethod $paymentMethod");
      var body = {
        "items": cart,
        "shippingAddress": {
          "street": shippingAddress['street']
              .toString(), // Assuming shippingAddress is a Map
          "city": shippingAddress['city'].toString(),
          "phone": shippingAddress['phone'].toString(),
        },
        "paymentMethod": paymentMethod.toString(),
      };
      print("body ${body.toString()}");
      var response =
          await _apiService.post("/order/createOrder", body, token: token);

      print(response.body.toString());
      print(token);
      print(response.statusCode);
      if (response.statusCode == 201) {
        Get.snackbar(
            "Order placed successfully", "Order placed successfully...!");

        print("Order placed successfully!");
        return true;
      } else if (response.statusCode == 403) {
        Get.snackbar("Token Expired", "Token expired login again");
        // Get.offAll(LoginPage());
        throw Exception("Token expried");
      } else {
        throw Exception("Order placed failed . Please check your fields.");
      }
    } catch (err) {
      print(err.toString());
      throw err;
    }
  }

  Future get_myAllOrders() async {
    try {
      var response = await _apiService.get("/order/getAllOrders");

      // print(token);
      print(response.statusCode);
      final orders = jsonDecode(response.body);
      print(orders);
      return orders['orders'];
    } catch (err) {
      print(err.toString());
      throw err;
    }
  }

  Future addReview(productId, text, rating) async {
    try {
      var body = {
        "productId": productId,
        "text": text,
        "rating": rating.toString()
      };
      print("body ${body.toString()}");
      var response =
          await _apiService.post("/review/create", body, token: token);

      print(response.body.toString());
      print(token);
      print(response.statusCode);
      if (response.statusCode == 201) {
        await Get.snackbar(
          "Review added successfully",
          "Review added successfully",
        );

        print("Reivew aAddED placed successfully!");
        return true;
      } else if (response.statusCode == 403) {
        Get.snackbar("Token Expired", "Token expired login again");
        // Get.offAll(LoginPage());
        throw Exception("Token expried");
      } else {
        throw Exception("Reivew add failed . Please check your fields.");
      }
    } catch (err) {
      print(err.toString());
      throw err;
    }
  }

  Future get_ReviewbyId(id) async {
    try {
      var response = await _apiService.get("/review/product/${id}");

      print("response ${response}");
      print(response.statusCode);
      final review = jsonDecode(response.body);
      print(review);
      return review;
    } catch (err) {
      print(err.toString());
      throw err;
    }
  }
}
