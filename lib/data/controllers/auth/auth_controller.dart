import 'package:agri_connect/data/repositories/auth_repository.dart';
import 'package:get/get.dart';
// import 'package:agri_connect/data/repositories/auth_repository.dart';
// import 'package:get/get.dart';

class AuthController extends GetxController {
  final AuthRepository authRepository;

  // Observables
  var isLoading = false.obs;

  // Constructor with named parameter
  AuthController({required this.authRepository});

  Future<void> login(String email, String password) async {
    isLoading.value = true;

    try {
      // print("login controller");
      bool success = await authRepository.login(email, password);
      print("success $success");
    } catch (e) {
      print(e);
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signup(
      String email, String password, String name, String role) async {
    isLoading.value = true;

    try {
      bool success = await authRepository.signup(email, password, name, role);
      print("success $success");
    } catch (e) {
      print(e);
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> verifyOtp(String otp) async {
    try {
      final result = await authRepository.verifyOtp(otp);
      print("result $result");
    } catch (e) {
      print(e);
    }
  }

  Future<void> forgetPassword(String email) async {
    try {
      final result = await authRepository.forgetPassword(email);
      print("result $result");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> resetPassword(String password) async {
    try {
      final result = await authRepository.verifyOtp(password);
      print("result $result");
    } finally {
      isLoading.value = false;
    }
  }
}
