import 'dart:async';
import 'package:agri_connect/custom.dart';
import 'package:agri_connect/farmer_home_page.dart';
import 'package:agri_connect/home_screen.dart';
import 'package:agri_connect/Screens/Auth/login.dart';
import 'package:agri_connect/utils/global_contants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    checkLogin();
  }

// Check already login
  void checkLogin() async {
    var userId = await prefs!.getString("userId");
    print("userId");
    print(userId);
    if (userId != null) {
      role == "farmer" ? Get.offAll(FarmerHomePage()) : Get.to(MyHomePage());
    } else {
      Timer(Duration(seconds: 5), () {
        Get.to(LoginPage());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Image.asset(
              'images/logo2.jpg',
            ),
          ),

          // Overlay with text and spinner
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Spacer to push the title down a bit
              //Spacer(flex: 1),
              SizedBox(
                height: 340,
              ),
              // Title text centered at the top

              Text(
                'AGRI-CONNECT',
                style: GoogleFonts.anton(
                  color: CustomColor.greenTextColor,
                  fontSize: 40,
                  letterSpacing: 2.5,
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Colors.black54,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),

              // Spacer to control the distance between the title and spinner
              //Spacer(flex: 1),
              SizedBox(
                height: 220,
              ),
              // Loading spinner in the center
              SpinKitChasingDots(
                color: CustomColor.greenTextColor,
                size: 50,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
