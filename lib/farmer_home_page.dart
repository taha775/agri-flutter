import 'package:agri_connect/Screens/drawer.dart';
import 'package:agri_connect/calculator.dart';
import 'package:agri_connect/data/controllers/farmer_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'create_farmer_profile.dart';
import 'custom.dart';
import 'farmer_profile.dart';
import 'home_screen.dart';
import 'ownerProfile.dart';
import 'provider/farmer_provider.dart';
import 'utils/global_contants.dart';

class FarmerHomePage extends StatefulWidget {
  const FarmerHomePage({super.key});

  @override
  State<FarmerHomePage> createState() => _FarmerHomePageState();
}

class _FarmerHomePageState extends State<FarmerHomePage> {
  bool _isSwitched = false;
  bool isTapped = false;

  void _onTap() {
    setState(() {
      isTapped = !isTapped;
    });
  }

  FarmerController farmerController = Get.find<FarmerController>();
  Map<String, dynamic>? farmerDetails;

  void initState() {
    // TODO: implement initState
    super.initState();
    getDetail();
  }

  Future<void> getDetail() async {
    print(userId);
    var details = await farmerController.getFarmersDetails(userId);
    setState(() {
      farmerDetails = details;
    });
  }

  @override
  Widget build(BuildContext context) {
    final farmers = Provider.of<FarmerProvider>(context).farmer.values.toList();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Agri Farmer',
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
        backgroundColor: CustomColor.greenTextColor,
        actions: [
          IconButton(
            onPressed: () {
              // await prefs?.clear();
              // Get.to(LoginPage());
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CreateFarmerProfile()));
            },
            icon: const Icon(FontAwesomeIcons.plus,
                color: Colors.white, size: 22),
          ),
          const SizedBox(width: 15),
        ],
      ),
      drawer: MainDrawer(),
      bottomNavigationBar: CurvedNavigationBar(
        index: 2,
        height: 60,
        color: CustomColor.greenTextColor,
        buttonBackgroundColor: CustomColor.greenTextColor,
        backgroundColor: Colors.white,
        items: const [
          Icon(Icons.home, size: 30, color: CustomColor.mintForestTextColor),
          Icon(Icons.calculate_outlined,
              size: 30, color: CustomColor.mintForestTextColor),
          Icon(Icons.qr_code_2_sharp,
              size: 40, color: CustomColor.mintForestTextColor),
          Icon(Icons.add_card,
              size: 30, color: CustomColor.mintForestTextColor),
          Icon(Icons.perm_identity_outlined,
              size: 30, color: CustomColor.mintForestTextColor),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const MyHomePage()));
              break;
            case 1:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Calculator()));
              break;
            case 4:
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const OwnerProfile()));
              break;
          }
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: _onTap,
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 120,
                  decoration: BoxDecoration(
                    color: isTapped
                        ? CustomColor.greenTextColor
                        : CustomColor.greenTextColor1,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Text(
                    isTapped ? "You are Active now!" : "Click here to Activate",
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 3 / 4,
                ),
                itemCount: 4,
                itemBuilder: (context, index) {
                  final List<Map<String, String>> options = [
                    {"image": "images/farmer.jpg", "label": "Profile"},
                    {"image": "images/farmer_history.png", "label": "History"},
                    {"image": "images/farmer_review.png", "label": "Reviews"},
                    {
                      "image": "images/farmer_colleague.png",
                      "label": "Colleague"
                    },
                  ];
                  return InkWell(
                    onTap: () {
                      if (index == 0) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FarmerProfile()));
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: CustomColor.greenTextColor1.withOpacity(0.5),
                            blurRadius: 8,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                AssetImage(options[index]["image"]!),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            options[index]["label"]!,
                            style: TextStyle(
                              fontSize: 18,
                              color: CustomColor.greenTextColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}











// ListView.builder(
//   itemCount: farmers.length,
//   itemBuilder: (context, index) {
//     final farmer = farmers[index];
//     return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: 30,),
//             Center(
//               child: GestureDetector(
//                 onTap: () {
//                   // Handle profile picture tap
//                 },
//                 child: Icon(
//                   Icons.image,
//                   size: 120,
//                   color: CustomColor.mutedSageTextColor,
//                 ),
//               ),
//             ),
//             SizedBox(height: 20,),
//             Padding(
//               padding: const EdgeInsets.only(left: 22),
//               child: Text("Name: ${farmer['name']}",style: TextStyle(fontSize: 25),),
//             ),
//             SizedBox(height: 10,),
//             Padding(
//               padding: const EdgeInsets.only(left: 22),
//               child: Text("Rs: ${farmer['priceDay']} /hour \nRs: ${farmer["priceMonth"]} /day",style: TextStyle(fontSize: 18,color:CustomColor.ashgrey),),
//             ),
//             SizedBox(height: 60,),
//
//             Center(
//               child: GestureDetector(
//                 onTap: (){
//                   bool currentState = farmer['isActive'] ?? false;
//                   Provider.of<FarmerProvider>(context, listen: false)
//                       .setActive(farmer['name'], !currentState); //error: Undefined name 'value'.
//                 },
//                 child: Container(
//                   height: 120,
//                   width: MediaQuery.sizeOf(context).width*0.90,
//                   decoration: BoxDecoration(
//                       color: farmer['isActive']? CustomColor.greenTextColor : CustomColor.greenTextColor1,
//                       borderRadius: BorderRadius.all(Radius.circular(20))
//                   ),
//                   child: Center(child: Text( farmer['isActive']? "You are Active now!": "Click here to Active",style: TextStyle(color: Colors.white,fontSize: 28),)),
//                 ),
//               ),
//             ),
//
//             SizedBox(height: 20,),
//
//           ],
//       );
//   },
// ),
