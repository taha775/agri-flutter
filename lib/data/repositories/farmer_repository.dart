import 'dart:convert';

import 'package:agri_connect/data/services/api_service.dart';
import 'package:agri_connect/utils/global_contants.dart';
import 'package:get/get.dart';

class FarmerRepository {
  final ApiService _apiService;

  FarmerRepository({required ApiService apiService}) : _apiService = apiService;

  Future<bool> CompleteFarmerProfile(farmer) async {
    try {
      print(farmer);
      final body = farmer;
      print(body.toString());
      final response = await _apiService
          .post("/farmer/createOrUpdateProfile", body, token: token);

      print(response.body.toString());
      print(response.statusCode);
      if (response.statusCode == 200) {
        Get.snackbar(
            "Farmer profile updated", "Farmer profile updated successfully...!");
        print("Farmer profile successfully!");
        return true;
      } else {
        throw Exception("Farmer failed. Please check your fields.");
      }
    } catch (err) {
      print(err.toString());
      throw err;
    }
  }

  Future getFarmer() async {
    try {
      final response =
          await _apiService.get("/farmer/getAllProfiles", token: token);

      // print(response.body.toString());
      print(response.statusCode);
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print("responseData['profiles']: ${responseData['profiles']}");

        return responseData['profiles'];
      }
    } catch (err) {
      print(err.toString());
      throw err;
    }
  }

  Future getFarmerDetail(id) async {
    try {
      final response =
          await _apiService.get("/farmer/getProfile/677d3a09627bf6665ae1c901", token: token);
          // await _apiService.get("/farmer/getProfile/${id}", token: token);
      print("token: ${token}");
      print(response.statusCode);
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print("farmer single ['profile']: ${responseData['profile']}");

        return responseData['profile'];
      }
    } catch (err) {
      print(err.toString());
      throw err;
    }
  }

  Future hire_Farmer(id) async {
    try {
      final response =
          await _apiService.post("/user/hireFarmer/$id", {}, token: token);

      print(response.body.toString());
      print(response.statusCode);
      if (response.statusCode == 200) {
        Get.snackbar(
            "Success", "Farmer hired  successfully...!");
      //   print("Farmer profile  successfully!");
      //   return true;
      } else {
        throw Exception("Farmer failed. Please check your fields.");
      }
    } catch (err) {
      print(err.toString());
      rethrow;
    }
  }

  Future get_hireFarmer() async {
    try {
      final response = await _apiService.get("/user/gethiredfarmers", token: token);
      // print(response.body.toString());
      print(response.statusCode);
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print("responseData: ${responseData}");

        return responseData['hiredFarmers'];
      }
    } catch (err) {
      print(err.toString());
      throw err;
    }
  }
}
