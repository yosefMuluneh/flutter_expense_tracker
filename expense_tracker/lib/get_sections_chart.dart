import 'package:expense_tracker/utils.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../expense.dto.dart';

// final expense = {
//   "groupByDay": [
//     [
//       x,
//       120,
//       100,
//       [dummy, dummy1, dummy2, dummy4]
//     ],
//     [
//       x,
//       120,
//       100,
//       [dummy, dummy, dummy]
//     ],
//     [
//       x,
//       120,
//       100,
//       [dummy, dummy, dummy]
//     ],
//     [
//       x,
//       120,
//       100,
//       [dummy, dummy, dummy]
//     ],
//     [
//       x,
//       120,
//       100,
//       [dummy, dummy, dummy]
//     ],
//     [
//       x,
//       120,
//       100,
//       [dummy, dummy, dummy]
//     ],
//   ],
// };
// print(expense)
Map sectioning(expense) {
  Map sections = {"total": 0};

  for (ExpenseDto exp in expense[3]) {
    print("the length is---------------${expense[3].length}");
    if (exp.type == "expense") {
      if (sections.containsKey(exp.category)) {
        sections[exp.category] += exp.amount;
      } else {
        sections[exp.category] = exp.amount;
      }
      sections["total"] += exp.amount;
    }
  }
  return sections;
}

List<PieChartSectionData> getSections(int index, String cadence, Map expense) {
  print("---------the index------$index");
  Map sections = sectioning(expense[cadence]?[index]);

  List<PieChartSectionData> value = [];

  double total = double.parse(sections.remove("total").toString());
  for (MapEntry<dynamic, dynamic> entry in sections.entries) {
    print(entry.value);
    value.add(PieChartSectionData(
        title: "${(entry.value / total * 100).toInt()}%",
        value: entry.value,
        color: catagory[entry.key.toLowerCase()],
        radius: 100,
        titleStyle: const TextStyle(
          color: Colors.white,
        )));
  }
  return value;
}
