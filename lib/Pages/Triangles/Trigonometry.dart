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
  bool degreemode = degreeDefault;
  var vector = DegreeRad(true);
  void calc() {
    try {
      double one = (controllers[0].text.isNotEmpty)
          ? double.parse(controllers[0].text)
          : 0;
      double two = (controllers[1].text.isNotEmpty)
          ? double.parse(controllers[1].text)
          : 0;
      double three = (controllers[2].text.isNotEmpty)
          ? double.parse(controllers[2].text)
          : 0;
      double four = (controllers[3].text.isNotEmpty)
          ? double.parse(controllers[3].text)
          : 0;
      double five = (controllers[4].text.isNotEmpty)
          ? double.parse(controllers[4].text)
          : 0;
      double six = (controllers[5].text.isNotEmpty)
          ? double.parse(controllers[5].text)
          : 0;
      // Get all angles
      if (controllers[0].text.isNotEmpty && controllers[2].text.isNotEmpty) {
        five = (vector.fulltriangle(180) - one - three);
      } else if (controllers[2].text.isNotEmpty &&
          controllers[4].text.isNotEmpty) {
        one = (vector.fulltriangle(180) - three - five);
      } else if (controllers[0].text.isNotEmpty &&
          controllers[4].text.isNotEmpty) {
        five = (vector.fulltriangle(180) - one - five);
      }
      // Cosline Law
      if (controllers[1].text.isNotEmpty &&
          controllers[3].text.isNotEmpty &&
          controllers[4].text.isNotEmpty) {
        six = (sqrt(pow(two, 2) +
            pow(four, 2) -
            (2 * two * four * vector.degrees(cos(vector.radians(five))))));
      } else if (controllers[3].text.isNotEmpty &&
          controllers[5].text.isNotEmpty &&
          controllers[0].text.isNotEmpty) {
        two = (sqrt(pow(four, 2) +
            pow(six, 2) -
            (2 * four * six * vector.degrees(cos(vector.radians(one))))));
      } else if (controllers[5].text.isNotEmpty &&
          controllers[1].text.isNotEmpty &&
          controllers[2].text.isNotEmpty) {
        four = (sqrt(pow(six, 2) +
            pow(two, 2) -
            (2 * six * two * vector.degrees(cos(vector.radians(three))))));
      } else if (controllers[1].text.isNotEmpty &&
          controllers[3].text.isNotEmpty &&
          controllers[5].text.isNotEmpty) {
        five = (vector.degrees(acos(vector.radians(
                (pow(two, 2) + pow(four, 2) - pow(six, 2)).toDouble()) /
            vector.radians(2 * two * four))));
      }
      // Sin Law
      if (controllers[0].text.isNotEmpty && controllers[1].text.isNotEmpty) {
        if (controllers[2].text.isNotEmpty) {
          four = (two /
              vector.degrees(sin(vector.radians(one))) *
              vector.degrees(sin(vector.radians(three))));
          five = (vector.fulltriangle(180) - one - three);
          six = (two /
              vector.degrees(sin(vector.radians(one))) *
              vector.degrees(sin(vector.radians(five))));
        } else if (controllers[3].text.isNotEmpty) {
          three = (vector.degrees(asin(sin(vector.radians(one)) / two * four)));
          five = (vector.fulltriangle(180) - one - three);
          six = (two /
              vector.degrees(sin(vector.radians(one))) *
              vector.degrees(sin(vector.radians(five))));
        } else if (controllers[4].text.isNotEmpty) {
          six = (two /
              vector.degrees(sin(vector.radians(one))) *
              vector.degrees(sin(vector.radians(five))));
          three = (vector.fulltriangle(180) - one - five);
          four = (two /
              vector.degrees(sin(vector.radians(one))) *
              vector.degrees(sin(vector.radians(three))));
        } else if (controllers[5].text.isNotEmpty) {
          five = (vector.degrees(asin(sin(vector.radians(one)) / two * six)));
          three = (vector.fulltriangle(180) - one - five);
          four = (two /
              vector.degrees(sin(vector.radians(one))) *
              vector.degrees(sin(vector.radians(three))));
        }
      } else if (controllers[2].text.isNotEmpty &&
          controllers[3].text.isNotEmpty) {
        if (controllers[0].text.isNotEmpty) {
          two = (four /
              vector.degrees(sin(vector.radians(three))) *
              vector.degrees(sin(vector.radians(one))));
          five = (vector.fulltriangle(180) - one - three);
          six = (four /
              vector.degrees(sin(vector.radians(three))) *
              vector.degrees(sin(vector.radians(five))));
        } else if (controllers[1].text.isNotEmpty) {
          one = (vector.degrees(asin(sin(vector.radians(three)) / four * two)));
          five = (vector.fulltriangle(180) - one - three);
          six = (four /
              vector.degrees(sin(vector.radians(three))) *
              vector.degrees(sin(vector.radians(five))));
        } else if (controllers[4].text.isNotEmpty) {
          six = (four /
              vector.degrees(sin(vector.radians(three))) *
              vector.degrees(sin(vector.radians(five))));
          one = (vector.fulltriangle(180) - three - five);
          two = (four /
              vector.degrees(sin(vector.radians(three))) *
              vector.degrees(sin(vector.radians(one))));
        } else if (controllers[5].text.isNotEmpty) {
          five =
              (vector.degrees(asin(sin(vector.radians(three)) / four * six)));
          one = (vector.fulltriangle(180) - three - five);
          two = (four /
              vector.degrees(sin(vector.radians(three))) *
              vector.degrees(sin(vector.radians(one))));
        }
      } else if (controllers[4].text.isNotEmpty &&
          controllers[5].text.isNotEmpty) {
        if (controllers[0].text.isNotEmpty) {
          two = (six /
              vector.degrees(sin(vector.radians(five))) *
              vector.degrees(sin(vector.radians(one))));
          three = (vector.fulltriangle(180) - one - five);
          four = (six /
              vector.degrees(sin(vector.radians(five))) *
              vector.degrees(sin(vector.radians(three))));
        } else if (controllers[1].text.isNotEmpty) {
          one = (vector.degrees(asin(sin(vector.radians(five)) / six * two)));
          three = (vector.fulltriangle(180) - one - five);
          four = (six /
              vector.degrees(sin(vector.radians(five))) *
              vector.degrees(sin(vector.radians(three))));
        } else if (controllers[2].text.isNotEmpty) {
          four = (six /
              vector.degrees(sin(vector.radians(five))) *
              vector.degrees(sin(vector.radians(three))));
          one = (vector.fulltriangle(180) - three - five);
          two = (six /
              vector.degrees(sin(vector.radians(five))) *
              vector.degrees(sin(vector.radians(one))));
        } else if (controllers[3].text.isNotEmpty) {
          three =
              (vector.degrees(asin((sin(vector.radians(five))) / six * four)));
          one = (vector.fulltriangle(180) - three - five);
          two = (six /
              vector.degrees(sin(vector.radians(five))) *
              vector.degrees(sin(vector.radians(one))));
        }
      }
      addpoints(1);
      controllers[0].text = one.toString();
      controllers[1].text = two.toString();
      controllers[2].text = three.toString();
      controllers[3].text = four.toString();
      controllers[4].text = five.toString();
      controllers[5].text = six.toString();
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
