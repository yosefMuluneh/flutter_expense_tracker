// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';

// class Statstics extends StatefulWidget {
//   const Statstics({Key? key}) : super(key: key);

//   @override
//   _StatsticsState createState() => _StatsticsState();
// }

// class _StatsticsState extends State<Statstics> {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }


// class BarChartWidget extends StatelessWidget {
//   final List expenses;
//   final double barWidth = 22;

//   const BarChartWidget({super.key, required this.expenses});

//   @override
//   Widget build(BuildContext context) => BarChart(
//         BarChartData(
//           alignment: BarChartAlignment.center,
//           maxY: 20,
//           minY: -20,
//           groupsSpace: 12,
//           barTouchData: BarTouchData(enabled: true),
//           titlesData: FlTitlesData(
//             topTitles: BarTitles.getTopBottomTitles(),
//             bottomTitles: BarTitles.getTopBottomTitles(),
//             leftTitles: BarTitles.getSideTitles(),
//             rightTitles: BarTitles.getSideTitles(),
//           ),
//           gridData: FlGridData(
//             checkToShowHorizontalLine: (value) => value % BarData.interval == 0,
//             getDrawingHorizontalLine: (value) {
//               if (value == 0) {
//                 return FlLine(
//                   color: const Color(0xff363753),
//                   strokeWidth: 3,
//                 );
//               } else {
//                 return FlLine(
//                   color: const Color(0xff2a2747),
//                   strokeWidth: 0.8,
//                 );
//               }
//             },
//           ),
//           barGroups: BarData.barData
//               .map(
//                 (data) => BarChartGroupData(
//                   x: data.id,
//                   barRods: [
//                     BarChartRodData(
//                       y: data.y,
//                       width: barWidth,
//                       colors: [data.color],
//                       borderRadius: data.y > 0
//                           ? BorderRadius.only(
//                               topLeft: Radius.circular(6),
//                               topRight: Radius.circular(6),
//                             )
//                           : BorderRadius.only(
//                               bottomLeft: Radius.circular(6),
//                               bottomRight: Radius.circular(6),
//                             ),
//                     ),
//                   ],
//                 ),
//               )
//               .toList(),
//         ),
//       );
// }





// class BarTitles {
//   static SideTitles getTopBottomTitles() => SideTitles(
//         showTitles: true,
//         getTextStyles: (value) =>
//             const TextStyle(color: Colors.white, fontSize: 10),
//         margin: 10,
//         getTitles: (double id) => BarData.barData
//             .firstWhere((element) => element.id == id.toInt())
//             .name,
//       );

//   static SideTitles getSideTitles() => SideTitles(
//         showTitles: true,
//         getTextStyles: (value) =>
//             const TextStyle(color: Colors.white, fontSize: 10),
//         rotateAngle: 90,
//         interval: BarData.interval.toDouble(),
//         margin: 10,
//         reservedSize: 30,
//         getTitles: (double value) => value == 0 ? '0' : '${value.toInt()}k',
//       );
// }