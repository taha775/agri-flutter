import 'package:agri_connect/data/controllers/auth/auth_controller.dart';
import 'package:agri_connect/custom.dart';
// import 'package:agri_connect/email_verification.dart';
import 'package:agri_connect/Screens/Auth/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ResetPassword> {
  final pwController = TextEditingController();
  final pwConfirmController = TextEditingController();
  bool isLoading = false;
  AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Center(
              child: Text(
            "Reset Password",
            style: TextStyle(
                color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
          )),
          backgroundColor: CustomColor.greenTextColor,
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image(
                  image: AssetImage("images/logo2.jpg"),
                ),
                const Center(
                  child: Column(
                    children: [
                      Text(
                        "Enter New Password",
                        style: TextStyle(
                          fontSize: 28,
                          fontFamily: "Rubin Medium",
                          color: CustomColor.greenTextColor,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 40, left: 40),
                        child: Text(
                          "Your new password must be different from previously used password",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: "Rubin Regular",
                            color: Color(0xff4C5980),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        controller: pwController,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          fillColor: const Color(0xffF8F9FA),
                          filled: true,
                          prefixIcon: const Icon(Icons.lock_outline,
                              color: CustomColor.greenTextColor),
                          suffixIcon: const Icon(Icons.visibility_off_outlined),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Color(0xffE4E7EB)),
                            borderRadius: BorderRadius.circular(11),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Color(0xffE4E7EB)),
                            borderRadius: BorderRadius.circular(11),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 11,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        controller: pwConfirmController,
                        decoration: InputDecoration(
                          hintText: 'Confirm Password',
                          fillColor: const Color(0xffF8F9FA),
                          filled: true,
                          prefixIcon: const Icon(Icons.lock_outline,
                              color: CustomColor.greenTextColor),
                          suffixIcon: const Icon(Icons.visibility_off_outlined),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Color(0xffE4E7EB)),
                            borderRadius: BorderRadius.circular(11),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Color(0xffE4E7EB)),
                            borderRadius: BorderRadius.circular(11),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                GestureDetector(
                  onTap: () async {
                    if (isLoading) return; // Prevent duplicate taps
                    if (pwController.text.isEmpty) {
                      Get.snackbar("Error", "Password cannot be empty!",
                          backgroundColor: Colors.red, colorText: Colors.white);
                      return;
                    }
                    setState(() {
                      isLoading = true;
                    });
                    try {
                      authController.resetPassword(pwController.text);
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    } catch (e) {
                      Get.snackbar("Error", "Reset password failed. Please try again.",
                          backgroundColor: Colors.red, colorText: Colors.white);
                    } finally {
                      setState(() {
                        isLoading = false;
                      });
                    }
                    // Navigate to home screen after delay
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
                              "Continue",
                              style: TextStyle(
                                fontFamily: "Rubik Regular",
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: CustomColor.yellowTextColor,
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
