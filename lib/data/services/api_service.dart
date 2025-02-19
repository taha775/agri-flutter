import 'dart:convert';
import 'package:agri_connect/Screens/Auth/login.dart';
import 'package:agri_connect/utils/global_contants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

class ApiService {
  Future<void> checkLogin() async {
    var payload = JwtDecoder.decode(token!);
    print("token check ${payload}");
    DateTime expiry =
        DateTime.fromMillisecondsSinceEpoch(payload["exp"] * 1000);
    print(expiry);
    bool isExpired = expiry.isBefore(DateTime.now());
    print(isExpired);
    if (isExpired) {
      Get.snackbar("Token Expired", "Token expired login again please");
      await prefs?.clear();
      return Get.offAll(LoginPage());
    }
  }

  Future<http.Response> post(String endpoint, Map<String, dynamic> body,
      {String? token}) async {
    print("$baseUrl$endpoint");
    final url = Uri.parse('$baseUrl$endpoint');

    // Await checkLogin
    // await checkLogin(endpoint, "post");

    final headers = {
      "Authorization": "Bearer $token",
      'Content-Type': 'application/json',
    };
    return await http.post(url, headers: headers, body: json.encode(body));
  }

  Future<http.Response> get(String endpoint, {String? token}) async {
    print("$baseUrl$endpoint");
    final url = Uri.parse('$baseUrl$endpoint');

    await checkLogin();
    // await checkLogin(endpoint, "get");

    final headers = {
      "Authorization": "Bearer $token",
      'Content-Type': 'application/json',
    };
    return await http.get(url, headers: headers);
  }

  Future<http.Response> put(String endpoint, Map<String, dynamic> body,
      {String? token}) async {
    print("$baseUrl$endpoint");
    final url = Uri.parse('$baseUrl$endpoint');

    // Await checkLogin
    // await checkLogin(endpoint, "put");

    final headers = {
      "Authorization": "Bearer $token",
      'Content-Type': 'application/json',
    };
    return await http.put(url, headers: headers, body: json.encode(body));
  }

  Future<http.Response> delete(String endpoint, {String? token}) async {
    print("$baseUrl$endpoint");
    final url = Uri.parse('$baseUrl$endpoint');

    // Await checkLogin
    // await checkLogin(endpoint, "delete");

    final headers = {
      "Authorization": "Bearer $token",
      'Content-Type': 'application/json',
    };
    return await http.delete(url, headers: headers);
  }
}
