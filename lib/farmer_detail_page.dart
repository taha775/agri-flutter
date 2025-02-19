import 'package:agri_connect/data/controllers/farmer_controller.dart';
import 'package:agri_connect/find_farmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'custom.dart';

class FarmerDetailPage extends StatefulWidget {
  final Farmer farmer;

  FarmerDetailPage({super.key, required this.farmer});

  @override
  State<FarmerDetailPage> createState() => _FarmerDetailPageState();
}

class _FarmerDetailPageState extends State<FarmerDetailPage> {
  FarmerController farmerController = Get.find<FarmerController>();
  var farmerDetails;

  @override
  void initState() {
    super.initState();
    getDetail();
  }

  Future<void> getDetail() async {
    print("widget.farmer.id ${widget.farmer.id}");
    var details = await farmerController.getFarmersDetails(widget.farmer.id);
    setState(() {
      farmerDetails = details;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColor.greenTextColor,
        title: Text(widget.farmer.name, style: TextStyle(color: Colors.white)),
      ),
      body: farmerDetails == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      elevation: 11,
                      child: Container(
                        height: 250,
                        width: double.infinity,
                        child: Image.network(widget.farmer.image,
                            fit: BoxFit.cover),
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.star, color: Colors.amber),
                        SizedBox(width: 5),
                        Text("4.7 (13)", style: TextStyle(fontSize: 16)),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(widget.farmer.name,
                        style: TextStyle(
                            fontSize: 24,
                            color: CustomColor.greenTextColor,
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Price/Day: ${widget.farmer.priceDay}",
                              style: TextStyle(fontSize: 16)),
                          Text("Price/Month: ${widget.farmer.priceMonth}",
                              style: TextStyle(fontSize: 16)),
                          SizedBox(height: 20),
                          Text("Description:",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(height: 5),
                          Text(
                            farmerDetails?['skills'] != null &&
                                    farmerDetails['skills'].isNotEmpty
                                ? farmerDetails['skills']
                                    .map((skill) =>
                                        "\u2022 ${skill['category']} - ${skill['description']} (${skill['experience']} years)")
                                    .join("\n")
                                : "No skills available", // Provide a fallback when skills is null or empty
                          ),
                          SizedBox(height: 20),
                          Text("Address:",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(height: 5),
                          Text(farmerDetails!['contactDetails']['address'] ??
                              "Not Available"),
                          SizedBox(height: 20),
                          Text("Contact:",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(height: 5),
                          Text(farmerDetails!['contactDetails']['phone'] ??
                              "Not Available"),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await farmerController.hireFarmer(widget.farmer.id);
                        // Implement call functionality
                        final phoneNumber = farmerDetails!['contactDetails']['phone'];
                        final Uri phoneUri = Uri.parse('tel:$phoneNumber');

                        if (await canLaunchUrl(phoneUri)) {
                          await launchUrl(phoneUri);
                        } else {
                          // Handle error (optional)
                          print('Could not launch dial pad');
                        }
                      },
                      child: Text('Call',
                          style: TextStyle(fontSize: 18, color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CustomColor.greenTextColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(11),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
