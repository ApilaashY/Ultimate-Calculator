// ignore_for_file: file_names

import 'dart:math';

import 'package:app/Modules/input_field.dart';
import 'package:app/Modules/globalfunctions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Sequence extends StatefulWidget {
  const Sequence({super.key});

  @override
  State<Sequence> createState() => _SequenceState();
}

class _SequenceState extends State<Sequence> {
  TextEditingController first = TextEditingController();
  TextEditingController nth = TextEditingController();
  TextEditingController n = TextEditingController();
  TextEditingController difference = TextEditingController();
  String change = "Arithmetic";

  void calc() {
    try {
      if (change == "Arithmetic") {
        if (first.text.isNotEmpty && nth.text.isNotEmpty && n.text.isNotEmpty) {
          difference.text = roundto(
              ((double.parse(nth.text) - double.parse(first.text)) /
                      (double.parse(n.text) - 1))
                  .toString());
        } else if (difference.text.isNotEmpty &&
            nth.text.isNotEmpty &&
            n.text.isNotEmpty) {
          first.text = roundto((double.parse(nth.text) -
                  double.parse(difference.text) * (double.parse(n.text) - 1))
              .toString());
        } else if (first.text.isNotEmpty &&
            difference.text.isNotEmpty &&
            n.text.isNotEmpty) {
          nth.text = roundto((double.parse(first.text) +
                  double.parse(difference.text) * (double.parse(n.text) - 1))
              .toString());
        } else if (first.text.isNotEmpty &&
            nth.text.isNotEmpty &&
            difference.text.isNotEmpty) {
          n.text = roundto(
              ((double.parse(nth.text) - double.parse(first.text)) /
                          double.parse(difference.text) +
                      1)
                  .toString());
        } else {
          Fluttertoast.showToast(msg: "Not Enough Information");
        }
      } else if (change == "Geometric") {
        if (first.text.isNotEmpty && nth.text.isNotEmpty && n.text.isNotEmpty) {
          difference.text = roundto((pow(
                  double.parse(nth.text) / double.parse(first.text),
                  (1 / (double.parse(n.text) - 1))))
              .toString());
        } else if (difference.text.isNotEmpty &&
            nth.text.isNotEmpty &&
            n.text.isNotEmpty) {
          first.text = roundto((double.parse(nth.text) /
                  pow(double.parse(difference.text),
                      (double.parse(n.text) - 1)))
              .toString());
        } else if (first.text.isNotEmpty &&
            difference.text.isNotEmpty &&
            n.text.isNotEmpty) {
          nth.text = roundto((double.parse(first.text) *
                  pow(double.parse(difference.text),
                      (double.parse(n.text) - 1)))
              .toString());
        } else if (first.text.isNotEmpty &&
            nth.text.isNotEmpty &&
            difference.text.isNotEmpty) {
          n.text = roundto(
              (log(double.parse(nth.text) / double.parse(first.text)) /
                          log(double.parse(difference.text)) +
                      1)
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
        title: const Text("Sequences"),
      ),
      body: Center(
        child: FractionallySizedBox(
          heightFactor: 0.8,
          widthFactor: 0.85,
          child: Hero(
            tag: "Sequences",
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
                    controller: nth,
                    hintText: "Nth Term",
                    keyboardType: TextInputType.number,
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.copy,
                    ),
                    onPressed: () async {
                      await Clipboard.setData(ClipboardData(text: nth.text));
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
