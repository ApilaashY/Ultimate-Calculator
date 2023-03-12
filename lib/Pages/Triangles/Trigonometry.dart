import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:app/Modules/input_field.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:math';
import 'dart:convert';
import 'package:app/Modules/globalfunctions.dart';

class Trigonometry extends StatefulWidget {
  const Trigonometry({super.key});

  @override
  State<Trigonometry> createState() => _TrigonometryState();
}

class _TrigonometryState extends State<Trigonometry> {
  List controllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];
  bool degreemode = true;
  var vector = DegreeRad(true);
  void calc() {
    try {
      // Get all angles
      if (controllers[0].text.isNotEmpty && controllers[2].text.isNotEmpty) {
        controllers[4].text = (vector.fulltriangle(180) -
            double.parse(controllers[0].text) -
            double.parse(controllers[2].text));
      } else if (controllers[2].text.isNotEmpty &&
          controllers[4].text.isNotEmpty) {
        controllers[0].text = (vector.fulltriangle(180) -
            double.parse(controllers[2].text) -
            double.parse(controllers[4].text));
      } else if (controllers[0].text.isNotEmpty &&
          controllers[4].text.isNotEmpty) {
        controllers[4].text = (vector.fulltriangle(180) -
            double.parse(controllers[0].text) -
            double.parse(controllers[4].text));
      }
      // Cosline Law
      if (controllers[1].text.isNotEmpty &&
          controllers[3].text.isNotEmpty &&
          controllers[4].text.isNotEmpty) {
        controllers[5].text = (sqrt(pow(double.parse(controllers[1].text), 2) +
                pow(double.parse(controllers[3].text), 2) -
                (2 *
                    double.parse(controllers[1].text) *
                    double.parse(controllers[3].text) *
                    vector.degrees(cos(
                        vector.radians(double.parse(controllers[4].text)))))))
            .toString();
      } else if (controllers[3].text.isNotEmpty &&
          controllers[5].text.isNotEmpty &&
          controllers[0].text.isNotEmpty) {
        controllers[1].text = (sqrt(pow(double.parse(controllers[3].text), 2) +
                pow(double.parse(controllers[5].text), 2) -
                (2 *
                    double.parse(controllers[3].text) *
                    double.parse(controllers[5].text) *
                    vector.degrees(cos(
                        vector.radians(double.parse(controllers[0].text)))))))
            .toString();
      } else if (controllers[5].text.isNotEmpty &&
          controllers[1].text.isNotEmpty &&
          controllers[2].text.isNotEmpty) {
        controllers[3].text = (sqrt(pow(double.parse(controllers[5].text), 2) +
                pow(double.parse(controllers[1].text), 2) -
                (2 *
                    double.parse(controllers[5].text) *
                    double.parse(controllers[1].text) *
                    vector.degrees(cos(
                        vector.radians(double.parse(controllers[2].text)))))))
            .toString();
      } else if (controllers[1].text.isNotEmpty &&
          controllers[3].text.isNotEmpty &&
          controllers[5].text.isNotEmpty) {
        controllers[4].text = (vector.degrees(acos(vector.radians(
                    (pow(double.parse(controllers[1].text), 2) +
                            pow(double.parse(controllers[3].text), 2) -
                            pow(double.parse(controllers[5].text), 2))
                        .toDouble()) /
                vector.radians(2 *
                    double.parse(controllers[1].text) *
                    double.parse(controllers[3].text)))))
            .toString();
      }
      // Sin Law
      if (controllers[0].text.isNotEmpty && controllers[1].text.isNotEmpty) {
        if (controllers[2].text.isNotEmpty) {
          controllers[3].text = (double.parse(controllers[1].text) /
                  vector.degrees(
                      sin(vector.radians(double.parse(controllers[0].text)))) *
                  vector.degrees(
                      sin(vector.radians(double.parse(controllers[2].text)))))
              .toString();
          controllers[4].text = (vector.fulltriangle(180) -
                  double.parse(controllers[0].text) -
                  double.parse(controllers[2].text))
              .toString();
          controllers[5].text = (double.parse(controllers[1].text) /
                  vector.degrees(
                      sin(vector.radians(double.parse(controllers[0].text)))) *
                  vector.degrees(
                      sin(vector.radians(double.parse(controllers[4].text)))))
              .toString();
        } else if (controllers[3].text.isNotEmpty) {
          controllers[2].text = (vector.degrees(asin(
                  sin(vector.radians(double.parse(controllers[0].text))) /
                      double.parse(controllers[1].text) *
                      double.parse(controllers[3].text))))
              .toString();
          controllers[4].text = (vector.fulltriangle(180) -
                  double.parse(controllers[0].text) -
                  double.parse(controllers[2].text))
              .toString();
          controllers[5].text = (double.parse(controllers[1].text) /
                  vector.degrees(
                      sin(vector.radians(double.parse(controllers[0].text)))) *
                  vector.degrees(
                      sin(vector.radians(double.parse(controllers[4].text)))))
              .toString();
        } else if (controllers[4].text.isNotEmpty) {
          controllers[5].text = (double.parse(controllers[1].text) /
                  vector.degrees(
                      sin(vector.radians(double.parse(controllers[0].text)))) *
                  vector.degrees(
                      sin(vector.radians(double.parse(controllers[4].text)))))
              .toString();
          controllers[2].text = (vector.fulltriangle(180) -
                  double.parse(controllers[0].text) -
                  double.parse(controllers[4].text))
              .toString();
          controllers[3].text = (double.parse(controllers[1].text) /
                  vector.degrees(
                      sin(vector.radians(double.parse(controllers[0].text)))) *
                  vector.degrees(
                      sin(vector.radians(double.parse(controllers[2].text)))))
              .toString();
        } else if (controllers[5].text.isNotEmpty) {
          controllers[4].text = (vector.degrees(asin(
                  sin(vector.radians(double.parse(controllers[0].text))) /
                      double.parse(controllers[1].text) *
                      double.parse(controllers[5].text))))
              .toString();
          controllers[2].text = (vector.fulltriangle(180) -
                  double.parse(controllers[0].text) -
                  double.parse(controllers[4].text))
              .toString();
          controllers[3].text = (double.parse(controllers[1].text) /
                  vector.degrees(
                      sin(vector.radians(double.parse(controllers[0].text)))) *
                  vector.degrees(
                      sin(vector.radians(double.parse(controllers[2].text)))))
              .toString();
        }
      } else if (controllers[2].text.isNotEmpty &&
          controllers[3].text.isNotEmpty) {
        if (controllers[0].text.isNotEmpty) {
          controllers[1].text = (double.parse(controllers[3].text) /
                  vector.degrees(
                      sin(vector.radians(double.parse(controllers[2].text)))) *
                  vector.degrees(
                      sin(vector.radians(double.parse(controllers[0].text)))))
              .toString();
          controllers[4].text = (vector.fulltriangle(180) -
                  double.parse(controllers[0].text) -
                  double.parse(controllers[2].text))
              .toString();
          controllers[5].text = (double.parse(controllers[3].text) /
                  vector.degrees(
                      sin(vector.radians(double.parse(controllers[2].text)))) *
                  vector.degrees(
                      sin(vector.radians(double.parse(controllers[4].text)))))
              .toString();
        } else if (controllers[1].text.isNotEmpty) {
          controllers[0].text = (vector.degrees(asin(
                  sin(vector.radians(double.parse(controllers[2].text))) /
                      double.parse(controllers[3].text) *
                      double.parse(controllers[1].text))))
              .toString();
          controllers[4].text = (vector.fulltriangle(180) -
                  double.parse(controllers[0].text) -
                  double.parse(controllers[2].text))
              .toString();
          controllers[5].text = (double.parse(controllers[3].text) /
                  vector.degrees(
                      sin(vector.radians(double.parse(controllers[2].text)))) *
                  vector.degrees(
                      sin(vector.radians(double.parse(controllers[4].text)))))
              .toString();
        } else if (controllers[4].text.isNotEmpty) {
          controllers[5].text = (double.parse(controllers[3].text) /
                  vector.degrees(
                      sin(vector.radians(double.parse(controllers[2].text)))) *
                  vector.degrees(
                      sin(vector.radians(double.parse(controllers[4].text)))))
              .toString();
          controllers[0].text = (vector.fulltriangle(180) -
                  double.parse(controllers[2].text) -
                  double.parse(controllers[4].text))
              .toString();
          controllers[1].text = (double.parse(controllers[3].text) /
                  vector.degrees(
                      sin(vector.radians(double.parse(controllers[2].text)))) *
                  vector.degrees(
                      sin(vector.radians(double.parse(controllers[0].text)))))
              .toString();
        } else if (controllers[5].text.isNotEmpty) {
          controllers[4].text = (vector.degrees(asin(
                  sin(vector.radians(double.parse(controllers[2].text))) /
                      double.parse(controllers[3].text) *
                      double.parse(controllers[5].text))))
              .toString();
          controllers[0].text = (vector.fulltriangle(180) -
                  double.parse(controllers[2].text) -
                  double.parse(controllers[4].text))
              .toString();
          controllers[1].text = (double.parse(controllers[3].text) /
                  vector.degrees(
                      sin(vector.radians(double.parse(controllers[2].text)))) *
                  vector.degrees(
                      sin(vector.radians(double.parse(controllers[0].text)))))
              .toString();
        }
      } else if (controllers[4].text.isNotEmpty &&
          controllers[5].text.isNotEmpty) {
        if (controllers[0].text.isNotEmpty) {
          controllers[1].text = (double.parse(controllers[5].text) /
                  vector.degrees(
                      sin(vector.radians(double.parse(controllers[4].text)))) *
                  vector.degrees(
                      sin(vector.radians(double.parse(controllers[0].text)))))
              .toString();
          controllers[2].text = (vector.fulltriangle(180) -
                  double.parse(controllers[0].text) -
                  double.parse(controllers[4].text))
              .toString();
          controllers[3].text = (double.parse(controllers[5].text) /
                  vector.degrees(
                      sin(vector.radians(double.parse(controllers[4].text)))) *
                  vector.degrees(
                      sin(vector.radians(double.parse(controllers[2].text)))))
              .toString();
        } else if (controllers[1].text.isNotEmpty) {
          controllers[0].text = (vector.degrees(asin(
                  sin(vector.radians(double.parse(controllers[4].text))) /
                      double.parse(controllers[5].text) *
                      double.parse(controllers[1].text))))
              .toString();
          controllers[2].text = (vector.fulltriangle(180) -
                  double.parse(controllers[0].text) -
                  double.parse(controllers[4].text))
              .toString();
          controllers[3].text = (double.parse(controllers[5].text) /
                  vector.degrees(
                      sin(vector.radians(double.parse(controllers[4].text)))) *
                  vector.degrees(
                      sin(vector.radians(double.parse(controllers[2].text)))))
              .toString();
        } else if (controllers[2].text.isNotEmpty) {
          controllers[3].text = (double.parse(controllers[5].text) /
                  vector.degrees(
                      sin(vector.radians(double.parse(controllers[4].text)))) *
                  vector.degrees(
                      sin(vector.radians(double.parse(controllers[2].text)))))
              .toString();
          controllers[0].text = (vector.fulltriangle(180) -
                  double.parse(controllers[2].text) -
                  double.parse(controllers[4].text))
              .toString();
          controllers[1].text = (double.parse(controllers[5].text) /
                  vector.degrees(
                      sin(vector.radians(double.parse(controllers[4].text)))) *
                  vector.degrees(
                      sin(vector.radians(double.parse(controllers[0].text)))))
              .toString();
        } else if (controllers[3].text.isNotEmpty) {
          controllers[2].text = (vector.degrees(asin(
                  (sin(vector.radians(double.parse(controllers[4].text)))) /
                      double.parse(controllers[5].text) *
                      double.parse(controllers[3].text))))
              .toString();
          controllers[0].text = (vector.fulltriangle(180) -
                  double.parse(controllers[2].text) -
                  double.parse(controllers[4].text))
              .toString();
          controllers[1].text = (double.parse(controllers[5].text) /
                  vector.degrees(
                      sin(vector.radians(double.parse(controllers[4].text)))) *
                  vector.degrees(
                      sin(vector.radians(double.parse(controllers[0].text)))))
              .toString();
        }
      }
      addpoints(1);
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Trigonometry"),
        foregroundColor:
            (MediaQuery.of(context).platformBrightness == Brightness.light)
                ? Colors.black
                : Colors.white,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Center(
            child: FractionallySizedBox(
              heightFactor: 0.8,
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
                      FractionallySizedBox(
                        widthFactor: 0.8,
                        child: ElevatedButton(
                          onPressed: (() {
                            setState(() => degreemode = !degreemode);
                            vector = DegreeRad(degreemode);
                          }),
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 0, 135, 197)),
                          child: Text((() {
                            return (degreemode == true)
                                ? 'Degree Mode'
                                : 'Radian Mode';
                          })()),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Inputfield(
                        controller: controllers[0],
                        hintText: 'A',
                        keyboardType: TextInputType.number,
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.copy,
                        ),
                        onPressed: () async {
                          await Clipboard.setData(
                              ClipboardData(text: controllers[0].text));
                          Fluttertoast.showToast(msg: 'Saved to Clipboard');
                        },
                      ),
                      Inputfield(
                        controller: controllers[1],
                        hintText: 'a',
                        keyboardType: TextInputType.number,
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.copy,
                        ),
                        onPressed: () async {
                          await Clipboard.setData(
                              ClipboardData(text: controllers[1].text));
                          Fluttertoast.showToast(msg: 'Saved to Clipboard');
                        },
                      ),
                      Inputfield(
                        controller: controllers[2],
                        hintText: 'B',
                        keyboardType: TextInputType.number,
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.copy,
                        ),
                        onPressed: () async {
                          await Clipboard.setData(
                              ClipboardData(text: controllers[2].text));
                          Fluttertoast.showToast(msg: 'Saved to Clipboard');
                        },
                      ),
                      Inputfield(
                        controller: controllers[3],
                        hintText: 'b',
                        keyboardType: TextInputType.number,
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.copy,
                        ),
                        onPressed: () async {
                          await Clipboard.setData(
                              ClipboardData(text: controllers[3].text));
                          Fluttertoast.showToast(msg: 'Saved to Clipboard');
                        },
                      ),
                      Inputfield(
                        controller: controllers[4],
                        hintText: 'C',
                        keyboardType: TextInputType.number,
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.copy,
                        ),
                        onPressed: () async {
                          await Clipboard.setData(
                              ClipboardData(text: controllers[4].text));
                          Fluttertoast.showToast(msg: 'Saved to Clipboard');
                        },
                      ),
                      Inputfield(
                        controller: controllers[5],
                        hintText: 'c',
                        keyboardType: TextInputType.number,
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.copy,
                        ),
                        onPressed: () async {
                          await Clipboard.setData(
                              ClipboardData(text: controllers[5].text));
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
                      FractionallySizedBox(
                        widthFactor: 0.65,
                        child: ElevatedButton(
                            onPressed: () {
                              for (var i in controllers) {
                                i.text = '';
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 0, 135, 197)),
                            child: const Text('Clear')),
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
