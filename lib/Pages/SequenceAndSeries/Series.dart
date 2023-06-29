// ignore_for_file: file_names

import 'dart:math';

import 'package:app/Modules/input_field.dart';
import 'package:app/Modules/globalfunctions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Series extends StatefulWidget {
  const Series({super.key});

  @override
  State<Series> createState() => _SeriesState();
}

class _SeriesState extends State<Series> {
  TextEditingController first = TextEditingController();
  TextEditingController sum = TextEditingController();
  TextEditingController n = TextEditingController();
  TextEditingController finalValue = TextEditingController();
  TextEditingController difference = TextEditingController();
  String change = "Arithmetic";

  void calc() {
    try {
      if (change == "Arithmetic") {
        if (n.text.isNotEmpty &&
            first.text.isNotEmpty &&
            finalValue.text.isNotEmpty) {
          sum.text = roundto(
              ((double.parse(first.text) + double.parse(finalValue.text)) /
                      2 *
                      double.parse(n.text))
                  .toString());
          difference.text = roundto(
              ((double.parse(finalValue.text) - double.parse(first.text)) /
                      (double.parse(n.text) - 1))
                  .toString());
        } else if (sum.text.isNotEmpty &&
            first.text.isNotEmpty &&
            finalValue.text.isNotEmpty) {
          n.text = roundto((double.parse(sum.text) /
                  ((double.parse(first.text) + double.parse(finalValue.text)) /
                      2))
              .toString());
          difference.text = roundto(
              ((double.parse(finalValue.text) - double.parse(first.text)) /
                      (double.parse(n.text) - 1))
                  .toString());
        } else if (n.text.isNotEmpty &&
            sum.text.isNotEmpty &&
            finalValue.text.isNotEmpty) {
          first.text = roundto(
              (double.parse(sum.text) / double.parse(n.text) * 2 -
                      double.parse(finalValue.text))
                  .toString());
          difference.text = roundto(
              ((double.parse(finalValue.text) - double.parse(first.text)) /
                      (double.parse(n.text) - 1))
                  .toString());
        } else if (n.text.isNotEmpty &&
            first.text.isNotEmpty &&
            sum.text.isNotEmpty) {
          finalValue.text = roundto(
              (double.parse(sum.text) / double.parse(n.text) * 2 -
                      double.parse(first.text))
                  .toString());
          difference.text = roundto(
              ((double.parse(finalValue.text) - double.parse(first.text)) /
                      (double.parse(n.text) - 1))
                  .toString());
        } else if (n.text.isNotEmpty &&
            first.text.isNotEmpty &&
            difference.text.isNotEmpty) {
          sum.text = roundto(((double.parse(n.text) / 2) *
                  (2 * double.parse(first.text) +
                      double.parse(difference.text) *
                          (double.parse(n.text) - 1)))
              .toString());
        } else if (sum.text.isNotEmpty &&
            first.text.isNotEmpty &&
            difference.text.isNotEmpty) {
          n.text = roundto(((-2 * double.parse(first.text) +
                      double.parse(difference.text) +
                      sqrt(pow(
                              (2 * double.parse(first.text) -
                                  double.parse(difference.text)),
                              2) +
                          (8 *
                              double.parse(difference.text) *
                              double.parse(sum.text)))) /
                  (2 * double.parse(difference.text)))
              .toString());
        } else if (n.text.isNotEmpty &&
            sum.text.isNotEmpty &&
            difference.text.isNotEmpty) {
          first.text = roundto(
              ((double.parse(sum.text) / (double.parse(n.text) / 2) -
                          double.parse(difference.text) *
                              (double.parse(n.text) - 1)) /
                      2)
                  .toString());
        } else if (n.text.isNotEmpty &&
            first.text.isNotEmpty &&
            sum.text.isNotEmpty) {
          difference.text = roundto(
              ((double.parse(sum.text) / (double.parse(n.text) / 2) -
                          double.parse(first.text) * 2) /
                      (double.parse(n.text) - 1))
                  .toString());
        } else {
          Fluttertoast.showToast(msg: "Not Enough Information");
        }
      } else if (change == "Geometric") {
        if (n.text.isNotEmpty &&
            first.text.isNotEmpty &&
            finalValue.text.isNotEmpty) {
          difference.text = roundto((pow(
                  double.parse(finalValue.text) / double.parse(first.text),
                  1 / (double.parse(n.text) - 1)))
              .toString());
        } else if (n.text.isNotEmpty &&
            first.text.isNotEmpty &&
            difference.text.isNotEmpty) {
          sum.text = roundto(
              ((pow(double.parse(difference.text), double.parse(n.text)) - 1) *
                      double.parse(first.text) /
                      (double.parse(difference.text) - 1))
                  .toString());
        } else if (sum.text.isNotEmpty &&
            first.text.isNotEmpty &&
            difference.text.isNotEmpty) {
          n.text = roundto((log(double.parse(sum.text) *
                          (double.parse(difference.text) - 1) /
                          double.parse(first.text) +
                      1) /
                  log(double.parse(difference.text)))
              .toString());
        } else if (n.text.isNotEmpty &&
            sum.text.isNotEmpty &&
            difference.text.isNotEmpty) {
          first.text = roundto((double.parse(sum.text) *
                  (double.parse(difference.text) - 1) /
                  (pow(double.parse(difference.text), double.parse(n.text)) -
                      1))
              .toString());
        } else {
          Fluttertoast.showToast(msg: "Not Enough Information");
        }
        addpoints(1);
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error");
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor:
            (MediaQuery.of(context).platformBrightness == Brightness.light)
                ? Colors.black
                : Colors.white,
        title: const Text("Series"),
      ),
      body: Center(
        child: FractionallySizedBox(
          heightFactor: 0.8,
          widthFactor: 0.85,
          child: Hero(
            tag: "Series",
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 20,
              child: ListView(
                children: [
                  Center(
                    child: DropdownButton(
                      style: TextStyle(
                          color: (MediaQuery.of(context).platformBrightness ==
                                  Brightness.light)
                              ? Colors.black
                              : Colors.white),
                      items: const [
                        DropdownMenuItem(
                          value: "Arithmetic",
                          child: Text("Arithmetic"),
                        ),
                        DropdownMenuItem(
                          value: "Geometric",
                          child: Text("Geometric"),
                        ),
                        // DropdownMenuItem(
                        //   value: "Fibonacci",
                        //   child: Text("Fibonacci"),
                        // ),
                      ],
                      onChanged: (val) {
                        change = val.toString();
                        setState(() {});
                      },
                      value: change,
                    ),
                  ),
                  Inputfield(
                    controller: first,
                    hintText: "First Value",
                    keyboardType: TextInputType.number,
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.copy,
                    ),
                    onPressed: () async {
                      await Clipboard.setData(ClipboardData(text: first.text));
                      Fluttertoast.showToast(msg: 'Saved to Clipboard');
                    },
                  ),
                  Inputfield(
                    controller: n,
                    hintText: "N",
                    keyboardType: TextInputType.number,
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.copy,
                    ),
                    onPressed: () async {
                      await Clipboard.setData(ClipboardData(text: n.text));
                      Fluttertoast.showToast(msg: 'Saved to Clipboard');
                    },
                  ),
                  Inputfield(
                    controller: finalValue,
                    hintText: "Final Term",
                    keyboardType: TextInputType.number,
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.copy,
                    ),
                    onPressed: () async {
                      await Clipboard.setData(
                          ClipboardData(text: finalValue.text));
                      Fluttertoast.showToast(msg: 'Saved to Clipboard');
                    },
                  ),
                  Inputfield(
                    controller: difference,
                    hintText: "Common Difference",
                    keyboardType: TextInputType.number,
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.copy,
                    ),
                    onPressed: () async {
                      await Clipboard.setData(
                          ClipboardData(text: difference.text));
                      Fluttertoast.showToast(msg: 'Saved to Clipboard');
                    },
                  ),
                  Inputfield(
                    controller: sum,
                    hintText: "Sum of N terms",
                    keyboardType: TextInputType.number,
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.copy,
                    ),
                    onPressed: () async {
                      await Clipboard.setData(ClipboardData(text: sum.text));
                      Fluttertoast.showToast(msg: 'Saved to Clipboard');
                    },
                  ),
                  FractionallySizedBox(
                    widthFactor: 0.65,
                    child: ElevatedButton(
                      onPressed: calc,
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 0, 135, 197)),
                      child: const Text('Solve'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
