import 'package:agri_connect/custom.dart';
import 'package:agri_connect/data/controllers/farmer_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class MyFarmerPage extends StatefulWidget {
  @override
  _MyFarmerPageState createState() => _MyFarmerPageState();
}

class _MyFarmerPageState extends State<MyFarmerPage> {
  FarmerController farmerController = Get.find<FarmerController>();

  @override
  void initState() {
    super.initState();
    farmerController.get_hiredFarmer();
  }

  Future<void> _makePhoneCall(String? phoneNumber) async {
    if (phoneNumber == null || phoneNumber.isEmpty) {
      Get.snackbar('Error', 'Phone number not available');
      return;
    }
    final Uri phoneUri = Uri.parse('tel:$phoneNumber');
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      Get.snackbar('Error', 'Could not launch dial pad');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.mutedSageTextColor1,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: CustomColor.greenTextColor,
        title: const Text(
          "My Farmers",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Obx(() {
        if (farmerController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: farmerController.farmers.length,
          itemBuilder: (context, index) {
            final farmer = farmerController.farmers[index];
            final name = farmer['user']['name'] ?? "Unknown";
            final phoneNumber = farmer['contactDetails']['phone'];
            final skills = farmer['skills'] ?? [];

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: CustomColor.mutedSageTextColor,
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      if (skills.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: skills
                              .map<Widget>((skill) => Text(
                                  "• ${skill['category']} (${skill['experience']} years)"))
                              .toList(),
                        ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                // farmerController.cancelHire(farmer.id);
                              },
                              child: Text(
                                "Cancel",
                                style: TextStyle(
                                    color: CustomColor.greenTextColor1),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    CustomColor.mutedSageTextColor1,
                                foregroundColor: CustomColor.greenTextColor,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 10),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () => _makePhoneCall(phoneNumber),
                              child: Text(
                                "Call Again",
                                style: TextStyle(
                                    color: CustomColor.greenTextColor1),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    CustomColor.mutedSageTextColor1,
                                foregroundColor: CustomColor.greenTextColor,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 10),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
