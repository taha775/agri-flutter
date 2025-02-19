import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'calculator.dart';
import 'custom.dart';
import 'Screens/drawer.dart';
import 'home_screen.dart';
import 'ownerProfile.dart';

class SocialMediaPage extends StatefulWidget {
  @override
  _SocialMediaPageState createState() => _SocialMediaPageState();
}

class _SocialMediaPageState extends State<SocialMediaPage> {
  // Sample data for posts
  final List<Map<String, dynamic>> posts = [
    {
      "username": "M Hammad Arain",
      "postContent": "Latest News Updates",
      "profileImagePath": 'images/hammad.jpeg', // Profile image
      "postImagePath": 'images/news6.jpg', // Post image
      "isLiked": false,
    },
    {
      "username": "Imran Khan",
      "postContent": "Meeting with Farmers",
      "profileImagePath": 'images/ik_pic.jpg', // Profile image
      "postImagePath": 'images/newsik.jpg', // Post image
      "isLiked": false,
    },
    {
      "username": "Muhammad Taha",
      "postContent": "Agriculture Land Ownership",
      "profileImagePath": 'images/taha.jpeg', // Profile image
      "postImagePath": 'images/news0.jpg', // Post image
      "isLiked": false,
    },
    {
      "username": "Sohail Sario",
      "postContent": "Always make Profit",
      "profileImagePath": 'images/sohail.jpeg', // Profile image
      "postImagePath": 'images/news3.jpg', // Post image
      "isLiked": false,
    },
    {
      "username": "Muhammad Taha",
      "postContent": "Product News",
      "profileImagePath": 'images/taha.jpeg', // Profile image
      "postImagePath": 'images/news2.jpg', // Post image
      "isLiked": false,
    },
    {
      "username": "Imran Khan",
      "postContent": "Kisan Card inauguration by PM",
      "profileImagePath": 'images/ik_pic.jpg', // Profile image
      "postImagePath": 'images/news1.jpg', // Post image
      "isLiked": false,
    },
    {
      "username": "Bilawal Bhutto",
      "postContent": "Introduce Free Solar Panel Scheme 2024 ",
      "profileImagePath": 'images/bilawal.jpg', // Profile image
      "postImagePath": 'images/news5.webp', // Post image
      "isLiked": false,
    },
    {
      "username": "Sohail Sario",
      "postContent": "Agriculture land ownership",
      "profileImagePath": 'images/sohail.jpeg', // Profile image
      "postImagePath": 'images/news0.jpg', // Post image
      "isLiked": false,
    },

    // Add more posts as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("AGRI-NEWS",
          style: TextStyle(color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold),)),
        backgroundColor: CustomColor.greenTextColor,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(onPressed: () {},
            icon: const Icon(Icons.notifications_active),)
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        key: GlobalKey(),
        index: 2,
        height: 60,
        color: CustomColor.greenTextColor,
        buttonBackgroundColor: CustomColor.greenTextColor,
        backgroundColor: Colors.white,
        items: const [
          Icon(Icons.home, size: 30, color: Colors.white,),
          Icon(
            Icons.calculate_outlined, size: 30, color: Colors.white,),
          Icon(Icons.qr_code_2_sharp, size: 40, color: Colors.white,),
          Icon(Icons.add_card, size: 30, color: Colors.white,),
          Icon(Icons.perm_identity_outlined, size: 30,
            color: Colors.white,),
        ],
        onTap: (index) {
          // Handle navigation to different screens based on the tapped index
          setState(() {});

          switch (index) {
            case 0:
            // Navigate to Home Screen
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => const MyHomePage()));
              break;
            case 1:
            // Navigate to Chat screen
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => const Calculator()));
              break;
            case 2:
            // Navigate to QR scanner
            //Navigator.push(context, MaterialPageRoute(builder: (context) => const ScannerPage()));
              break;
            case 3:
            // Navigate to Add Card screen
            //Navigator.push(context, MaterialPageRoute(builder: (context) => const MyAtmCard()));
              break;
            case 4:
            // Navigate to Profile screen
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => const OwnerProfile()));
              break;
          }
        },
      ),
      drawer: const MainDrawer(),

      body: ListView.builder(
        itemCount: posts.length, // Number of posts
        itemBuilder: (context, index) {
          final post = posts[index]; // Get the current post data
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Card(
              elevation: 20,
              shadowColor: CustomColor.greenTextColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(post['profileImagePath']), // User's profile picture
                      radius: 25,
                    ),
                    title: Text(post['username'], style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(post['postContent']),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Image.asset(
                      post['postImagePath'], // Post image
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                post['isLiked']
                                    ? Icons.thumb_up_alt
                                    : Icons.thumb_up_alt_outlined,
                                color: post['isLiked'] ? Colors.blue : Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  posts[index]['isLiked'] = !posts[index]['isLiked'];
                                });
                              },
                            ),
                            Text("Like"),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.comment_outlined),
                              onPressed: () {},
                            ),
                            Text("Comment"),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.share_outlined),
                              onPressed: () {},
                            ),
                            Text("Share"),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
