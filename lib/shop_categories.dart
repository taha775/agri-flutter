import 'package:agri_connect/create_shop.dart';
import 'package:agri_connect/shop_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'custom.dart';

class ShopCategories extends StatefulWidget {
  const ShopCategories({super.key});

  @override
  State<ShopCategories> createState() => _ShopCategoriesState();
}

class _ShopCategoriesState extends State<ShopCategories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: CustomColor.greenTextColor,
        title: Text(
          "Categories",
          style: TextStyle(color: Colors.white, fontSize: 23),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 11,
          ),
          Text(
            "* Please select, What are you looking for?",
            style: TextStyle(fontSize: 13),
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreateShop()));
                    },
                    child: Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: CustomColor.mintForestTextColor,
                        border: Border.all(
                            color: CustomColor.greenTextColor, width: 2),
                      ),
                      child: Center(
                        child: Icon(FontAwesomeIcons.store,
                            color: CustomColor.greenTextColor, size: 50),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Create Shop",
                    style: TextStyle(
                        fontSize: 18, color: CustomColor.greenTextColor),
                  )
                ],
              ),
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AgricultureShopPage(),
                        ),
                      );
                    },
                    child: Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: CustomColor.mintForestTextColor,
                        border: Border.all(
                            color: CustomColor.greenTextColor, width: 2),
                      ),
                      child: Center(
                        child: Icon(FontAwesomeIcons.cartPlus,
                            color: CustomColor.greenTextColor, size: 50),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Buy Products",
                    style: TextStyle(
                        fontSize: 18, color: CustomColor.greenTextColor),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
