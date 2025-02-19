import 'package:agri_connect/custom.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'home_screen.dart';
import 'ownerProfile.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  final GlobalKey<CurvedNavigationBarState> _bottomNavKey = GlobalKey();
  var userInput = "";
  var answer = "0";

  final Color color1 = const Color(0xFF072F01);
  final Color color2 = const Color(0xFF072F01);
  final Color bColorBlue = const Color(0xFF1A5013);
  final Color bColorGray = const Color(0xFF1A5013);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: CustomColor.greenTextColor,
        title: const Text(
          "CALCULATOR",
          style: TextStyle(fontSize: 40, color: Colors.white),
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavKey,
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
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyHomePage()),
              );
              break;
            case 4:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const OwnerProfile()),
              );
              break;
            default:
              break;
          }
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: CustomColor.greenTextColor,
                      width: 2,
                    ),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        userInput,
                        style: const TextStyle(fontSize: 30, color: Colors.black),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        answer,
                        style: const TextStyle(fontSize: 45, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    _buildButtonRow(["AC", "^", "%", "/"], [bColorGray, bColorGray, bColorGray, bColorBlue]),
                    _buildButtonRow(["7", "8", "9", "x"], [null, null, null, bColorBlue]),
                    _buildButtonRow(["4", "5", "6", "-"], [null, null, null, bColorBlue]),
                    _buildButtonRow(["1", "2", "3", "+"], [null, null, null, bColorBlue]),
                    _buildButtonRow(["DEL", "0", ".", "="], [bColorGray, null, null, bColorBlue]),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButtonRow(List<String> titles, List<Color?> buttonColors) {
    return Row(
      children: titles.asMap().entries.map((entry) {
        int idx = entry.key;
        String title = entry.value;

        return MyButton(
          title: title,
          onPress: () {
            _handleButtonPress(title);
          },
          bColor: buttonColors[idx] ?? const Color(0xFFE7C206),
          color: title == "=" ? bColorBlue : color1,
        );
      }).toList(),
    );
  }

  void _handleButtonPress(String value) {
    setState(() {
      switch (value) {
        case "AC":
          userInput = "";
          answer = "0";
          break;
        case "DEL":
          if (userInput.isNotEmpty) {
            userInput = userInput.substring(0, userInput.length - 1);
          }
          break;
        case "=":
          _calculateResult();
          break;
        default:
          userInput += value == "x" ? "*" : value;
          break;
      }
    });
  }

  void _calculateResult() {
    try {
      Parser p = Parser();
      Expression exp = p.parse(userInput);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      answer = eval.toString();
    } catch (e) {
      answer = "Error";
    }
  }
}

class MyButton extends StatelessWidget {
  final String title;
  final Color color;
  final Color bColor;
  final Color tColor;
  final VoidCallback onPress;

  const MyButton({
    super.key,
    required this.title,
    required this.onPress,
    this.bColor = const Color(0xFFE7C206),
    this.tColor = const Color(0xFF1A5013),
    this.color = const Color(0xFF1A5013),
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: InkWell(
          onTap: onPress,
          child: Container(
            height: 55,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: CustomColor.greenTextColor1.withOpacity(0.5),
                  blurRadius: 6,
                  spreadRadius: 3,
                ),
              ],
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: bColor, width: 1, style: BorderStyle.solid),
              color: color,
            ),
            child: Center(
              child: Text(
                title,
                style: const TextStyle(fontSize: 25, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
