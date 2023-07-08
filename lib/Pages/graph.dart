import 'package:app/Modules/globalfunctions.dart';
import 'package:app/Modules/solver.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Graphs extends StatefulWidget {
  const Graphs({super.key});

  @override
  State<Graphs> createState() => _GraphsState();
}

class _GraphsState extends State<Graphs> {
  List<SalesData> chartData = [];

  @override
  void initState() {
    for (double i = -10; i < 10; i += 0.1) {
      Solver solver = Solver();
      List<String> translation = solver.translate("${roundto(i.toString())}^2");
      print(translation);
      chartData.add(SalesData(
          roundto(i.toString()), solver.solve(translation, "Degree")));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor:
            (MediaQuery.of(context).platformBrightness == Brightness.light)
                ? Colors.black
                : Colors.white,
        title: Text("Graphs"),
        elevation: 0,
      ),
      body: SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        series: <ChartSeries>[
          // Renders line chart
          LineSeries<SalesData, String>(
            dataSource: chartData,
            xValueMapper: (SalesData sales, _) => sales.year,
            yValueMapper: (SalesData sales, _) => sales.sales,
          )
        ],
      ),
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
