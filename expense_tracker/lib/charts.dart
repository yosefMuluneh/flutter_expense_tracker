import 'package:expense_tracker/bar_chart.dart';
import 'package:expense_tracker/category_chart.dart';
import 'package:flutter/material.dart';

class ChartPage extends StatefulWidget {
  const ChartPage({Key? key}) : super(key: key);

  @override
  State<ChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Expense Tracker",
          ),
          bottom: const TabBar(tabs: [
            Tab(
              text: "categories",
            ),
            Tab(
              text: "statistics",
            ),
          ]),
        ),
        body: TabBarView(children: [
          const PieChartCategory(),
          BarChartPage(),
        ]),
      ),
    );
  }
}
