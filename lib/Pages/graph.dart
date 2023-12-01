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
      yMax = TextEditingController(text: "10"),
      equation = TextEditingController();
  double prevx = -1;
  double prevy = -1;

  void solve(_) {
    try {
      chartData = [];
      for (double i = double.parse(xMin.text);
          i < double.parse(xMax.text);
          i += 0.1) {
        Solver solver = Solver();
        List<String> translation = solver.translate(
            equation.text.replaceAll("x", "(${roundto(i.toString())})"));
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
                  if (prevy > 0) {
                    yMin.text = (double.parse(yMin.text) +
                            (args.position.dy - prevy) / 10)
                        .toString();
                    yMax.text = (double.parse(yMax.text) +
                            (args.position.dy - prevy) / 10)
                        .toString();
                  }
                  if (prevx > 0) {
                    xMin.text = (double.parse(xMin.text) +
                            (args.position.dx - prevx) / 10)
                        .toString();
                    xMax.text = (double.parse(xMax.text) +
                            (args.position.dx - prevx) / 10)
                        .toString();
                  }
                  prevy = args.position.dy;
                  prevx = args.position.dx;
                  solve(-1);
                  setState(() => {});
                },
                onChartTouchInteractionUp: (details) {
                  print("Cancelled");
                  prevx = -1;
                  prevy = -1;
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
            onChanged: solve,
            controller: equation,
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
