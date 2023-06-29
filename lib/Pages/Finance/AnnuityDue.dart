// ignore_for_file: file_names

import 'dart:math';
import 'package:app/Modules/input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:app/Modules/globalfunctions.dart';

class AnnuityDue extends StatefulWidget {
  const AnnuityDue({super.key});

  @override
  State<AnnuityDue> createState() => _AnnuityDueState();
}

class _AnnuityDueState extends State<AnnuityDue> {
  final Map compoundPeriods = {
    "Year": 1,
    "Semi-Year": 2,
    "Quarter": 4,
    "Month": 12,
    "Biweek": 26,
    "Week": 52,
    "Day": 365,
  };
  TextEditingController addition = TextEditingController();
  TextEditingController rate = TextEditingController();
  TextEditingController total = TextEditingController();
  TextEditingController time = TextEditingController();
  String _currenttime = "Year";
  void calc() {
    try {
      if (addition.text.isNotEmpty &&
          rate.text.isNotEmpty &&
          time.text.isNotEmpty) {
        total.text = roundto((((double.parse(rate.text) /
                            100 /
                            compoundPeriods[_currenttime] +
                        1) *
                    double.parse(addition.text) *
                    (pow(
                            double.parse(rate.text) /
                                    100 /
                                    compoundPeriods[_currenttime] +
                                1,
                            double.parse(time.text)) -
                        1)) /
                (double.parse(rate.text) / 100 / compoundPeriods[_currenttime]))
            .toString());
      } else if (total.text.isNotEmpty &&
          rate.text.isNotEmpty &&
          time.text.isNotEmpty) {
        addition.text = roundto(((double.parse(total.text) *
                    (double.parse(rate.text) /
                        100 /
                        compoundPeriods[_currenttime])) /
                ((pow(
                        double.parse(rate.text) /
                                100 /
                                compoundPeriods[_currenttime] +
                            1,
                        double.parse(time.text)) -
                    1)))
            .toString());
      } else if (total.text.isNotEmpty &&
          addition.text.isNotEmpty &&
          rate.text.isNotEmpty) {
        time.text = roundto((log((double.parse(total.text) *
                            (double.parse(rate.text) /
                                100 /
                                compoundPeriods[_currenttime])) /
                        double.parse(addition.text) +
                    1) /
                log(double.parse(rate.text) /
                        100 /
                        compoundPeriods[_currenttime] +
                    1))
            .toString());
      } else {
        Fluttertoast.showToast(msg: "Not Enough Information");
      }
      addpoints(1);
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error');
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Annuity Due'),
        foregroundColor:
            (MediaQuery.of(context).platformBrightness == Brightness.light)
                ? Colors.black
                : Colors.white,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Align(
            alignment: const Alignment(0.0, 0.2),
            child: FractionallySizedBox(
              heightFactor: 0.8,
              widthFactor: 0.85,
              child: Hero(
                tag: "Annuity Due",
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 20,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: ListView(
                      children: [
                        Inputfield(
                          controller: addition,
                          hintText: 'Addition',
                          keyboardType: TextInputType.number,
                          prefixText: "\$",
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.copy,
                          ),
                          onPressed: () async {
                            await Clipboard.setData(
                                ClipboardData(text: addition.text));
                            Fluttertoast.showToast(msg: 'Saved to Clipboard');
                          },
                        ),
                        Inputfield(
                          controller: rate,
                          hintText: 'Yearly Interest Rate',
                          keyboardType: TextInputType.number,
                          suffixText: '%',
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.copy,
                          ),
                          onPressed: () async {
                            await Clipboard.setData(
                                ClipboardData(text: rate.text));
                            Fluttertoast.showToast(msg: 'Saved to Clipboard');
                          },
                        ),
                        const Center(child: Text("Compounded Every")),
                        Center(
                          child: DropdownButton(
                            style: TextStyle(
                                color: (MediaQuery.of(context)
                                            .platformBrightness ==
                                        Brightness.light)
                                    ? Colors.black
                                    : Colors.white),
                            value: _currenttime,
                            items: compoundPeriods.keys
                                .map((e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(e.toString()),
                                    ))
                                .toList(),
                            onChanged: (newval) {
                              _currenttime = newval.toString();
                              setState(() {});
                            },
                          ),
                        ),
                        Inputfield(
                          controller: time,
                          hintText: 'Total Number of Payments',
                          keyboardType: TextInputType.number,
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.copy,
                          ),
                          onPressed: () async {
                            await Clipboard.setData(
                                ClipboardData(text: time.text));
                            Fluttertoast.showToast(msg: 'Saved to Clipboard');
                          },
                        ),
                        Inputfield(
                          controller: total,
                          hintText: 'Total',
                          keyboardType: TextInputType.number,
                          prefixText: '\$',
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.copy,
                          ),
                          onPressed: () async {
                            await Clipboard.setData(
                                ClipboardData(text: total.text));
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
          )
        ],
      ),
    );
  }
}
