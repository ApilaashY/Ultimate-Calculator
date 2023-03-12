import 'dart:math';

import 'package:app/Modules/input_field.dart';
import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:app/Modules/globalfunctions.dart';

class SimpleInterest extends StatefulWidget {
  const SimpleInterest({super.key});

  @override
  State<SimpleInterest> createState() => _SimpleInterestState();
}

class _SimpleInterestState extends State<SimpleInterest> {
  TextEditingController Principal = TextEditingController();
  TextEditingController Rate = TextEditingController();
  TextEditingController Interest = TextEditingController();
  TextEditingController Total = TextEditingController();
  TextEditingController Time = TextEditingController();
  String _currenttime = "Years";
  final Map _times = {
    "Years": 1,
    "Semi-Years": 2,
    "Quarters": 4,
    "Months": 12,
    "Biweeks": 26,
    "Weeks": 52,
    "Days": 365,
  };
  void calc() {
    try {
      if (Principal.text.isNotEmpty &&
          Rate.text.isNotEmpty &&
          Time.text.isNotEmpty) {
        Interest.text = (double.parse(Principal.text) *
                (double.parse(Rate.text) / 100 / _times[_currenttime]) *
                double.parse(Time.text))
            .toStringAsFixed(roundingnumber);
        Total.text =
            (double.parse(Interest.text) + double.parse(Principal.text))
                .toStringAsFixed(roundingnumber);
      } else if (Interest.text.isNotEmpty &&
          Rate.text.isNotEmpty &&
          Time.text.isNotEmpty) {
        Principal.text = (double.parse(Interest.text) /
                ((double.parse(Rate.text) / 100 / _times[_currenttime]) *
                    (double.parse(Time.text) * _times[_currenttime])))
            .toStringAsFixed(roundingnumber);
        Total.text =
            (double.parse(Interest.text) + double.parse(Principal.text))
                .toStringAsFixed(roundingnumber);
      } else if (Total.text.isNotEmpty &&
          Rate.text.isNotEmpty &&
          Time.text.isNotEmpty) {
        Principal.text = (double.parse(Total.text) /
                ((double.parse(Rate.text) / 100 / _times[_currenttime]) *
                        (double.parse(Time.text) * _times[_currenttime]) +
                    1))
            .toStringAsFixed(roundingnumber);
        Interest.text = (double.parse(Principal.text) *
                (double.parse(Rate.text) / _times[_currenttime]) *
                double.parse(Time.text))
            .toStringAsFixed(roundingnumber);
      } else if (Interest.text.isNotEmpty &&
          Principal.text.isNotEmpty &&
          Time.text.isNotEmpty) {
        Total.text =
            (double.parse(Interest.text) + double.parse(Principal.text))
                .toStringAsFixed(roundingnumber);
        Rate.text = ((double.parse(Interest.text) /
                    (double.parse(Principal.text) *
                        double.parse(Time.text) *
                        _times[_currenttime])) *
                pow(_times[_currenttime], 2) *
                100)
            .toStringAsFixed(roundingnumber);
      } else if (Total.text.isNotEmpty &&
          Principal.text.isNotEmpty &&
          Time.text.isNotEmpty) {
        Rate.text =
            ((double.parse(Total.text) / double.parse(Principal.text) - 1) /
                    (double.parse(Time.text) * _times[_currenttime]) *
                    pow(_times[_currenttime], 2) *
                    100)
                .toStringAsFixed(roundingnumber);
        Interest.text =
            (double.parse(Total.text) - double.parse(Principal.text))
                .toStringAsFixed(roundingnumber);
      } else if (Interest.text.isNotEmpty &&
          Principal.text.isNotEmpty &&
          Rate.text.isNotEmpty) {
        Total.text =
            (double.parse(Interest.text) + double.parse(Principal.text))
                .toStringAsFixed(roundingnumber);
        Time.text = (double.parse(Interest.text) /
                (double.parse(Principal.text) *
                    (double.parse(Rate.text) / 100 / _times[_currenttime])))
            .toStringAsFixed(roundingnumber);
      } else if (Total.text.isNotEmpty &&
          Principal.text.isNotEmpty &&
          Rate.text.isNotEmpty) {
        Time.text =
            ((double.parse(Total.text) / double.parse(Principal.text) - 1) /
                    (double.parse(Rate.text) / 100 / _times[_currenttime]))
                .toStringAsFixed(roundingnumber);
        Interest.text =
            (double.parse(Total.text) - double.parse(Principal.text))
                .toStringAsFixed(roundingnumber);
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
        title: const Text('Simple Interest'),
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
                        controller: Principal,
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
                              ClipboardData(text: Principal.text));
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
                              hintText: 'Times Compounded',
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          DropdownButton(
                            value: _currenttime,
                            items: _times.keys
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
                        controller: Interest,
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
                              ClipboardData(text: Interest.text));
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
