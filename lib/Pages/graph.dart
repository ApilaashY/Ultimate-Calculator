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
  // final List<ChartData> chartData = [
  //   ChartData(2010, 35),
  //   ChartData(2011, 28),
  //   ChartData(2012, 34),
  //   ChartData(2013, 32),
  //   ChartData(2014, 40)
  // ];

  List<ChartData> chartData = [];
  TextEditingController xMin = TextEditingController(text: "-10"),
      yMin = TextEditingController(text: "-10"),
      xMax = TextEditingController(text: "10"),
      yMax = TextEditingController(text: "10");

  void solve(equation) {
    try {
      chartData = [];
      for (double i = double.parse(xMin.text);
          i < double.parse(xMax.text);
          i += 0.1) {
        Solver solver = Solver();
        List<String> translation = solver
            .translate(equation.replaceAll("x", "(${roundto(i.toString())})"));
        chartData.add(ChartData(i, solver.solve(translation, "Degree")));
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
            child: Hero(
              tag: "Graphs",
              child: SfCartesianChart(
                onChartTouchInteractionMove: (ChartTouchInteractionArgs args) {
                  print(args.position.dx.toString());
                  print(args.position.dy.toString());
                },
                primaryYAxis: NumericAxis(
                    maximum: double.tryParse(yMax.text),
                    minimum: double.tryParse(yMin.text)),
                series: <ChartSeries>[
                  LineSeries<ChartData, double>(
                      dataSource: chartData,
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y)
                ],
              ),
            ),
          ),
          Inputfield(
            onChanged: (value) => solve(value),
            hintText: "y =",
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text("X:"),
              ),
              Expanded(
                child: Inputfield(
                  onChanged: (text) => setState(() {}),
                  hintText: "X Min",
                  controller: xMin,
                ),
              ),
              const Text("To"),
              Expanded(
                child: Inputfield(
                  onChanged: (text) => setState(() {}),
                  hintText: "X Max",
                  controller: xMax,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text("Y:"),
              ),
              Expanded(
                child: Inputfield(
                  onChanged: (text) => setState(() {}),
                  hintText: "Y Min",
                  controller: yMin,
                ),
              ),
              const Text("To"),
              Expanded(
                child: Inputfield(
                  onChanged: (text) => setState(() {}),
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

class ChartData {
  ChartData(this.x, this.y);
  final double x;
  final double y;
}
