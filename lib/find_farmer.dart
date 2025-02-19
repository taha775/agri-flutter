// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:agri_connect/data/controllers/farmer_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'custom.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'farmer_detail_page.dart';
import 'my_farmer.dart';

class FindFarmer extends StatefulWidget {
  const FindFarmer({super.key});

  @override
  State<FindFarmer> createState() => _FindFarmerState();
}

class _FindFarmerState extends State<FindFarmer> {
  // ProductController productController = Get.find<ProductController>();
  FarmerController farmerController = Get.find<FarmerController>();
  void initState() {
    // TODO: implement initState
    super.initState();
    getAll_Farmers();
  }

  var farmers = [];
  getAll_Farmers() async {
    try {
      var result = await farmerController.getAllFarmers();
print("result ${result}");
      // Assume `result` is a List<dynamic> parsed from JSON
      // if (result) {
        setState(() {
          farmers = result.map((data) => Farmer.fromJson(data)).toList();
        });
      // } else {
      //   print('Unexpected response format: $result');
      //   return [];
      // }
    } catch (error) {
      print('Error fetching farmers: $error');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Farmers',
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
        backgroundColor: CustomColor.greenTextColor,
        actions: [
          const Icon(FontAwesomeIcons.magnifyingGlass, color: Colors.white),
          const SizedBox(width: 15),
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyFarmerPage()));
              },
              icon: Icon(
                FontAwesomeIcons.stackOverflow,
                color: Colors.white,
              )),
          PopupMenuButton(
            icon: const Icon(Icons.more_vert_outlined, color: Colors.white),
            itemBuilder: (context) => [
              const PopupMenuItem(value: 1, child: Text("ENGLISH")),
              const PopupMenuItem(value: 2, child: Text("URDU")),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: farmerController.isLoading == true
            ? Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Center(
                  child: CircularProgressIndicator(),
                ),
                SizedBox(
                  height: 10,
                ),
                Text("Farmers are loading please wait...")
              ])
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: FarmerList(
                  farmers: farmers,
                ),
              ),
      ),
    );
  }
}

class FarmerList extends StatelessWidget {
  final List farmers;

  const FarmerList({required this.farmers});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: farmers.length,
      itemBuilder: (context, index) {
        final farmer = farmers[index];
        print("farmer: ${farmer.toString()}");
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FarmerDetailPage(farmer: farmer),
              ),
            );
          },
          child: Card(
            margin: const EdgeInsets.symmetric(vertical: 10),
            color: CustomColor.mintForestTextColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            shadowColor: CustomColor.silverTextColor,
            elevation: 5,
            child: Container(
              height: 160,
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 50, // Set the radius of the circle
                    backgroundImage: NetworkImage(farmer.image),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          farmer.name,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: CustomColor.greenTextColor,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Price/Day: ${farmer.priceDay} PKR',
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Price/Month: ${farmer.priceMonth} PKR',
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: const [
                            Icon(Icons.star, color: Colors.amber, size: 16),
                            SizedBox(width: 5),
                            Text(
                              '3.7 (13)',
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class Farmer {
  final String name;
  final double priceDay;
  final double priceMonth;
  final String image;
  final String id;

  Farmer({
    required this.name,
    required this.priceDay,
    required this.priceMonth,
    required this.image,
    required this.id,
  });

  factory Farmer.fromJson(Map<String, dynamic> json) {
  return Farmer(
    name: json['user']['name'] ?? 'Unknown',
    priceDay: (json['pricePerDay'] is int)
        ? (json['pricePerDay'] as int).toDouble()
        : (json['pricePerDay'] ?? 0.0) as double,
    priceMonth: (json['pricePerMonth'] is int)
        ? (json['pricePerMonth'] as int).toDouble()
        : (json['pricePerMonth'] ?? 0.0) as double,
    image: json['profileImage'] != null && json['profileImage'] is Map
        ? json['profileImage']['url'] ?? 'assets/default_image.png'  // Adjust the key as per the response
        : 'assets/default_image.png',  // Fallback if profileImage is null or not a Map
    id: json['_id'],
  );
}

}
