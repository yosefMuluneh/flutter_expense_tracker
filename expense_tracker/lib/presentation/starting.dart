import 'package:expense_tracker/charts.dart';
import 'package:expense_tracker/presentation/budget.dart';
import 'package:expense_tracker/presentation/home.dart';
import 'package:expense_tracker/presentation/profile.dart';
import 'package:flutter/material.dart';

class Starting extends StatefulWidget {
  const Starting({Key? key}) : super(key: key);

  @override
  _StartingState createState() => _StartingState();
}

class _StartingState extends State<Starting> {
  @override
  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;
  List<Widget> pages = [
    const Home(),
    const Budget(),
    const ChartPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        unselectedItemColor: Colors.black,
        iconSize: 28,
        onTap: (value) {
          setState(() {
            _page = value;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              child: const Icon(Icons.home_outlined),
            ),
            label: "Home",
          ),

          // service page
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              child: const Icon(Icons.medical_services),
            ),
            label: "Budgets",
          ),

          //appointment
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              child: const Icon(Icons.bar_chart_outlined),
            ),
            label: "Charts",
          ),

          // profile page
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              child: const Icon(Icons.person_outline),
            ),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
