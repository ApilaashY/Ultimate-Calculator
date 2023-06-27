// ignore_for_file: file_names

import 'dart:convert';
import 'package:app/Modules/input_field.dart';
import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:app/Modules/globalfunctions.dart';

int getLCM(int a, int b) {
  return (a * b) ~/ gcd(a, b);
}

int gcd(int a, int b) {
  return a.gcd(b);
}

class LCM extends StatefulWidget {
  const LCM({super.key});

  @override
  State<LCM> createState() => _LCMState();
}

class _LCMState extends State<LCM> {
  TextEditingController numberone = TextEditingController();
  TextEditingController numbertwo = TextEditingController();
  String answerText = ' ';
  void calc() {
    try {
      setState(() {
        answerText =
            (getLCM(int.parse(numberone.text), int.parse(numbertwo.text)))
                .toString();
        answerText = roundto(answerText);
      });
      addpoints(1);
    } catch (e) {
      setState(() {
        answerText = 'Error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          foregroundColor:
              (MediaQuery.of(context).platformBrightness == Brightness.light)
                  ? Colors.black
                  : Colors.white,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: (() {
          if (MediaQuery.of(context).size.height >=
              MediaQuery.of(context).size.width) {
            return Stack(
              children: [
                Align(
                  alignment: const Alignment(0.0, 0.8),
                  child: FractionallySizedBox(
                    widthFactor: 0.8,
                    heightFactor: 0.4,
                    child: Hero(
                      tag: "LCM",
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
                                controller: numberone,
                                hintText: 'Number 1',
                                keyboardType: TextInputType.number,
                              ),
                              Inputfield(
                                controller: numbertwo,
                                hintText: 'Number 2',
                                keyboardType: TextInputType.number,
                              ),
                              FractionallySizedBox(
                                widthFactor: 0.65,
                                child: ElevatedButton(
                                  onPressed: calc,
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color.fromARGB(
                                          255, 0, 135, 197)),
                                  child: const Text('Solve'),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: const Alignment(0.0, -0.1),
                  child: IconButton(
                    icon: const Icon(
                      Icons.copy,
                    ),
                    onPressed: () async {
                      await Clipboard.setData(ClipboardData(text: answerText));
                      Fluttertoast.showToast(msg: 'Saved to Clipboard');
                    },
                  ),
                ),
                Align(
                  alignment: const Alignment(0.0, -0.65),
                  child: FractionallySizedBox(
                    widthFactor: 0.8,
                    heightFactor: 0.25,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 20,
                      child: FittedBox(
                        child: Text(
                          answerText,
                          style: TextStyle(
                            color: (MediaQuery.of(context).platformBrightness ==
                                    Brightness.light)
                                ? Colors.black
                                : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
          return Stack(
            children: [
              Align(
                alignment: const Alignment(0.8, 0.0),
                child: FractionallySizedBox(
                  widthFactor: 0.425,
                  heightFactor: 0.6,
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
                            controller: numberone,
                            hintText: 'Number 1',
                            keyboardType: TextInputType.number,
                          ),
                          Inputfield(
                            controller: numbertwo,
                            hintText: 'Number 2',
                            keyboardType: TextInputType.number,
                          ),
                          FractionallySizedBox(
                            widthFactor: 0.65,
                            child: ElevatedButton(
                              onPressed: calc,
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: (MediaQuery.of(context)
                                              .platformBrightness ==
                                          Brightness.light)
                                      ? const Color.fromARGB(255, 165, 226, 255)
                                      : const Color.fromARGB(255, 0, 135, 197)),
                              child: const Text('Solve'),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: const Alignment(-0.5, -0.9),
                child: IconButton(
                  icon: const Icon(
                    Icons.copy,
                  ),
                  onPressed: () async {
                    await Clipboard.setData(ClipboardData(text: answerText));
                    Fluttertoast.showToast(msg: 'Saved to Clipboard');
                  },
                ),
              ),
              Align(
                alignment: const Alignment(-0.8, 0.0),
                child: FractionallySizedBox(
                  widthFactor: 0.425,
                  heightFactor: 0.6,
                  child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 20,
                      child: FittedBox(
                        child: Text(
                          answerText,
                          style: TextStyle(
                            color: (MediaQuery.of(context).platformBrightness ==
                                    Brightness.light)
                                ? Colors.black
                                : Colors.white,
                          ),
                        ),
                      )),
                ),
              ),
            ],
          );
        })());
  }
}
