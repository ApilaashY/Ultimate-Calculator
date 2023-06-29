// ignore_for_file: file_names

import 'dart:math';

import 'package:app/Modules/input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:app/Modules/globalfunctions.dart';

final Map compoundPeriods = {
  "Yearly": 1,
  "Semi-Annually": 2,
  "Quarterly": 4,
  "Monthly": 12,
  "Biweekly": 26,
  "Weekly": 52,
  "Daily": 365,
};

class CompoundInterest extends StatefulWidget {
  const CompoundInterest({super.key});

  @override
  State<CompoundInterest> createState() => _CompoundInterestState();
}

class _CompoundInterestState extends State<CompoundInterest> {
  TextEditingController principal = TextEditingController();
  TextEditingController rate = TextEditingController();
  TextEditingController interest = TextEditingController();
  TextEditingController total = TextEditingController();
  TextEditingController time = TextEditingController();
  String _currenttime = "Yearly";
  void calc() {
    try {
      if (principal.text.isNotEmpty &&
          rate.text.isNotEmpty &&
          time.text.isNotEmpty) {
        total.text = roundto((pow(
                    1 +
                        double.parse(rate.text) /
                            100 /
                            compoundPeriods[_currenttime],
                    double.parse(time.text) * compoundPeriods[_currenttime]) *
                double.parse(principal.text))
            .toString());
        interest.text = roundto(
            (double.parse(total.text) - double.parse(principal.text))
                .toString());
      } else if (interest.text.isNotEmpty &&
          rate.text.isNotEmpty &&
          time.text.isNotEmpty) {
        principal.text = roundto((double.parse(interest.text) /
                (pow(
                        1 +
                            double.parse(rate.text) /
                                100 /
                                compoundPeriods[_currenttime],
                        double.parse(time.text) *
                            compoundPeriods[_currenttime]) -
                    1))
            .toString());
        total.text = roundto(
            (double.parse(principal.text) + double.parse(interest.text))
                .toString());
      } else if (total.text.isNotEmpty &&
          rate.text.isNotEmpty &&
          time.text.isNotEmpty) {
        principal.text = roundto((double.parse(total.text) /
                (pow(
                    1 +
                        double.parse(rate.text) /
                            100 /
                            compoundPeriods[_currenttime],
                    double.parse(time.text) * compoundPeriods[_currenttime])))
            .toString());
        interest.text = roundto(
            (double.parse(total.text) - double.parse(principal.text))
                .toString());
      } else if (interest.text.isNotEmpty &&
          principal.text.isNotEmpty &&
          time.text.isNotEmpty) {
        rate.text = roundto(((pow(
                        1 +
                            double.parse(interest.text) /
                                double.parse(principal.text),
                        1 /
                            (double.parse(time.text) *
                                compoundPeriods[_currenttime])) -
                    1) *
                compoundPeriods[_currenttime] *
                100)
            .toString());
        total.text = roundto(
            (double.parse(principal.text) + double.parse(interest.text))
                .toString());
      } else if (total.text.isNotEmpty &&
          principal.text.isNotEmpty &&
          time.text.isNotEmpty) {
        rate.text = roundto(((pow(
                        double.parse(total.text) / double.parse(principal.text),
                        1 /
                            (double.parse(time.text) *
                                compoundPeriods[_currenttime])) -
                    1) *
                compoundPeriods[_currenttime] *
                100)
            .toString());
        interest.text = roundto(
            (double.parse(total.text) - double.parse(principal.text))
                .toString());
      } else if (interest.text.isNotEmpty &&
          principal.text.isNotEmpty &&
          rate.text.isNotEmpty) {
        time.text = roundto((log(1 +
                    double.parse(interest.text) /
                        double.parse(principal.text)) /
                log(1 +
                    double.parse(rate.text) /
                        100 /
                        compoundPeriods[_currenttime]) /
                compoundPeriods[_currenttime])
            .toString());
        total.text = roundto(
            (double.parse(principal.text) + double.parse(interest.text))
                .toString());
      } else if (total.text.isNotEmpty &&
          principal.text.isNotEmpty &&
          rate.text.isNotEmpty) {
        time.text = roundto(
            (log(double.parse(total.text) / double.parse(principal.text)) /
                    log(1 +
                        double.parse(rate.text) /
                            100 /
                            compoundPeriods[_currenttime]) /
                    compoundPeriods[_currenttime])
                .toString());
        interest.text = roundto(
            (double.parse(total.text) - double.parse(principal.text))
                .toString());
      } else {
        Fluttertoast.showToast(msg: "Not Enough Information");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error');
    }
    addpoints(1);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Compound Interest'),
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
                tag: "Compound Interest",
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
                          controller: principal,
                          hintText: 'Principal',
                          keyboardType: TextInputType.number,
                          prefixText: "\$",
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.copy,
                          ),
                          onPressed: () async {
                            await Clipboard.setData(
                                ClipboardData(text: principal.text));
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
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Inputfield(
                                controller: time,
                                hintText: 'Years',
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            DropdownButton(
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
                            )
                          ],
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
                          controller: interest,
                          hintText: 'Interest',
                          keyboardType: TextInputType.number,
                          prefixText: '\$',
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.copy,
                          ),
                          onPressed: () async {
                            await Clipboard.setData(
                                ClipboardData(text: interest.text));
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
