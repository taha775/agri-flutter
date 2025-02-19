import 'package:agri_connect/custom.dart';
import 'package:agri_connect/Screens/Auth/login.dart';
import 'package:agri_connect/ownerProfile.dart';
import 'package:agri_connect/utils/global_contants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home_screen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    name = prefs!.getString("name");
    role = prefs!.getString("role");

    return Drawer(
      child: role == "user"
          ? Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  child: DrawerHeader(
                    decoration: BoxDecoration(
                      color: CustomColor.greenTextColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage("images/farmer.jpg"),
                          radius: 35,
                        ),
                        SizedBox(height: 10),
                        Text(
                          name ?? "no name",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          role ?? "role",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      ListTile(
                        leading: const Icon(
                          Icons.person,
                          color: CustomColor.greenTextColor,
                        ),
                        title: const Text("Profile"),
                        onTap: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>OwnerProfile()));
                          //Navigator.push(context, MaterialPageRoute(builder: (context) => const OwnerProfile()));
                        },
                      ), //profile
                      Container(
                        color: CustomColor.yellowTextColor,
                        height: 1,
                        width: double.infinity,
                      ),
                      ListTile(
                          leading: const Icon(Icons.home,
                              color: CustomColor.greenTextColor),
                          title: const Text("Home"),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const MyHomePage()));
                          }), //home
                      Container(
                        color: CustomColor.yellowTextColor,
                        height: 1,
                        width: double.infinity,
                      ),
                      ListTile(
                          leading: const Icon(Icons.star_border,
                              color: CustomColor.greenTextColor),
                          title: const Text("Whats New"),
                          onTap: () {
                            //Navigator.push(context, MaterialPageRoute(builder: (context) => const MyHomePage()));
                          }), //whats new
                      Container(
                        color: CustomColor.yellowTextColor,
                        height: 1,
                        width: double.infinity,
                      ),
                      ListTile(
                          leading: const Icon(Icons.add_chart_rounded,
                              color: CustomColor.greenTextColor),
                          title: const Text("More Services"),
                          onTap: () {
                            //Navigator.push(context, MaterialPageRoute(builder: (context) => const MyHomePage()));
                          }), //more services
                      Container(
                        color: CustomColor.yellowTextColor,
                        height: 1,
                        width: double.infinity,
                      ),
                      ListTile(
                          leading: const Icon(Icons.location_on,
                              color: CustomColor.greenTextColor),
                          title: const Text("Location"),
                          onTap: () {
                            //Navigator.push(context, MaterialPageRoute(builder: (context) => const MyHomePage()));
                          }), //Location
                      Container(
                        color: CustomColor.yellowTextColor,
                        height: 1,
                        width: double.infinity,
                      ),
                      const ListTile(
                        leading: Icon(Icons.settings,
                            color: CustomColor.greenTextColor),
                        title: Text("Settings"),
                        onTap: null,
                      ), //Setting
                      Container(
                        color: CustomColor.yellowTextColor,
                        height: 1,
                        width: double.infinity,
                      ),
                      const ListTile(
                        leading: Icon(Icons.share,
                            color: CustomColor.greenTextColor),
                        title: Text("Share"),
                        onTap: null,
                      ), //Invite Friend
                      Container(
                        color: CustomColor.yellowTextColor,
                        height: 1,
                        width: double.infinity,
                      ),
                      const ListTile(
                        leading: Icon(Icons.perm_contact_calendar_sharp,
                            color: CustomColor.greenTextColor),
                        title: Text("About"),
                        onTap: null,
                      ), //Contact Us
                      Container(
                        color: CustomColor.yellowTextColor,
                        height: 1,
                        width: double.infinity,
                      ),
                    
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CustomColor.greenTextColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(20), // Rounded shape
                      ),
                      minimumSize: Size(double.infinity, 50), // Full width
                    ),
                    icon: const Icon(Icons.logout),
                    label: const Text("Logout"),
                    onPressed: () async {
                      await prefs!.clear();
                      Get.off(() => LoginPage());
                    },
                  ),
                ),
              ],
            )
          : Column(
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: CustomColor.greenTextColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage("images/farmer.jpg"),
                        radius: 35,
                      ),
                      SizedBox(height: 10),
                      Text(
                        name ?? "no name",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        role ?? "role",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      ListTile(
                        leading: const Icon(Icons.home,
                            color: CustomColor.greenTextColor),
                        title: const Text("Home"),
                        onTap: () {},
                      ),
                      Divider(color: CustomColor.yellowTextColor, thickness: 1),
                      ListTile(
                        leading: const Icon(Icons.person,
                            color: CustomColor.greenTextColor),
                        title: const Text("Profile"),
                        onTap: () {},
                      ),
                      Divider(color: CustomColor.yellowTextColor, thickness: 1),
                      // Add more menu items here...
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CustomColor.greenTextColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(20), // Rounded shape
                      ),
                      minimumSize: Size(double.infinity, 50), // Full width
                    ),
                    icon: const Icon(Icons.logout),
                    label: const Text("Logout",),
                    onPressed: () async {
                      await prefs!.clear();
                      Get.off(() => LoginPage());
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
