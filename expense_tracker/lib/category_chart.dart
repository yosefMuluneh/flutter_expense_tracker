import 'package:expense_tracker/application/expense_bloc/expense_bloc.dart';
import 'package:expense_tracker/get_sections_chart.dart';
import 'package:expense_tracker/utils.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class PieChartCategory extends StatefulWidget {
  const PieChartCategory({super.key});

  @override
  State<PieChartCategory> createState() => _PieChartCategoryState();
}

class _PieChartCategoryState extends State<PieChartCategory> {
  int currDay = 0;
  int currMonth = 0;
  int currYear = 0;
  Map expense = {};
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ExpenseBloc, ExpenseState>(listener: (context, state) {
      if (state is ExpenseLoaded) {
        expense = state.expenses;
      }
    }, builder: (context, state) {
      if (state is ExpenseLoaded) {
        expense = state.expenses;

        return Chartscategory(expense);
      } else if (state is ExpenseInitial) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return const Center(
          child: Text("Error While graphing"),
        );
      }

      ;
    });
  }

  SingleChildScrollView Chartscategory(Map expense) {
    return SingleChildScrollView(
      child: Column(
        children: [
          expense["groupByDay"].isEmpty
              ? Container()
              : Column(
                  children: [
                    const Text(
                      "Daily Expenses",
                      style: TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          onPressed: () {
                            if (currDay < expense["groupByDay"].length - 1) {
                              setState(() {
                                currDay++;
                              });
                            }
                          },
                          icon: const Icon(Icons.chevron_left),
                          iconSize: currDay < expense["groupByDay"].length - 1
                              ? 30
                              : 24,
                          color: currDay < expense["groupByDay"].length - 1
                              ? Colors.purple
                              : Colors.purple[200],
                        ),
                        const SizedBox(
                          width: 50,
                        ),
                        Text(
                          formatDate(expense["groupByDay"][currDay]?[0]),
                          style: const TextStyle(
                            color: Colors.purple,
                            fontWeight: FontWeight.w400,
                            fontSize: 24,
                          ),
                        ),
                        const SizedBox(
                          width: 50,
                        ),
                        IconButton(
                          onPressed: () {
                            if (currDay > 0) {
                              setState(() {
                                currDay--;
                              });
                            }
                          },
                          icon: Icon(
                            Icons.chevron_right,
                            color: currDay > 0
                                ? Colors.purple
                                : Colors.purple[200],
                          ),
                          iconSize: currDay > 0 ? 30 : 24,
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 200,
                            width: 200,
                            child: PieChart(
                              PieChartData(
                                sections:
                                    getSections(currDay, "groupByDay", expense),
                                centerSpaceRadius: 0,
                                sectionsSpace: 0,
                              ),
                            ),
                          ),
                          SizedBox(
                              height: 200,
                              width: 130,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:
                                    columnWidg(expense["groupByDay"][currDay]),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
          const SizedBox(
            height: 40,
          ),
          expense["groupByMonth"].isEmpty
              ? Container()
              : Column(
                  children: [
                    const Text(
                      "Monthly Expenses",
                      style: TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          onPressed: () {
                            if (currMonth <
                                expense["groupByMonth"].length - 1) {
                              setState(() {
                                currMonth++;
                              });
                            }
                          },
                          icon: const Icon(Icons.chevron_left),
                          iconSize:
                              currMonth < expense["groupByMonth"].length - 1
                                  ? 30
                                  : 24,
                          color: currMonth < expense["groupByMonth"].length - 1
                              ? Colors.purple
                              : Colors.purple[200],
                        ),
                        const SizedBox(
                          width: 50,
                        ),
                        Text(
                          formatMonth(expense["groupByMonth"][currMonth][0]),
                          style: const TextStyle(
                            color: Colors.purple,
                            fontSize: 24,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(
                          width: 50,
                        ),
                        IconButton(
                          onPressed: () {
                            if (currMonth > 0) {
                              setState(() {
                                currMonth--;
                              });
                            }
                          },
                          icon: const Icon(Icons.chevron_right),
                          color: currMonth > 0
                              ? Colors.purple
                              : Colors.purple[200],
                          iconSize: currMonth > 0 ? 30 : 24,
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 200,
                            width: 200,
                            child: PieChart(
                              PieChartData(
                                sections: getSections(
                                    currMonth, "groupByMonth", expense),
                                centerSpaceRadius: 0,
                                sectionsSpace: 0,
                              ),
                            ),
                          ),
                          SizedBox(
                              height: 200,
                              width: 130,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: columnWidg(
                                    expense["groupByMonth"][currMonth]),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
          const SizedBox(
            height: 40,
          ),
          expense["groupByYear"].isEmpty
              ? Container()
              : Column(
                  children: [
                    const Text(
                      "Annual Expenses",
                      style: TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          onPressed: () {
                            if (currYear < expense["groupByYear"].length - 1) {
                              setState(() {
                                currYear++;
                              });
                            }
                          },
                          icon: const Icon(Icons.chevron_left),
                          color: currYear < expense["groupByYear"].length - 1
                              ? Colors.purple
                              : Colors.purple[200],
                          iconSize: currYear < expense["groupByYear"].length - 1
                              ? 30
                              : 24,
                        ),
                        const SizedBox(
                          width: 50,
                        ),
                        Text(
                          formatYear(expense["groupByYear"][currYear][0]),
                          style: const TextStyle(
                            color: Colors.purple,
                            fontSize: 24,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(
                          width: 50,
                        ),
                        IconButton(
                          onPressed: () {
                            if (currYear > 0) {
                              setState(() {
                                currYear--;
                              });
                            }
                          },
                          icon: const Icon(Icons.chevron_right),
                          color:
                              currYear > 0 ? Colors.purple : Colors.purple[200],
                          iconSize: currYear > 0 ? 30 : 24,
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 200,
                            width: 200,
                            child: PieChart(
                              PieChartData(
                                sections: getSections(
                                    currYear, "groupByYear", expense),
                                centerSpaceRadius: 0,
                                sectionsSpace: 0,
                              ),
                            ),
                          ),
                          SizedBox(
                              height: 200,
                              width: 130,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: columnWidg(
                                    expense["groupByYear"][currYear]),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  String formatDate(DateTime date) {
    String formattedDate = DateFormat('MMMM d, y').format(date);

    return formattedDate;
  }

  String formatMonth(DateTime date) {
    String formattedDate = DateFormat('MMMM y').format(date);

    return formattedDate;
  }

  String formatYear(DateTime date) {
    String formattedDate = DateFormat('y').format(date);
    return formattedDate;
  }

  List<Widget> columnWidg(List expenses) {
    List<String> categ = [];
    List<Widget> columnWidgets = [];
    for (var expe in expenses[3]) {
      if (!categ.contains(expe.category) && expe.type == "expense") {
        categ.add(expe.category);
        columnWidgets.add(Row(
          children: [
            Container(
              width: 15,
              height: 15,
              color: catagory[expe.category.toLowerCase()],
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              expe.category,
              style: TextStyle(
                color: catagory[expe.category.toLowerCase()],
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ));
      }
    }
    return columnWidgets;
  }
}
