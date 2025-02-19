import 'package:shared_preferences/shared_preferences.dart';

// final String baseUrl = "http://192.168.0.42:5000/api";
// final String baseUrl = "http://192.168.0.101:5000/api";
final String baseUrl = "https://agroconnectbackend-production.up.railway.app/api";

// Global variables
SharedPreferences? prefs;
String? token;
String? name;
String? email;
String? role;
String? userId;
