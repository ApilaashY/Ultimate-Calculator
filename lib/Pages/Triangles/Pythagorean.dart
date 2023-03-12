// ignore_for_file: file_names

import 'dart:convert';
import 'package:app/Modules/input_field.dart';
import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:math';
import 'package:app/Modules/globalfunctions.dart';

class Pythagorean extends StatefulWidget {
  const Pythagorean({super.key});

  @override
  State<Pythagorean> createState() => _PythagoreanState();
}

class _PythagoreanState extends State<Pythagorean> {
  TextEditingController adjacent = TextEditingController();
  TextEditingController opposite = TextEditingController();
  TextEditingController hypotenuse = TextEditingController();
  String answertext = '';
  IconData icon = Icons.question_mark;
  Color color = Colors.black;

  void calc() {
    try {
      var ad = double.parse(adjacent.text);
      var op = double.parse(opposite.text);
      var hy = double.parse(hypotenuse.text);
      if (ad != null && op != null && hy == null) {
        hypotenuse.text = sqrt(pow(ad, 2) + pow(op, 2)).toString();
        hypotenuse.text = roundto(hypotenuse.text);
        icon = Icons.check;
        color = Colors.green;
      } else if (ad == null && op != null && hy != null) {
        adjacent.text = sqrt(pow(hy, 2) - pow(op, 2)).toString();
        adjacent.text = roundto(adjacent.text);
        icon = Icons.check;
        color = Colors.green;
      } else if (ad != null && op == null && hy != null) {
        opposite.text = sqrt(pow(hy, 2) - pow(ad, 2)).toString();
        opposite.text = roundto(opposite.text);
        icon = Icons.check;
        color = Colors.green;
      } else if (ad != null && op != null && hy != null) {
        if (hy == sqrt(pow(ad, 2) + pow(op, 2))) {
          icon = Icons.check;
          color = Colors.green;
        } else {
          icon = Icons.cancel;
          color = Colors.red;
        }
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
        title: const Text("Pythagorean"),
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
                        controller: adjacent,
                        hintText: 'Adjacent',
                        keyboardType: TextInputType.number,
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.copy,
                        ),
                        onPressed: () async {
                          await Clipboard.setData(
                              ClipboardData(text: adjacent.text));
                          Fluttertoast.showToast(msg: 'Saved to Clipboard');
                        },
                      ),
                      Inputfield(
                        controller: opposite,
                        hintText: 'Opposite',
                        keyboardType: TextInputType.number,
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.copy,
                        ),
                        onPressed: () async {
                          await Clipboard.setData(
                              ClipboardData(text: opposite.text));
                          Fluttertoast.showToast(msg: 'Saved to Clipboard');
                        },
                      ),
                      Inputfield(
                        controller: hypotenuse,
                        hintText: 'Hypotenuse',
                        keyboardType: TextInputType.number,
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.copy,
                        ),
                        onPressed: () async {
                          await Clipboard.setData(
                              ClipboardData(text: hypotenuse.text));
                          Fluttertoast.showToast(msg: 'Saved to Clipboard');
                        },
                      ),
                      FractionallySizedBox(
                        widthFactor: 0.65,
                        child: ElevatedButton(
                          onPressed: calc,
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  (MediaQuery.of(context).platformBrightness ==
                                          Brightness.light)
                                      ? const Color.fromARGB(255, 165, 226, 255)
                                      : const Color.fromARGB(255, 0, 135, 197)),
                          child: const Text('Solve'),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Center(
                          child: Text(
                        'Is a Right Triangle:',
                        style: TextStyle(
                            color: (MediaQuery.of(context).platformBrightness ==
                                    Brightness.light)
                                ? Colors.black
                                : Colors.white),
                      )),
                      Icon(icon,
                          color: (icon == Icons.question_mark)
                              ? ((MediaQuery.of(context).platformBrightness ==
                                      Brightness.light)
                                  ? Colors.black
                                  : Colors.white)
                              : color),
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
