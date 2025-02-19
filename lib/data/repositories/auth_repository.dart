import 'dart:convert';

import 'package:agri_connect/data/services/api_service.dart';
import 'package:agri_connect/Screens/Auth/email_verification.dart';
import 'package:agri_connect/farmer_home_page.dart';
import 'package:agri_connect/home_screen.dart';
import 'package:agri_connect/Screens/Auth/login.dart';
import 'package:agri_connect/main.dart';
import 'package:agri_connect/utils/global_contants.dart';
import 'package:get/get.dart';

class AuthRepository {
  final ApiService _apiService;

  AuthRepository({required ApiService apiService}) : _apiService = apiService;

  Future<bool> login(String email, String password) async {
    // print("_apiService");
    try {
      // Send the login request
      final response = await _apiService.post("/user/login-user", {
        "email": email,
        "password": password,
      });

      var responseData = json.decode(response.body);

      if (prefs != null) {
        prefs!.setString("name", responseData["user"]["name"]);
        prefs!.setString("email", responseData["user"]["email"]);
        prefs!.setString("role", responseData["user"]["role"]);
        prefs!.setString("userId", responseData["user"]["_id"]);
        prefs!.setString("token", responseData['token']);
      }

      // print(prefs!.getString("name"));
      print(responseData);
      print(responseData['token']);
      // token = responseData['token'];
      if (response.statusCode == 200) {
        Get.snackbar("Login Success", "Login successfully...!");
        await initializePreferences();
        responseData["user"]["role"] == "user"
            ? Get.offAll(MyHomePage())
            // : !responseData["user"]["completeProfile"]
            //     ? Get.offAll(FarmerProfile())
                : Get.offAll(FarmerHomePage());
        return true; // Successful login
      } else if (response.statusCode == 400 || response.statusCode == 401) {
        // Check for specific error messages in the response body
        if (response.body.contains("Invalid email or password")) {
          throw Exception("Invalid email or password.");
        } else if (response.body.contains("user not found")) {
          throw Exception("User not found.");
        }
        // General error message
        throw Exception("Login failed. Please check your credentials.");
      } else {
        // Handle other non-success status codes
        throw Exception(
            "Unexpected error occurred. Status code: ${response.statusCode}");
      }
    } catch (e) {
      // Handle any exceptions that occur during the API call
      print("Error: $e");
      rethrow; // Re-throw the exception to be handled by the calling code
    }
  }

  Future<bool> signup(
      String email, String password, String name, String role) async {
    try {
      final response = await _apiService.post("/user/register", {
        "email": email,
        "password": password,
        "name": name,
        "role": role,
      });

      print("Response Status Code: ${response.statusCode}");
      print("Response Headers: ${response.headers}");

      // Check for JSON content type
      final isJson =
          response.headers['content-type']?.contains('application/json') ??
              false;

      // Parse response body only if it is JSON
      final responseBody = isJson ? json.decode(response.body) : null;
      print(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar("Success", "Email sent to $email");
        token = responseBody['activationToken'];
        Get.to(EmailVerificationPage());
        return true; // Successful signup
      }
      if (response.statusCode == 400) {
        print("400 Error Detected");

        Get.snackbar("Error", "Email already exists.");
        throw Exception("Email already exists.");
      }
    } catch (e) {
      // print("catch block is working");
      print("Error: $e");
      rethrow;
    }

    // Ensure a return or throw at the end of the function
    return false; // Default case if all other conditions are not met
  }

  Future<bool> verifyOtp(otp) async {
    try {
      final response = await _apiService
          .post("/user/activate-user", {"activation_code": otp}, token: token);
      // print(otp);
      print(token);
      print(response.statusCode);

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar("OTP Verification ", "OTP verified successfully...!");
        Get.offAll(() => LoginPage());
        return true; // Successful login
      } else if (response.statusCode == 400 || response.statusCode == 401) {
        // Check for specific error messages in the response body
        if (response.body.contains("Invalid activation code")) {
          print("inalve from repo");
          throw Exception("Invalid OTP.");
        }
        if (response.body.contains("user not found")) {
          throw Exception("User not found.");
        }
        // General error message
        throw Exception("OTP verification failed. Please re-enter your OTP.");
      } else {
        // Handle other non-success status codes
        throw Exception(
            "Unexpected error occurred. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<bool> forgetPassword(String email) async {
    try {
      final response = await _apiService.post("/forget", {"email": email});
      print(response.statusCode);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true; // Successful login
      } else if (response.statusCode == 400 || response.statusCode == 401) {
        // Check for specific error messages in the response body
        if (response.body.contains("Invalid email or password")) {
          throw Exception("Invalid email or password.");
        } else if (response.body.contains("user not found")) {
          throw Exception("User not found.");
        }
        // General error message
        throw Exception("Login failed. Please check your credentials.");
      } else {
        // Handle other non-success status codes
        throw Exception(
            "Unexpected error occurred. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<bool> resetPassword(dynamic password) async {
    try {
      final response =
          await _apiService.post("reset-password", {"password": password});

      if (response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 400 || response.statusCode == 401) {
        // Check for specific error messages in the response body
        if (response.body.contains("Invalid email or password")) {
          throw Exception("Invalid email or password.");
        } else if (response.body.contains("user not found")) {
          throw Exception("User not found.");
        } else {
          throw Exception("Bad request or unauthorized.");
        }
      } else {
        throw Exception(
            "Unexpected error occurred. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
