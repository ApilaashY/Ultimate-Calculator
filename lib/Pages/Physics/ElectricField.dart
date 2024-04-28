import 'package:app/Modules/button.dart';
import 'package:app/Modules/globalfunctions.dart';
import 'package:app/Modules/input_field.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class ElectricField extends StatefulWidget {
  const ElectricField({super.key});

  @override
  State<ElectricField> createState() => _ElectricFieldState();
}

class _ElectricFieldState extends State<ElectricField> {
  List<Point> points = [
    Point(x: 1, y: 3, charge: 2),
    Point(x: 3, y: 1, charge: -2),
  ];
  int selected = 0;
  String force = "";
  final k = 8.987551792 * pow(10, 9);
  TextEditingController xText = TextEditingController();
  TextEditingController yText = TextEditingController();
  TextEditingController chargeText = TextEditingController();

  void add() {
    TextEditingController x = TextEditingController();
    TextEditingController y = TextEditingController();
    TextEditingController charge = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Inputfield(hintText: "X", controller: x),
              Inputfield(hintText: "Y", controller: y),
              Inputfield(hintText: "Charge", controller: charge),
              Button(
                onPressed: () {
                  points.add(
                    Point(
                      x: double.parse(x.text),
                      y: double.parse(y.text),
                      charge: double.parse(charge.text),
                    ),
                  );
                  Navigator.pop(context);
                  setState(() {});
                },
                child: const Text("Add"),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Electric Fields"),
        actions: [IconButton(onPressed: add, icon: const Icon(Icons.add))],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Expanded(
                  child: ScatterChart(
                    ScatterChartData(
                      scatterSpots: points
                          .map(
                            (e) => ScatterSpot(
                              e.x,
                              e.y,
                              dotPainter: FlDotCirclePainter(
                                color: (selected == points.indexOf(e))
                                    ? Colors.yellow
                                    : (e.charge == 0)
                                        ? Colors.grey
                                        : (e.charge > 0)
                                            ? Colors.blue
                                            : Colors.red,
                                radius: 10,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    swapAnimationDuration:
                        const Duration(milliseconds: 150), // Optional
                    swapAnimationCurve: Curves.linear, // Optional
                  ),
                ),
                DropdownButton(
                  value: points[selected],
                  items: points
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text("${e.x}, ${e.y}"),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value == null) return;

                    selected = points.indexOf(value);
                    xText.text = points[selected].x.toString();
                    yText.text = points[selected].y.toString();
                    chargeText.text = points[selected].charge.toString();

                    setState(() {});
                  },
                )
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Inputfield(
                    controller: xText,
                    onChanged: (value) {
                      points[selected].changeX(value);
                      setState(() {});
                    },
                    hintText: "X",
                  ),
                ),
                Expanded(
                  child: Inputfield(
                    controller: yText,
                    onChanged: (value) {
                      points[selected].changeY(value);
                      setState(() {});
                    },
                    hintText: "Y",
                  ),
                ),
                Expanded(
                  child: Inputfield(
                    controller: chargeText,
                    onChanged: (value) {
                      points[selected].changeCharge(value);
                      setState(() {});
                    },
                    hintText: "Charge",
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: FractionallySizedBox(
              widthFactor: 0.8,
              heightFactor: 0.8,
              child: FittedBox(
                child: Text(
                  (() {
                    double xTotal = 0;
                    double yTotal = 0;

                    for (int i = 0; i < points.length; i++) {
                      if (i == selected) continue;
                      bool repel = (points[i].charge > 0 &&
                              points[selected].charge < 0) ||
                          (points[i].charge < 0 && points[selected].charge > 0);

                      double x = ((points[i].x - points[selected].x) != 0)
                          ? (k * points[i].charge * points[selected].charge) /
                              (pow((points[i].x - points[selected].x), 2))
                          : 0;
                      double y = ((points[i].y - points[selected].y) != 0)
                          ? (k * points[i].charge * points[selected].charge) /
                              (pow((points[i].y - points[selected].y), 2))
                          : 0;

                      if ((repel && points[i].x > points[selected].x) ||
                          (!repel && points[i].x < points[selected].x)) {
                        x *= -1;
                      }

                      if ((repel && points[i].y > points[selected].y) ||
                          (!repel && points[i].y < points[selected].y)) {
                        y *= -1;
                      }

                      xTotal += x;
                      yTotal += y;
                    }

                    double degree = atan((xTotal / yTotal) *
                            ((xTotal / yTotal < 0) ? -1 : 1)) *
                        180 /
                        pi;

                    return "Net Force:\n${roundto((sqrt(pow(xTotal, 2) + pow(yTotal, 2))).toString())}N\n[${(yTotal > 0) ? "N" : "S"}${roundto(degree.toString())}${(xTotal > 0) ? "E" : "W"}]";
                  })(),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Point {
  Point({required this.x, required this.y, required this.charge});

  double x, y, charge;

  void changeX(String value) {
    try {
      x = double.parse(value);
    } catch (e) {}
  }

  void changeY(String value) {
    try {
      y = double.parse(value);
    } catch (e) {}
  }

  void changeCharge(String value) {
    try {
      charge = double.parse(value);
    } catch (e) {}
  }
}
