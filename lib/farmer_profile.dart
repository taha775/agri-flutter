import 'package:agri_connect/create_farmer_profile.dart';
import 'package:agri_connect/data/controllers/farmer_controller.dart';
import 'package:agri_connect/utils/global_contants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'custom.dart';

class FarmerProfile extends StatefulWidget {
  const FarmerProfile({super.key});

  @override
  State<FarmerProfile> createState() => _FarmerProfileState();
}

class _FarmerProfileState extends State<FarmerProfile> {
  FarmerController farmerController = Get.find<FarmerController>();
  var details, isLoading = false;

  void initState() {
    super.initState();
    getDetails();
  }

  getDetails() async {
    isLoading = true;
    var userId = await prefs?.getString("userId");
    details = await farmerController.getFarmersDetails(userId);
    print("details: $details");
    print("details: ${details['user']['name']}");
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Farmer Profile",
            style: TextStyle(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: CustomColor.greenTextColor,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            onPressed: () async {
              Get.off(CreateFarmerProfile());
            },
            icon: const Icon(Icons.edit),
          )
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              children: [
                // Profile Image
                CircleAvatar(
                  radius: 80,
                  backgroundImage: details['profileImage'] != null
                      ? NetworkImage(details['profileImage'])
                      : const AssetImage('images/farmer.jpg') as ImageProvider,
                ),
                const SizedBox(height: 20),

                // Profile Details
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Basics",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: CustomColor.greenTextColor,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Name
                        buildProfileDetail("Name", details['user']['name']),
                        const SizedBox(height: 10),
                        buildProfileDetail(
                            "Description", "${details['description']}"),
                        const SizedBox(height: 10),

                        // Email
                        buildProfileDetail("Email", details['user']['email']),
                        const SizedBox(height: 10),

                        // Phone Number
                        buildProfileDetail(
                            "Phone Number", details['contactDetails']['phone']),
                        const SizedBox(height: 10),

                        // Price Per Day
                        buildProfileDetail(
                            "Price/Day", "Rs: ${details['pricePerDay']}"),
                        const SizedBox(height: 10),

                        // Price Per Month
                        buildProfileDetail(
                            "Price/Month", "Rs: ${details['pricePerMonth']}"),
                        const SizedBox(height: 10),

                        // Status
                        buildProfileDetail(
                          "Status",
                          details['availability'] ? "Active" : "Non-Active",
                        ),
                        const SizedBox(height: 10),

                        // Address
                        buildProfileDetail(
                            "Address", details['contactDetails']['address']),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget buildProfileDetail(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 14, color: Color(0xff4a4b4b)),
        ),
      ],
    );
  }
}
