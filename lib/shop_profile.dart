import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'Screens/drawer.dart';
import 'calculator.dart';
import 'custom.dart';
import 'home_screen.dart';
import 'ownerProfile.dart';

class ShopProfile extends StatefulWidget {
  const ShopProfile({super.key});

  @override
  State<ShopProfile> createState() => _ShopProfileState();
}

class _ShopProfileState extends State<ShopProfile> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:  Text("SHOP PROFILE",style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold),),
        backgroundColor: CustomColor.greenTextColor,
        iconTheme: const IconThemeData(color: Colors.white),

      ),
      // drawer: const MainDrawer(),
      bottomNavigationBar: CurvedNavigationBar(
        key: GlobalKey(),
        index: 2,
        height: 60,
        color: CustomColor.greenTextColor,
        buttonBackgroundColor: CustomColor.greenTextColor,
        backgroundColor: Colors.white,
        items: const [
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.calculate_outlined, size: 30, color: Colors.white),
          Icon(Icons.qr_code_2_sharp, size: 40, color: Colors.white),
          Icon(Icons.add_card, size: 30, color: Colors.white),
          Icon(Icons.perm_identity_outlined, size: 30, color: Colors.white),
        ],
        onTap: (index) {
          setState(() {});
          switch (index) {
            case 0:
              Navigator.push(context, MaterialPageRoute(builder: (context) => const MyHomePage()));
              break;
            case 1:
              Navigator.push(context, MaterialPageRoute(builder: (context) => const Calculator()));
              break;
            case 2:
              break;
            case 3:
              break;
            case 4:
              Navigator.push(context, MaterialPageRoute(builder: (context) => const OwnerProfile()));
              break;
          }
        },
      ),
      body: ListView(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              // Profile Image at the top center
              Padding(
                padding: const EdgeInsets.only(top: 30), // Space above the profile image
                child: CircleAvatar(
                  radius: 80, // Set the radius of the circle
                  backgroundImage: AssetImage('images/farmer.jpg'), // Replace with the actual image
                ),
              ),
            ],
          ),
          const SizedBox(height: 10), // Space between profile image and Basics section
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Text(
                    "Basics",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: CustomColor.greenTextColor,
                    ),
                  ),
                ),
                Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.black,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Shop Name",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const Text(
                  "shaheen Agri",
                  style: TextStyle(fontSize: 14, color: Color(0xff4a4b4b)),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Shop Id",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const Text(
                  "Shaheen1122",
                  style: TextStyle(fontSize: 14, color: Color(0xff4a4b4b)),
                ),
                const SizedBox(height: 10),


              ],
            ),
          ),
        ],
      ),
    );
  }
}


