// ignore_for_file: empty_catches

import 'package:app/Modules/globalfunctions.dart';
import 'package:app/Modules/input_field.dart';
import 'package:app/Modules/solver.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Graphs extends StatefulWidget {
  const Graphs({super.key});

  @override
  State<Graphs> createState() => _GraphsState();
}

class _GraphsState extends State<Graphs> {
  List<GraphValue> chartData = [];
  TextEditingController xMin = TextEditingController(text: "0"),
      yMin = TextEditingController(text: "0"),
      xMax = TextEditingController(text: "0"),
      yMax = TextEditingController(text: "0");

  void solve(equation) {
    chartData = [];
    try {
      for (double i = -10; i < 10; i += 0.1) {
        Solver solver = Solver();
        List<String> translation =
            solver.translate(equation.replaceAll("x", roundto(i.toString())));
        chartData.add(GraphValue(
            roundto(i.toString()), solver.solve(translation, "Degree")));
      }
      setState(() {});
    } catch (e) {}
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
        title: const Text("Graphs"),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: SfCartesianChart(
              primaryXAxis: CategoryAxis(
                maximum: double.parse(xMax.text),
                minimum: double.parse(xMin.text),
              ),
              primaryYAxis: CategoryAxis(
                maximum: double.parse(yMax.text),
                minimum: double.parse(yMin.text),
              ),
              series: <ChartSeries>[
                // Renders line chart
                LineSeries<GraphValue, String>(
                  dataSource: chartData,
                  xValueMapper: (GraphValue sales, _) => sales.x,
                  yValueMapper: (GraphValue sales, _) => sales.y,
                )
              ],
            ),
          ),
          Inputfield(
            onChanged: (value) => solve(value),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: Inputfield(
                  hintText: "X Min",
                  controller: xMin,
                ),
              ),
              Expanded(
                  child: Inputfield(
                hintText: "X Max",
                controller: xMax,
              )),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: Inputfield(
                  hintText: "Y Min",
                  controller: yMin,
                ),
              ),
              Expanded(
                child: Inputfield(
                  hintText: "Y Max",
                  controller: yMax,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class GraphValue {
  GraphValue(this.x, this.y);
  final String x;
  final double y;
}
