import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// String uri = 'http://192.168.187.111:3000';
// String uri = 'http://10.4.96.92:3000';
String uri = 'http://192.168.43.111:3000';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
      duration: const Duration(seconds: 2),
    ),
  );
}

class ErrorScreen extends StatelessWidget {
  final Exception? error;
  const ErrorScreen({super.key, this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Error"),
      ),
      body: const Center(
        child: Text("Page not found"),
      ),
    );
  }
}

final Map<String, dynamic> catagory = {
  "Salary": Container(
    padding: const EdgeInsets.all(8),
    decoration: const BoxDecoration(
      color: Colors.green,
      shape: BoxShape.circle,
    ),
    child: const Icon(Icons.money_off_csred_outlined, color: Colors.white),
  ),
  "salary": Colors.green,
  "Food": Container(
    padding: const EdgeInsets.all(8),
    decoration: const BoxDecoration(
      color: Colors.amber,
      shape: BoxShape.circle,
    ),
    child: const Icon(Icons.food_bank, color: Colors.white),
  ),
  "food": Colors.amber,
  "Clothing": Container(
    padding: const EdgeInsets.all(8),
    decoration: const BoxDecoration(
      color: Colors.green,
      shape: BoxShape.circle,
    ),
    child: const FaIcon(FontAwesomeIcons.tshirt, color: Colors.white),
  ),
  "clothing": Colors.green,
  "Fruits": Container(
    padding: const EdgeInsets.all(8),
    decoration: const BoxDecoration(
      color: Colors.orange,
      shape: BoxShape.circle,
    ),
    child: const Icon(Icons.apple, color: Colors.white),
  ),
  "fruits": Colors.orange,
  "Shopping": Container(
    padding: const EdgeInsets.all(8),
    decoration: const BoxDecoration(
      color: Colors.red,
      shape: BoxShape.circle,
    ),
    child: const FaIcon(FontAwesomeIcons.shoppingBag, color: Colors.white),
  ),
  "shopping": Colors.red,
  "Transportation": Container(
    padding: const EdgeInsets.all(8),
    decoration: const BoxDecoration(
      color: Colors.purple,
      shape: BoxShape.circle,
    ),
    child: const FaIcon(FontAwesomeIcons.bus, color: Colors.white),
  ),
  "transportation": Colors.purple,
  "Home": Container(
    padding: const EdgeInsets.all(8),
    decoration: const BoxDecoration(
      color: Colors.teal,
      shape: BoxShape.circle,
    ),
    child: const FaIcon(FontAwesomeIcons.home, color: Colors.white),
  ),
  "Travel": Container(
    padding: const EdgeInsets.all(8),
    decoration: const BoxDecoration(
      color: Colors.brown,
      shape: BoxShape.circle,
    ),
    child: const FaIcon(FontAwesomeIcons.plane, color: Colors.white),
  ),
  "travel": Colors.brown,
  "Entertainment": Container(
    padding: const EdgeInsets.all(8),
    decoration: const BoxDecoration(
      color: Colors.pink,
      shape: BoxShape.circle,
    ),
    child: const FaIcon(FontAwesomeIcons.gamepad, color: Colors.white),
  ),
  "entertainment": Colors.pink,
  "Health": Container(
    padding: const EdgeInsets.all(8),
    decoration: const BoxDecoration(
      color: Colors.deepPurple,
      shape: BoxShape.circle,
    ),
    child: const FaIcon(FontAwesomeIcons.heartbeat, color: Colors.white),
  ),
  "health": Colors.deepPurple,
  "Education": Container(
    padding: const EdgeInsets.all(8),
    decoration: const BoxDecoration(
      color: Colors.deepOrange,
      shape: BoxShape.circle,
    ),
    child: const FaIcon(FontAwesomeIcons.graduationCap, color: Colors.white),
  ),
  "education": Colors.deepOrange,
  "Gifts": Container(
    padding: const EdgeInsets.all(8),
    decoration: const BoxDecoration(
      color: Colors.indigo,
      shape: BoxShape.circle,
    ),
    child: const FaIcon(FontAwesomeIcons.gift, color: Colors.white),
  ),
  "gifts": Colors.indigo,
  "Other": Container(
    padding: const EdgeInsets.all(8),
    decoration: const BoxDecoration(
      color: Colors.grey,
      shape: BoxShape.circle,
    ),
    child: const FaIcon(FontAwesomeIcons.question, color: Colors.white),
  ),
  "Grants": Container(
    padding: const EdgeInsets.all(8),
    decoration: const BoxDecoration(
      color: Colors.pink,
      shape: BoxShape.circle,
    ),
    child: const FaIcon(FontAwesomeIcons.gifts, color: Colors.white),
  ),
  "Sale": Container(
    padding: const EdgeInsets.all(8),
    decoration: const BoxDecoration(
      color: Colors.purple,
      shape: BoxShape.circle,
    ),
    child: const FaIcon(FontAwesomeIcons.salesforce, color: Colors.white),
  ),
  "Awards": Container(
    padding: const EdgeInsets.all(8),
    decoration: const BoxDecoration(
      color: Colors.deepPurple,
      shape: BoxShape.circle,
    ),
    child: const FaIcon(FontAwesomeIcons.award, color: Colors.white),
  ),
  "Coupons": Container(
    padding: const EdgeInsets.all(8),
    decoration: const BoxDecoration(
      color: Colors.red,
      shape: BoxShape.circle,
    ),
    child: const FaIcon(FontAwesomeIcons.certificate, color: Colors.white),
  ),
  "Telephone": Container(
    padding: const EdgeInsets.all(8),
    decoration: const BoxDecoration(
      color: Colors.indigo,
      shape: BoxShape.circle,
    ),
    child: const FaIcon(FontAwesomeIcons.phone, color: Colors.white),
  ),
  "Sport": Container(
    padding: const EdgeInsets.all(8),
    decoration: const BoxDecoration(
      color: Colors.grey,
      shape: BoxShape.circle,
    ),
    child: const Icon(Icons.sports, color: Colors.white),
  ),
  "Electronics": Container(
    padding: const EdgeInsets.all(8),
    decoration: const BoxDecoration(
      color: Colors.grey,
      shape: BoxShape.circle,
    ),
    child: const FaIcon(FontAwesomeIcons.carBattery, color: Colors.white),
  ),
};
