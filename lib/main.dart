import 'package:agri_connect/Screens/splach_screen.dart';
import 'package:agri_connect/data/controllers/auth/auth_controller.dart';
import 'package:agri_connect/data/controllers/farmer_controller.dart';
import 'package:agri_connect/data/controllers/product_controller.dart';
import 'package:agri_connect/data/controllers/shop_controller.dart';
import 'package:agri_connect/custom.dart';
import 'package:agri_connect/data/repositories/auth_repository.dart';
import 'package:agri_connect/data/repositories/farmer_repository.dart';
import 'package:agri_connect/data/repositories/product_repository.dart';
import 'package:agri_connect/data/repositories/shop_repository.dart';
import 'package:agri_connect/data/services/api_service.dart';
import 'package:agri_connect/provider/farmer_provider.dart';
import 'package:agri_connect/provider/product_cart_provider.dart';
import 'package:agri_connect/utils/global_contants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> initializePreferences() async {
  prefs = await SharedPreferences.getInstance();
  token = prefs?.getString("token");
  print("token: ${token}");
  name = prefs?.getString("name");
  email = prefs?.getString("email");
  role = prefs?.getString("role");
  userId = prefs?.getString("userId");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize SharedPreferences
  await initializePreferences();
  prefs = await SharedPreferences.getInstance();

  Get.put(ApiService());
  Get.put(AuthRepository(apiService: Get.find<ApiService>()));
  Get.put(ShopRepository(apiService: Get.find<ApiService>()));
  Get.put(ProductRepository(apiService: Get.find<ApiService>()));
  Get.put(FarmerRepository(apiService: Get.find<ApiService>()));
  Get.lazyPut(() => AuthController(authRepository: Get.find<AuthRepository>()),
      fenix: true);
  Get.lazyPut(() => ShopController(shopRepository: Get.find<ShopRepository>()),
      fenix: true);
  Get.lazyPut(
      () => ProductController(productRepository: Get.find<ProductRepository>()),
      fenix: true);
  Get.lazyPut(
      () => FarmerController(farmerRepository: Get.find<FarmerRepository>()),
      fenix: true);

  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => FarmerProvider()),
      ChangeNotifierProvider(create: (context) => ProductCartProvider()),
    ], child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: CustomColor.ashgrey),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}
