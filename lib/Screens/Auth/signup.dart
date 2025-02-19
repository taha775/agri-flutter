// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:agri_connect/data/controllers/auth/auth_controller.dart';
import 'package:agri_connect/custom.dart';
import 'package:agri_connect/Screens/Auth/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final nameController = TextEditingController();
  final contactController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final ageController = TextEditingController();
  bool isLoading = false;

  AuthController authController = Get.find<AuthController>();

  // Initially, the role is 'User'
  String selectedRole = 'user'; // Default role is 'User'

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(
          child: Text(
            "SignUp",
            style: TextStyle(
                color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: CustomColor.greenTextColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
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
              const SizedBox(
                height: 80,
              ),

              // Name TextField
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: 'Name',
                    fillColor: const Color(0xffF8F9FA),
                    filled: true,
                    prefixIcon: const Icon(Icons.contact_page_outlined,
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
              const SizedBox(
                height: 10,
              ),
              // Email TextField
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
              const SizedBox(
                height: 10,
              ),
              // Password TextField
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: passwordController,
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

              const SizedBox(
                height: 10,
              ),
              // Role Selection (ChoiceChip)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ChoiceChip(
                      label: Text(
                        "User",
                        style: TextStyle(color: Colors.white),
                      ),
                      selected: selectedRole == 'user',
                      onSelected: (selected) {
                        setState(() {
                          selectedRole = 'user';
                        });
                      },
                      selectedColor: CustomColor.greenTextColor,
                      backgroundColor: Colors.grey[300],
                    ),
                    const SizedBox(width: 20),
                    ChoiceChip(
                      label: Text(
                        "Farmer",
                        style: TextStyle(color: Colors.white),
                      ),
                      selected: selectedRole == 'farmer',
                      onSelected: (selected) {
                        setState(() {
                          selectedRole = 'farmer';
                        });
                      },
                      selectedColor: CustomColor.greenTextColor,
                      backgroundColor: Colors.grey[300],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // SignUp Button with SpinKit
              GestureDetector(
                onTap: () async {
                  if (nameController.text.isNotEmpty &&
                      emailController.text.isNotEmpty &&
                      passwordController.text.isNotEmpty) {
                    setState(() {
                      isLoading = true;
                    });
                    // Perform sign-up with selected role
                    await authController.signup(
                      emailController.text,
                      passwordController.text,
                      nameController.text,
                      selectedRole, // Pass the selected role
                    );
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
                        ? SpinKitWave(
                            color: CustomColor.yellowTextColor,
                            size: 30,
                          )
                        : const Text(
                            "SignUp",
                            style: TextStyle(
                              fontFamily: "Rubik Regular",
                              fontSize: 18,
                              color: CustomColor.mintForestTextColor,
                            ),
                          ),
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xff203142),
                        fontFamily: "Rubik Regular",
                      )),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                      );
                    },
                    child: const Text(" Login ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: "Rubik Medium",
                            color: CustomColor.greenTextColor)),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
