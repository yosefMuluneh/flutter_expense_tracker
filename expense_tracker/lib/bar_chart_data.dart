import 'package:expense_tracker/individual_bar.dart';
import 'package:fl_chart/fl_chart.dart';

class BarData {
  List expense;
  BarData({
    required this.expense,
  });
  List<BarChartGroupData> getBarData() {
    List<BarChartGroupData> values = [];

    return values;
  }

  List<IndividualBar> barData = [];
  void initializeData() {
    int initial = 0;
    for (var givenDay in expense) {
      print("################## ${givenDay}");
      barData.add(
        IndividualBar(
            x: initial,
            y: double.parse(givenDay[1].toString()),
            z: double.parse(givenDay[2].toString())),
      );
      initial++;
      print("------###########----$barData");
    }
  }
}
