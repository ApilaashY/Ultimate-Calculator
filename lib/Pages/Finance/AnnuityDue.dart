import 'dart:math';

import 'package:app/Modules/input_field.dart';
import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:app/Modules/globalfunctions.dart';
import 'CompoundInterest.dart' as Compound;

class AnnuityDue extends StatefulWidget {
  const AnnuityDue({super.key});

  @override
  State<AnnuityDue> createState() => _AnnuityDueState();
}

class _AnnuityDueState extends State<AnnuityDue> {
  TextEditingController Addition = TextEditingController();
  TextEditingController Rate = TextEditingController();
  TextEditingController Total = TextEditingController();
  TextEditingController Time = TextEditingController();
  String _currenttime = "Yearly";
  void calc() {
    try {
      if (Addition.text.isNotEmpty &&
          Rate.text.isNotEmpty &&
          Time.text.isNotEmpty) {
        Total.text = roundto((((pow(
                        double.parse(Rate.text) /
                                100 /
                                Compound.compoundPeriods[_currenttime] +
                            1,
                        double.parse(Time.text) *
                            Compound.compoundPeriods[_currenttime]) -
                    1)) /
                (double.parse(Rate.text) /
                    100 /
                    Compound.compoundPeriods[_currenttime]) *
                Compound.compoundPeriods[_currenttime] *
                double.parse(Addition.text) *
                (double.parse(Rate.text) /
                        100 /
                        Compound.compoundPeriods[_currenttime] +
                    1))
            .toString());
      } else if (Total.text.isNotEmpty &&
          Rate.text.isNotEmpty &&
          Time.text.isNotEmpty) {
        Addition.text = roundto((double.parse(Total.text) *
                double.parse(Rate.text) /
                100 /
                Compound.compoundPeriods[_currenttime] /
                (pow(
                        double.parse(Rate.text) /
                                100 /
                                Compound.compoundPeriods[_currenttime] +
                            1,
                        double.parse(Time.text) *
                            Compound.compoundPeriods[_currenttime]) -
                    1) /
                (double.parse(Rate.text) /
                        100 /
                        Compound.compoundPeriods[_currenttime] +
                    1))
            .toString());
      } else if (Total.text.isNotEmpty &&
          Addition.text.isNotEmpty &&
          Rate.text.isNotEmpty) {
        Time.text = roundto((log(double.parse(Total.text) *
                        double.parse(Rate.text) /
                        100 /
                        Compound.compoundPeriods[_currenttime] /
                        double.parse(Addition.text) /
                        (double.parse(Rate.text) /
                                100 /
                                Compound.compoundPeriods[_currenttime] +
                            1) +
                    1) /
                log(1 +
                    double.parse(Rate.text) /
                        100 /
                        Compound.compoundPeriods[_currenttime]) /
                Compound.compoundPeriods[_currenttime])
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
                        controller: Addition,
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
                              ClipboardData(text: Addition.text));
                          Fluttertoast.showToast(msg: 'Saved to Clipboard');
                        },
                      ),
                      Inputfield(
                        controller: Rate,
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
                              ClipboardData(text: Rate.text));
                          Fluttertoast.showToast(msg: 'Saved to Clipboard');
                        },
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Inputfield(
                              controller: Time,
                              hintText: 'Payments',
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
                            items: Compound.compoundPeriods.keys
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
                              ClipboardData(text: Time.text));
                          Fluttertoast.showToast(msg: 'Saved to Clipboard');
                        },
                      ),
                      Inputfield(
                        controller: Total,
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
                              ClipboardData(text: Total.text));
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
          )
        ],
      ),
    );
  }
}
