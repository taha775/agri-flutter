import 'package:agri_connect/agri_detection_page.dart';
import 'package:agri_connect/custom.dart';
import 'package:agri_connect/data/controllers/product_controller.dart';
import 'package:agri_connect/find_farmer.dart';
import 'package:agri_connect/news_page.dart';
import 'package:agri_connect/notes_page.dart';
import 'package:agri_connect/shop_categories.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'calculator.dart';
import 'Screens/drawer.dart';
import 'ownerProfile.dart';
import 'package:weather/weather.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ProductController productController = Get.find<ProductController>();
  late Future<List<Map<String, dynamic>>> _productsFuture;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _productsFuture = Future.value([]); // Initialize with an empty list
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    try {
      var allProducts = await productController.getAllProducts(count: 3);

      print("allProducts: $allProducts");

      // Map the response to the required format
      print(allProducts[0]);
      final List<Map<String, dynamic>> fetchedProducts = (allProducts as List)
          .map((product) => {
                'name': product['name'],
                'price': product['price'],
                'description': product['description'],
                'image': product['image'],
                'stock': product['stock'],
                'id': product['_id'],
              })
          .toList();

      setState(() {
        // _isLoading = false;
        _productsFuture = Future.value(fetchedProducts);
      });
    } catch (error) {
      print(" error.toString() ${error.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const ExitConfirmationDialog();
            },
          );
          return false;
        },
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              appBar: AppBar(
                title: const Center(
                    child: Text(
                  "AGRI-CONNECT",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                )),
                backgroundColor: CustomColor.greenTextColor,
                iconTheme: const IconThemeData(color: Colors.white),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.notifications_active),
                  )
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
                  Icon(
                    Icons.home,
                    size: 30,
                    color: CustomColor.mintForestTextColor,
                  ),
                  Icon(
                    Icons.calculate_outlined,
                    size: 30,
                    color: CustomColor.mintForestTextColor,
                  ),
                  Icon(
                    Icons.qr_code_2_sharp,
                    size: 40,
                    color: CustomColor.mintForestTextColor,
                  ),
                  Icon(
                    Icons.add_card,
                    size: 30,
                    color: CustomColor.mintForestTextColor,
                  ),
                  Icon(
                    Icons.perm_identity_outlined,
                    size: 30,
                    color: CustomColor.mintForestTextColor,
                  ),
                ],
                onTap: (index) {
                  // Handle navigation to different screens based on the tapped index
                  setState(() {});

                  switch (index) {
                    case 0:
                      // Navigate to Home Screen
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyHomePage()));
                      break;
                    case 1:
                      // Navigate to Chat screen
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Calculator()));
                      break;
                    case 2:
                      // Navigate to QR scanner
                      //Navigator.push(context, MaterialPageRoute(builder: (context) => const ScannerPage()));
                      break;
                    case 3:
                      //Navigate to Add Notes screen
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NotesPage()));
                      break;
                    case 4:
                      // Navigate to Profile screen
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const OwnerProfile()));
                      break;
                  }
                },
              ),
              drawer: const MainDrawer(),
              body: SingleChildScrollView(
                child: Stack(children: [
                  Container(
                    height: 100,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        color: CustomColor.greenTextColor),
                  ), //1st green container
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    height: 130,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: CustomColor.greenTextColor1,
                        width: 0.5, // Border thickness
                      ),
                      borderRadius: const BorderRadius.all(
                          Radius.circular(11)), // Rounded corners
                      boxShadow: [
                        BoxShadow(
                          color:
                              CustomColor.mutedSageTextColor.withOpacity(0.5),
                          blurRadius: 8,
                          spreadRadius: 8,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                          Radius.circular(11)), // Apply same radius
                      child:
                          WeatherContainer(), // Ensures child respects the rounded corners
                    ),
                  ), // weather container above green container
                  SizedBox(
                    height: 270,
                  ),
                  Center(
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 180, horizontal: 28),
                      height: 240,
                      width: 300,
                      // Slightly increased width for better spacing
                      decoration: BoxDecoration(
                        color: CustomColor.mutedSageTextColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        border: Border.all(
                            color: CustomColor.silverTextColor, width: 1),
                        boxShadow: [
                          BoxShadow(
                            color: CustomColor.mintForestTextColor
                                .withOpacity(0.2),
                            blurRadius: 8,
                            spreadRadius: 4,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(5.0),
                            // More padding for spaciousness
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => FindFarmer(),
                                      ),
                                    );
                                  },
                                  child: _buildFeatureCard(
                                      FontAwesomeIcons.personDigging,
                                      "Find Farmer",
                                      CustomColor.greenTextColor,
                                      CustomColor.mintForestTextColor),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ShopCategories(),
                                      ),
                                    );
                                  },
                                  child: _buildFeatureCard(
                                      FontAwesomeIcons.store,
                                      "Buy & Sell",
                                      CustomColor.greenTextColor,
                                      CustomColor.mintForestTextColor),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 5, left: 5, bottom: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SocialMediaPage()));
                                  },
                                  child: Column(
                                    children: [
                                      _buildFeatureCard(
                                          FontAwesomeIcons.photoFilm,
                                          "Agri News",
                                          CustomColor.greenTextColor,
                                          CustomColor.mintForestTextColor),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AgriDetectionPage()));
                                  },
                                  child: Column(
                                    children: [
                                      _buildFeatureCard(
                                          FontAwesomeIcons.expand,
                                          "Agri Detection",
                                          CustomColor.greenTextColor,
                                          CustomColor.mintForestTextColor),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ), //4 main  FEATURES
                  FutureBuilder<List<Map<String, dynamic>>>(
                    future: _productsFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text("Error: ${snapshot.error}");
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Text("No products available");
                      } else {
                        return productSlider(context, snapshot.data!);
                      }
                    },
                  ),
                ]),
              ),
            )));
  }

  Widget _buildFeatureCard(
      IconData icon, String label, Color backgroundColor, Color borderColor) {
    return Container(
      height: 110,
      width: 140,
      decoration: BoxDecoration(
        // gradient: LinearGradient(
        //   colors: [backgroundColor, borderColor.withOpacity(1)],
        //   begin: Alignment.topLeft,
        //   end: Alignment.bottomRight,
        // ),
        color: CustomColor.greenTextColor2,
        border: Border.all(color: borderColor, width: 1.5),
        borderRadius: BorderRadius.all(Radius.circular(15)),
        boxShadow: [
          BoxShadow(
            color: Colors.white,
            blurRadius: 6,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 42, color: CustomColor.mintForestTextColor),
          SizedBox(height: 10),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: CustomColor.mintForestTextColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildProductCard(String imagePath, String productName, String price) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      // Symmetrical padding for uniform spacing
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: CustomColor.greenTextColor),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(11),
              child: Image.asset(
                imagePath,
                height: 100,
                width: 120,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    productName,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: CustomColor.greenTextColor,
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    // Space between price and button
                    children: [
                      Text(
                        price,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black54,
                        ),
                      ),
                      Container(
                        height: 40,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          color: CustomColor.greenTextColor,
                        ),
                        child: Center(
                          child: Text(
                            "BUY",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void openQRScanner(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: SizedBox(
            width: 300,
            height: 400,
            child: MobileScanner(
              onDetect: (BarcodeCapture capture) {
                final List<Barcode> barcodes = capture.barcodes;

                if (barcodes.isNotEmpty) {
                  final String? code = barcodes.first.rawValue;
                  Navigator.pop(context); // Close the scanner dialog
                  if (code != null) {
                    print('Scanned Code: $code'); // Handle the scanned QR code
                  } else {
                    print('Failed to retrieve the QR code value.');
                  }
                }
              },
            ),
          ),
        );
      },
    );
  }

  Widget productSlider(BuildContext context, _productsFuture) {
    PageController _pageController = PageController();
    int _currentPage = 0;

    List<Map<String, String>> products = [
      {
        'image': 'images/pic1.webp',
        'name': 'FIPROANT',
        'weight': '1 kg',
        'price': 'RS: 4999'
      },
      {
        'image': 'images/pic3.jpeg',
        'name': 'FERTILIZER',
        'weight': '500 10g',
        'price': 'RS: 12500'
      },
      {
        'image': 'images/pic2.webp',
        'name': 'WATER SOLUBLE',
        'weight': '2 kg',
        'price': 'RS: 1520'
      },
    ];

    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 440),
          height: 140,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (int index) {
              _currentPage = index;
            },
            itemCount: _productsFuture.length,
            itemBuilder: (context, index) {
              print("_productsFuture[ ] ${_productsFuture[index]}");
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 8),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: CustomColor.mutedSageTextColor1,
                  borderRadius: BorderRadius.circular(10),
                ),
                width: MediaQuery.of(context).size.width * 0.8,
                child: Row(
                  children: [
                    Image.network(
                      _productsFuture[index]['image']!,
                      width: 100,
                      height: 120,
                      fit: BoxFit.cover,
                         errorBuilder: (context, error, stackTrace) =>
                        Icon(Icons.broken_image, size: 120),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _productsFuture[index]['name']!,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white, // Custom text color
                            ),
                          ),
                          Text(
                            "Stock: ${_productsFuture[index]['stock'].toString()!}",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Rs. ${_productsFuture[index]['price'].toString()!}",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  // Handle Buy
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: CustomColor
                                      .greenTextColor, // Button color
                                ),
                                child: Text(
                                  ' Cart ',
                                  style: TextStyle(
                                      color: CustomColor.mintForestTextColor,
                                      fontSize: 16),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            products.length,
            (index) => AnimatedContainer(
              duration: Duration(milliseconds: 300),
              margin: EdgeInsets.symmetric(horizontal: 4),
              height: 8,
              width: _currentPage == index ? 20 : 8,
              decoration: BoxDecoration(
                color: _currentPage == index ? Colors.green : Colors.grey,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class WeatherContainer extends StatefulWidget {
  const WeatherContainer({super.key});

  @override
  State<WeatherContainer> createState() => _WeatherContainerState();
}

class _WeatherContainerState extends State<WeatherContainer> {
  final WeatherFactory _wf = WeatherFactory(OPENWEATHER_API_KEY);
  Weather? _weather;
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchWeather("Hyderabad");
  }

  Future<void> _fetchWeather(String cityName) async {
    setState(() {
      _isLoading = true;
    });
    try {
      Weather weather = await _wf.currentWeatherByCityName(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        child: Column(
          children: [
            // Search Bar
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 25,
                  width: 170,
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                        hintText: "Enter City Name",
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding: EdgeInsets.all(2)),
                    style: TextStyle(fontSize: 12),
                    onSubmitted: (query) {
                      if (query.isNotEmpty) {
                        _fetchWeather(query);
                      }
                    },
                  ),
                ),
                const SizedBox(width: 8),
                if (_isLoading)
                  const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
              ],
            ),
            //const SizedBox(height: 20),
            // Weather Details
            if (_weather != null)
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        '${_weather!.temperature?.celsius?.toStringAsFixed(0)}°C', // Temperature
                        style: const TextStyle(
                          fontSize: 40, // Font size for temperature
                          fontWeight: FontWeight.bold,
                          color: CustomColor.greenTextColor,
                        ),
                      ),
                      const Spacer(),
                      if (_weather != null && _weather!.weatherIcon != null)
                        Container(
                          height: 70, // Matches the temperature text size
                          width: 70, // Matches the height for a square icon
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            color: CustomColor.mutedSageTextColor1,
                            image: DecorationImage(
                              image: NetworkImage(
                                "http://openweathermap.org/img/wn/${_weather?.weatherIcon}@2x.png", // Ensure a valid icon size
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      else
                        const Icon(
                          Icons
                              .cloud_download, // Fallback icon if no weather icon is available
                          size: 30,
                          color: Colors.grey,
                        ),
                    ],
                  ),

                  //const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Wind: ${_weather!.windSpeed?.toStringAsFixed(0)} km/h',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Humidity: ${_weather!.humidity?.toStringAsFixed(0)}%',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        "${_weather!.areaName}",
                        style: const TextStyle(color: CustomColor.ashgrey),
                      ),
                      const Spacer(),
                    ],
                  ),
                ],
              )
            else if (!_isLoading)
              const Center(
                child: Text(
                  "No weather data available. Please search for a city.",
                  style: TextStyle(color: Colors.black54),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class ExitConfirmationDialog extends StatelessWidget {
  const ExitConfirmationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Exit App'),
      content: const Text('Are you sure you want to exit the app?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text('No'),
        ),
        TextButton(
          onPressed: () {
            // Close the dialog and exit the app
            Navigator.of(context).pop();
            SystemNavigator.pop();
          },
          child: const Text('Yes'),
        ),
      ],
    );
  }
}
