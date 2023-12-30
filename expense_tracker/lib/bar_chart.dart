import 'package:expense_tracker/application/expense_bloc/expense_bloc.dart';
import 'package:expense_tracker/bar_chart_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class BarChartPage extends StatefulWidget {
  BarChartPage({
    super.key,
  });

  @override
  State<BarChartPage> createState() => _BarChartPageState();
}

class _BarChartPageState extends State<BarChartPage> {
  List dailyExp = [];
  List monthlyExp = [];
  List annualExp = [];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ExpenseBloc, ExpenseState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is ExpenseLoaded) {
            dailyExp = state.expenses["groupByDay"];
            monthlyExp = state.expenses["groupByMonth"];
            annualExp = state.expenses["groupByYear"];
            BarData dailyBar = BarData(expense: dailyExp);
            BarData monthBar = BarData(expense: monthlyExp);
            BarData annualBar = BarData(expense: annualExp);
            dailyBar.initializeData();
            monthBar.initializeData();
            annualBar.initializeData();
            return SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Daily Expense report",
                          style: TextStyle(
                            color: Colors.deepPurple,
                            fontSize: 24,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 15,
                                  width: 15,
                                  color: Colors.red,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text("Expense")
                              ],
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 15,
                                  width: 15,
                                  color: Colors.green,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text("Income")
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: SizedBox(
                            height: 300,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Container(
                                width: dailyExp.length * 70 > 300
                                    ? dailyExp.length * 70
                                    : 300,
                                padding: const EdgeInsets.all(20),
                                height: 400,
                                child: BarChart(
                                  BarChartData(
                                      borderData: FlBorderData(show: false),
                                      gridData: const FlGridData(show: false),
                                      groupsSpace: 80,
                                      titlesData: FlTitlesData(
                                        rightTitles: const AxisTitles(
                                          sideTitles:
                                              SideTitles(showTitles: false),
                                        ),
                                        topTitles: const AxisTitles(
                                          sideTitles:
                                              SideTitles(showTitles: false),
                                        ),
                                        bottomTitles: AxisTitles(
                                          sideTitles: SideTitles(
                                            showTitles: true,
                                            getTitlesWidget:
                                                (double value, TitleMeta meta) {
                                              const style = TextStyle(
                                                color: Colors.purple,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              );
                                              Widget text;
                                              text = Text(
                                                formatDate(
                                                    dailyExp[value.toInt()][0]),
                                                style: style,
                                              );

                                              return SideTitleWidget(
                                                angle: -45.0,
                                                fitInside:
                                                    const SideTitleFitInsideData(
                                                        enabled: true,
                                                        axisPosition: 10,
                                                        parentAxisSize: 5,
                                                        distanceFromEdge: -15),
                                                axisSide: meta.axisSide,
                                                child: text,
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      barGroups: dailyBar.barData
                                          .map(
                                            (data) => BarChartGroupData(
                                                x: data.x,
                                                barRods: [
                                                  BarChartRodData(
                                                    toY: data.y,
                                                    color: Colors.red,
                                                    width: 15,
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    3),
                                                            topRight:
                                                                Radius.circular(
                                                                    3)),
                                                  ),
                                                  BarChartRodData(
                                                    backDrawRodData:
                                                        BackgroundBarChartRodData(
                                                            color:
                                                                Colors.black),
                                                    toY: data.z,
                                                    color: Colors.green,
                                                    width: 15,
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    3),
                                                            topRight:
                                                                Radius.circular(
                                                                    3)),
                                                  ),
                                                ]),
                                          )
                                          .toList()),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Column(
                      children: [
                        const Text(
                          "Monthly Expense report",
                          style: TextStyle(
                            color: Colors.deepPurple,
                            fontSize: 24,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 15,
                                  width: 15,
                                  color: Colors.red,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text("Expense")
                              ],
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 15,
                                  width: 15,
                                  color: Colors.green,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text("Income")
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: SizedBox(
                            height: 300,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Container(
                                width: monthlyExp.length * 70 > 300
                                    ? monthlyExp.length * 70
                                    : 300,
                                child: BarChart(
                                  BarChartData(
                                      borderData: FlBorderData(show: false),
                                      gridData: const FlGridData(show: false),
                                      groupsSpace: 50,
                                      titlesData: FlTitlesData(
                                          rightTitles: const AxisTitles(
                                            sideTitles:
                                                SideTitles(showTitles: false),
                                          ),
                                          topTitles: const AxisTitles(
                                            sideTitles:
                                                SideTitles(showTitles: false),
                                          ),
                                          bottomTitles: AxisTitles(
                                            sideTitles: SideTitles(
                                              showTitles: true,
                                              getTitlesWidget: (double value,
                                                  TitleMeta meta) {
                                                const style = TextStyle(
                                                  color: Colors.purple,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                );
                                                Widget text;
                                                text = Text(
                                                  formatMonth(
                                                      monthlyExp[value.toInt()]
                                                          [0]),
                                                  style: style,
                                                );

                                                return SideTitleWidget(
                                                  axisSide: meta.axisSide,
                                                  child: text,
                                                );
                                              },
                                            ),
                                          )),
                                      barGroups: monthBar.barData
                                          .map(
                                            (data) => BarChartGroupData(
                                                x: data.x,
                                                barRods: [
                                                  BarChartRodData(
                                                    toY: data.y,
                                                    color: Colors.red,
                                                    width: 15,
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    3),
                                                            topRight:
                                                                Radius.circular(
                                                                    3)),
                                                  ),
                                                  BarChartRodData(
                                                    backDrawRodData:
                                                        BackgroundBarChartRodData(
                                                            color:
                                                                Colors.black),
                                                    toY: data.z,
                                                    color: Colors.green,
                                                    width: 15,
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    3),
                                                            topRight:
                                                                Radius.circular(
                                                                    3)),
                                                  ),
                                                ]),
                                          )
                                          .toList()),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Column(
                      children: [
                        const Text(
                          "Annual Expense report",
                          style: TextStyle(
                            color: Colors.deepPurple,
                            fontSize: 24,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 15,
                                  width: 15,
                                  color: Colors.red,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text("Expense")
                              ],
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 15,
                                  width: 15,
                                  color: Colors.green,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text("Income")
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: SizedBox(
                            height: 300,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Container(
                                width: annualExp.length * 70 > 300
                                    ? annualExp.length * 70
                                    : 300,
                                padding: const EdgeInsets.all(20),
                                child: BarChart(
                                  BarChartData(
                                      borderData: FlBorderData(show: false),
                                      gridData: const FlGridData(show: false),
                                      groupsSpace: 50,
                                      titlesData: FlTitlesData(
                                        rightTitles: const AxisTitles(
                                          sideTitles:
                                              SideTitles(showTitles: false),
                                        ),
                                        topTitles: const AxisTitles(
                                          sideTitles:
                                              SideTitles(showTitles: false),
                                        ),
                                        bottomTitles: AxisTitles(
                                          sideTitles: SideTitles(
                                            showTitles: true,
                                            getTitlesWidget:
                                                (double value, TitleMeta meta) {
                                              const style = TextStyle(
                                                color: Colors.purple,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              );
                                              Widget text;
                                              text = Text(
                                                formatYear(
                                                    annualExp[value.toInt()]
                                                        [0]),
                                                style: style,
                                              );

                                              return SideTitleWidget(
                                                fitInside:
                                                    const SideTitleFitInsideData(
                                                        enabled: true,
                                                        axisPosition: 10,
                                                        parentAxisSize: 5,
                                                        distanceFromEdge: -15),
                                                axisSide: meta.axisSide,
                                                child: text,
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      barGroups: annualBar.barData
                                          .map(
                                            (data) => BarChartGroupData(
                                                x: data.x,
                                                barRods: [
                                                  BarChartRodData(
                                                    toY: data.y,
                                                    color: Colors.red,
                                                    width: 15,
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    3),
                                                            topRight:
                                                                Radius.circular(
                                                                    3)),
                                                  ),
                                                  BarChartRodData(
                                                    backDrawRodData:
                                                        BackgroundBarChartRodData(
                                                            color:
                                                                Colors.black),
                                                    toY: data.z,
                                                    color: Colors.green,
                                                    width: 15,
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    3),
                                                            topRight:
                                                                Radius.circular(
                                                                    3)),
                                                  ),
                                                ]),
                                          )
                                          .toList()),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ]),
            );
          } else {
            return Container(
              child: Text("no expenses yet"),
            );
          }
        });
  }

  Widget getDailyBottomTiles(List dailyExp, double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.purple,
      fontSize: 18,
    );
    Widget text;
    text = Text(
      formatDate(dailyExp[int.parse(value as String)][0]),
      style: style,
    );

    return SideTitleWidget(axisSide: meta.axisSide, child: text);
  }

  String formatDate(DateTime date) {
    String formattedDate = DateFormat('MMM d').format(date);

    return formattedDate;
  }

  String formatMonth(DateTime date) {
    String formattedDate = DateFormat('MMMM').format(date);

    return formattedDate;
  }

  String formatYear(DateTime date) {
    print("======annual exp====$annualExp");
    String formattedDate = DateFormat('y').format(date);
    print("======annual exp====$formattedDate");
    return formattedDate;
  }
}
