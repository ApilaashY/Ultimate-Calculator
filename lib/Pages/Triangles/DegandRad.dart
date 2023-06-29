// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:math' as math;
import 'package:app/Modules/globalfunctions.dart';

class DegAndRad extends StatefulWidget {
  const DegAndRad({super.key});

  @override
  State<DegAndRad> createState() => _DegAndRadState();
}

class _DegAndRadState extends State<DegAndRad> {
  final TextEditingController _degrees = TextEditingController();
  final TextEditingController _radians = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Degree Radian Converter"),
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
              heightFactor: 0.6,
              widthFactor: 0.8,
              child: Hero(
                tag: "Degree Radian Converter",
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 20,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: ListView(
                      children: [
                        FractionallySizedBox(
                          widthFactor: 0.8,
                          child: TextField(
                            onChanged: (value) => setState(() => _radians.text =
                                roundto((double.parse(_degrees.text) *
                                        (math.pi / 180))
                                    .toString())),
                            controller: _degrees,
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                                color: (MediaQuery.of(context)
                                            .platformBrightness ==
                                        Brightness.light)
                                    ? Colors.black
                                    : Colors.white),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(width: 3),
                              ),
                              hintText: "Degrees",
                              suffixText: "°",
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.copy,
                          ),
                          onPressed: () async {
                            await Clipboard.setData(
                                ClipboardData(text: _degrees.text));
                            Fluttertoast.showToast(msg: 'Saved to Clipboard');
                          },
                        ),
                        FractionallySizedBox(
                          widthFactor: 0.8,
                          child: TextField(
                            onChanged: (value) => setState(() => _degrees.text =
                                roundto((double.parse(_radians.text) *
                                        (180 / math.pi))
                                    .toString())),
                            controller: _radians,
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                                color: (MediaQuery.of(context)
                                            .platformBrightness ==
                                        Brightness.light)
                                    ? Colors.black
                                    : Colors.white),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(width: 3),
                              ),
                              hintText: "Radians",
                              suffixText: "Radians",
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.copy,
                          ),
                          onPressed: () async {
                            await Clipboard.setData(
                                ClipboardData(text: _radians.text));
                            Fluttertoast.showToast(msg: 'Saved to Clipboard');
                          },
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
