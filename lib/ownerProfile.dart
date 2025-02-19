import 'dart:convert';
import 'package:agri_connect/utils/global_contants.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'calculator.dart';
import 'custom.dart';
import 'Screens/drawer.dart';
import 'home_screen.dart';

class OwnerProfile extends StatefulWidget {
  const OwnerProfile({super.key});

  @override
  State<OwnerProfile> createState() => _OwnerProfileState();
}

class _OwnerProfileState extends State<OwnerProfile> {
  Map<String, dynamic>? _userProfile; // To store the user profile data
  List<dynamic>? _hiredFarmers; // To store hired farmers data
  bool _isLoading = true; // To show loading state
  String userId = "";

  @override
  void initState() {
    super.initState();
    userId = prefs?.getString("userId") ?? "";
    _fetchUserProfile(userId);
  }

  // Fetch user profile data from the API
  Future<void> _fetchUserProfile(userId) async {
    final response = await http
        .get(Uri.parse('${baseUrl}/user/userprofile/${userId}'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print("data['user']['hiredFarmers'] ${data['user']}");
      setState(() {
        _userProfile = data['user'];
        _hiredFarmers = data['user']['hiredFarmers'];
        _isLoading = false;
      });
    } else {
      // Handle error here (e.g., show a message if the API call fails)
      setState(() {
        _isLoading = false;
      });
      Get.snackbar("Failed to load profile","Error");
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Center(
              child: Text(
                "OWNER PROFILE",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            backgroundColor: CustomColor.greenTextColor,
            iconTheme: const IconThemeData(color: Colors.white),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications_active),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.edit),
              ),
            ],
          ),
          drawer: const MainDrawer(),
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyHomePage()));
                  break;
                case 1:
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Calculator()));
                  break;
                case 2:
                  break;
                case 3:
                  break;
                case 4:
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const OwnerProfile()));
                  break;
              }
            },
          ),
          body: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView(
                  children: [
                    Column(
                      children: [
                        const SizedBox(height: 30),
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              radius: 80,
                              backgroundImage: NetworkImage(
                                  'images/farmer.jpg'), // Use fetched image URL or default
                            ),
                            Container(
                              margin: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                color: CustomColor.greenTextColor,
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.edit,
                                    color: Colors.white, size: 24),
                                onPressed: () {
                                  // Handle profile edit
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Text(
                          _userProfile!['name'] ?? 'John Doe', // Use fetched data
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: CustomColor.greenTextColor,
                          ),
                        ),
                        Text(
                          _userProfile!['role'] ?? 'User', // Use fetched data
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    _buildSection("Personal Information", [
                      _buildInfoRow(
                          "Name", _userProfile!['name'] ?? 'John Doe'),
                      _buildInfoRow("Email",
                          _userProfile!['email'] ?? 'john.doe@agri.com'),
                    ]),
                    _buildSection("Hired Farmers", [
                      if (_hiredFarmers != null && _hiredFarmers!.isNotEmpty)
                        ..._hiredFarmers!.map((farmer) {
                          return _buildFarmerInfo(farmer);
                        }).toList()
                      else
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("No farmers hired."),
                        ),
                    ]),
                    const SizedBox(height: 30),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: CustomColor.greenTextColor,
            ),
          ),
          const Divider(thickness: 1, color: Colors.black),
          const SizedBox(height: 15),
          ...children,
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xff4a4b4b),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFarmerInfo(dynamic farmer) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(farmer['profileImage']?['url'] ??
                'images/farmer.jpg'),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  farmer['user']['name'] ?? 'Unknown Farmer',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  farmer['description'] ?? 'No description available',
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                Text(
                  'Price per Day: \$${farmer['pricePerDay']}',
                  style: const TextStyle(fontSize: 14),
                ),
                Text(
                  'Price per Month: \$${farmer['pricePerMonth']}',
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
