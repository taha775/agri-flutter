// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:agri_connect/data/controllers/auth/auth_controller.dart';
import 'package:agri_connect/custom.dart';
import 'package:agri_connect/Screens/Auth/forgot_pw.dart';
import 'package:agri_connect/Screens/Auth/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final pwController = TextEditingController();
  bool isLoading = false;
  String selectedRole = 'User'; // Default role is 'User'
  AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Center(
              child: Text(
            "Login",
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
                const SizedBox(height: 0),
                Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    const Image(
                      height: 140,
                      width: 140,
                      image: AssetImage("images/logo2.jpg"),
                    ),
                    Positioned(
                      bottom: -30,
                      child: Column(
                        children: [
                          Text(
                            "AGRI-CONNECT",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              fontFamily: "Rubin Medium",
                              color: CustomColor.greenTextColor,
                            ),
                          ),
                          const Text(
                            "Farmers | Experts | Suppliers | Buyers",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: "Rubin Regular",
                              color: Color(0xff4C5980),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 50),
                // const Center(
                //   child: Text(
                //     "Login",
                //     style: TextStyle(
                //       fontSize: 28,
                //       fontFamily: "Rubin Medium",
                //       color: CustomColor.greenTextColor,
                //     ),
                //   ),
                // ),
                const SizedBox(height: 30),

                // User/Admin selection

                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      fillColor: const Color(0xffF8F9FA),
                      filled: true,
                      prefixIcon: const Icon(Icons.email_outlined,
                          color: CustomColor.greenTextColor),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xffE4E7EB)),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xffE4E7EB)),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
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
                        borderSide: const BorderSide(color: Color(0xffE4E7EB)),
                        borderRadius: BorderRadius.circular(11),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xffE4E7EB)),
                        borderRadius: BorderRadius.circular(11),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(ForgotPassword());
                        },
                        child: Text(
                          "Forgot Password",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            color: Color(0xff203142),
                            fontFamily: "Rubik Medium",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                GestureDetector(
                  onTap: () async {
                    if (isLoading) return; // Prevent duplicate taps
                    if (emailController.text.isEmpty ||
                        pwController.text.isEmpty) {
                      Get.snackbar(
                          "Error", "Email and Password cannot be empty!",
                          backgroundColor: Colors.red, colorText: Colors.white);
                      return;
                    }
                    setState(() {
                      isLoading = true;
                    });
                    try {
                      await authController.login(
                          emailController.text, pwController.text);
                    } catch (e) {
                      Get.snackbar("Error", "Login failed. Please try again.",
                          backgroundColor: Colors.red, colorText: Colors.white);
                    } finally {
                      setState(() {
                        isLoading = false;
                      });
                    }
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
                              "Login",
                              style: TextStyle(
                                fontFamily: "Rubik Regular",
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: CustomColor.mintForestTextColor,
                              ),
                            ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xff203142),
                        fontFamily: "Rubik Regular",
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpPage()));
                      },
                      child: const Text(
                        " Sign Up ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: "Rubik Medium",
                          color: CustomColor.greenTextColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
