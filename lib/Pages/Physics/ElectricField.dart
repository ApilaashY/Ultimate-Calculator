import 'package:app/Modules/button.dart';
import 'package:app/Modules/globalfunctions.dart';
import 'package:app/Modules/input_field.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter/widgets.dart';

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
  Map<String, double> units = {
    "C": 1,
    "mC": 0.001,
    "μC": pow(10, -6).toDouble()
  };
  String chargeUnit = "C";

  String validator(String? value, String x, String y) {
    print("HFIO");
    for (int i = 0; i < points.length; i++) {
      if (i != selected &&
          points[i].x == double.tryParse(x) &&
          points[i].y == double.tryParse(y)) {
        return "A point with these coordinates already exists";
      }
    }
    print("NON");
    return "";
  }

  void add() {
    TextEditingController x = TextEditingController();
    TextEditingController y = TextEditingController();
    TextEditingController charge = TextEditingController();
    String unit = "C";
    ObjectKey ke = const ObjectKey("dsa");

    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InputFormField(
                  key: ke,
                  hintText: "X",
                  controller: x,
                  validator: (String? v) {
                    return validator(v, x.text, y.text);
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                InputFormField(
                  hintText: "Y",
                  controller: y,
                  validator: (String? v) => validator(v, x.text, y.text),
                ),
                InputFormField(
                  hintText: "Charge",
                  controller: charge,
                  suffix: DropdownButton(
                    value: unit,
                    items: units.keys
                        .toList()
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() => unit = value ?? unit);
                    },
                  ),
                ),
                Button(
                  onPressed: () {
                    points.add(
                      Point(
                          x: double.parse(x.text),
                          y: double.parse(y.text),
                          charge: double.parse(charge.text),
                          factor: units[unit] ?? 1),
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
                  value: (points.isNotEmpty) ? points[selected] : null,
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
            child: (!points.isNotEmpty)
                ? Container()
                : Column(
                    children: [
                      Row(
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
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(child: Container()),
                          Expanded(
                            child: IconButton(
                              onPressed: () {
                                points.removeAt(selected);
                                if (selected >= points.length) selected--;
                                if (selected < 0) selected = 0;

                                setState(() {});
                              },
                              icon: const Icon(Icons.delete),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: DropdownButton(
                                alignment: Alignment.centerRight,
                                value: (selected >= 0)
                                    ? units.keys.toList()[units.values
                                        .toList()
                                        .indexOf(points[selected].factor)]
                                    : null,
                                items: units.keys
                                    .toList()
                                    .map((e) => DropdownMenuItem(
                                          value: e,
                                          child: Text(e),
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  points[selected].changeChargeFactor(
                                      units[value].toString());
                                  setState(() {});
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
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
                    if (points.isEmpty) return "";

                    double xTotal = 0;
                    double yTotal = 0;

                    for (int i = 0; i < points.length; i++) {
                      if (i == selected) continue;
                      bool repel = (points[i].charge > 0 &&
                              points[selected].charge < 0) ||
                          (points[i].charge < 0 && points[selected].charge > 0);

                      double x = ((points[i].x - points[selected].x) != 0)
                          ? abs((k *
                                  points[i].charge *
                                  points[i].factor *
                                  points[selected].charge *
                                  points[i].factor) /
                              (pow((points[i].x - points[selected].x), 2)))
                          : 0;
                      double y = ((points[i].y - points[selected].y) != 0)
                          ? abs((k *
                                  points[i].charge *
                                  points[i].factor *
                                  points[selected].charge *
                                  points[i].factor) /
                              (pow((points[i].y - points[selected].y), 2)))
                          : 0;

                      if ((repel && points[i].x < points[selected].x) ||
                          (!repel && points[i].x > points[selected].x)) {
                        x *= -1;
                      }

                      if ((repel && points[i].y < points[selected].y) ||
                          (!repel && points[i].y > points[selected].y)) {
                        y *= -1;
                      }
                      print(x);
                      print(y);

                      xTotal += x;
                      yTotal += y;
                    }

                    if (xTotal + yTotal == 0) return "Net Force:\nNone";

                    String degree = roundto((atan((xTotal / yTotal) *
                                ((xTotal / yTotal < 0) ? -1 : 1)) *
                            180 /
                            pi)
                        .toString());

                    return "Net Force:\n${roundto((sqrt(pow(xTotal, 2) + pow(yTotal, 2))).toString())}N\n[${(degree == "90") ? "" : ((yTotal > 0) ? "N" : "S")}${(degree != "0" && degree != "90") ? degree : ""}${(degree == "0") ? "" : ((xTotal > 0) ? "E" : "W")}]";
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
  Point(
      {required this.x,
      required this.y,
      required this.charge,
      this.factor = 1});

  double x, y, charge, factor;

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

  void changeChargeFactor(String value) {
    try {
      factor = double.parse(value);
    } catch (e) {}
  }
}
