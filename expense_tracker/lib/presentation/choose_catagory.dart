import 'package:expense_tracker/utils.dart';
import 'package:flutter/material.dart';

class CategoryList extends StatefulWidget {
  final Function(String, String) onCategorySelected;
  const CategoryList({super.key, required this.onCategorySelected});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  final List<String> incomeCat = [
    'Salary',
    'Gifts',
    'Grants',
    'Sale',
    'Awards',
    'Coupons',
    'Other',
  ];

  final List<String> expenseCat = [
    'Food',
    'Clothing',
    'Fruits',
    'Shopping',
    'Transportation',
    'Home',
    'Travel',
    'Entertainment',
    'Health',
    'Education',
    'Gifts',
    "Sport",
    "Electronics",
    'Other',
  ];

  void _handleCategoryTap(BuildContext context, String category, String type) {
    widget.onCategorySelected(category, type);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Choose category",
            style: TextStyle(fontSize: 18),
          ),
          automaticallyImplyLeading: false,
          bottom: const TabBar(tabs: [
            Tab(
              text: "Expense",
            ),
            Tab(
              text: "Income",
            ),
          ]),
        ),
        body: TabBarView(children: [
          ListView.builder(
            itemCount: expenseCat.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(6),
                child: GestureDetector(
                  onTap: () =>
                      _handleCategoryTap(context, expenseCat[index], "expense"),
                  child: Row(
                    children: [
                      catagory[expenseCat[index]],
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        expenseCat[index],
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 15),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          ListView.builder(
            itemCount: incomeCat.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(6.0),
                child: GestureDetector(
                  onTap: () {
                    _handleCategoryTap(context, incomeCat[index], "income");
                  },
                  child: Row(
                    children: [
                      catagory[incomeCat[index]],
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        incomeCat[index],
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 15),
                      ),
                    ],
                  ),
                ),
              );
            },
          )
        ]),
      ),
    );
  }
}
