// ignore_for_file: no_logic_in_create_state

import 'package:app/Modules/globalfunctions.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class VectorAddition extends StatefulWidget {
  const VectorAddition({super.key});

  @override
  State<VectorAddition> createState() => _VectorAdditionState();
}

class _VectorAdditionState extends State<VectorAddition> {
  late List<Widget> additionlist = [
    FractionallySizedBox(
      widthFactor: 0.8,
      child: Row(
        children: [
          IconButton(
              onPressed: () {
                if (_quantityControllers.length > 1) {
                  additionlist.removeRange(
                      additionlist.length - 2, additionlist.length - 1);
                  _quantityControllers.removeRange(
                      additionlist.length - 2, additionlist.length - 1);
                }
                setState(() {});
              },
              icon: const Icon(Icons.delete)),
          Expanded(
              child: ElevatedButton(
            onPressed: calc,
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 0, 135, 197)),
            child: const Text('Solve'),
          )),
        ],
      ),
    ),
    VectorInput(
        quantity: _quantityControllers[0],
        start: _startDirectionControllers[0],
        end: _endDirectionControllers[0],
        degree: _degreeControllers[0])
  ];

  final List<TextEditingController> _quantityControllers = [
    TextEditingController()
  ];
  final List<List<String>> _startDirectionControllers = [
    ["N"]
  ];
  final List<TextEditingController> _degreeControllers = [
    TextEditingController()
  ];
  final List<List<String>> _endDirectionControllers = [
    ["E"]
  ];
  String _answerText = ' ';
  var vectorcalc = DegreeRad(true);
  void calc() {
    try {
      Map distancemap = {
        'N': 0,
        'S': 0,
        'E': 0,
        'W': 0,
      };
      List diss = [];
      for (int i = 0; i < _quantityControllers.length; i++) {
        diss.add(
            "${_quantityControllers[i].text}[${_startDirectionControllers[i][0]}${_degreeControllers[i].text}${_endDirectionControllers[i][0]}]");
        print(diss.last);
      }
      for (var i in diss) {
        if (i.isEmpty) continue;
        i.split('').forEach((char) {
          if ('1234567890[]EWSN.'.contains(char) == false) {
            i = i.replaceAll(char, '');
          }
        });
        List vector = i.split('[');
        vector[1] = vector[1].replaceAll(']', '');
        String total = '';
        vector[0].split('').forEach((char) {
          try {
            double.parse(char);
            total += char;
          } catch (e) {
            if (char == '.') {
              total += char;
            }
          }
        });
        vector[0] = total;
        if (vector[1].length == 1) {
          if (vector[1] == 'N' || vector[1] == 'S') {
            vector[1] += '0E';
          } else if (vector[1] == 'E' || vector[1] == 'W') {
            vector[1] += '0N';
          }
        }
        vector.add(vector[1][0].toString());
        vector.add(vector[1].substring(1, vector[1].length - 1).toString());
        vector.add(vector[1][vector[1].length - 1].toString());
        vector.removeAt(1);
        distancemap[vector[3]] +=
            sin(vectorcalc.radians(double.parse(vector[2]))) *
                double.parse(vector[0]);
        distancemap[vector[1]] +=
            cos(vectorcalc.radians(double.parse(vector[2]))) *
                double.parse(vector[0]);
      }
      double north = distancemap['N'] - distancemap['S'];
      double east = distancemap['E'] - distancemap['W'];
      int zerocounter = 0;
      String singledirection = '';
      distancemap.forEach((key, value) {
        if (value == 0) {
          zerocounter += 1;
        } else {
          singledirection = key;
        }
      });
      if (zerocounter >= 3) {
        _answerText =
            '${roundto(sqrt(pow(north, 2) + pow(east, 2)).toString())}\n[$singledirection]';
      } else {
        if (north < 0 && east > 0) {
          _answerText =
              '${roundto(sqrt(pow(north, 2) + pow(east, 2)).toString())}\n[S${roundto((vectorcalc.degrees(atan(east / -north))).toString())}°E]';
        } else if (north > 0 && east < 0) {
          _answerText =
              '${roundto(sqrt(pow(north, 2) + pow(east, 2)).toString())}\n[N${roundto((vectorcalc.degrees(atan(-east / north))).toString())}°W]';
        } else if (north < 0 && east < 0) {
          _answerText =
              '${roundto(sqrt(pow(north, 2) + pow(east, 2)).toString())}\n[S${roundto((vectorcalc.degrees(atan(-east / -north))).toString())}°W]';
        } else {
          _answerText =
              '${roundto(sqrt(pow(north, 2) + pow(east, 2)).toString())}\n[N${roundto((vectorcalc.degrees(atan(east / north))).toString())}°E]';
        }
      }
      addpoints(1);
      setState(() {});
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor:
            (MediaQuery.of(context).platformBrightness == Brightness.light)
                ? Colors.black
                : Colors.white,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () => showModalBottomSheet(
                  context: context,
                  builder: (context) => const FractionallySizedBox(
                        widthFactor: 0.8,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InstructionText(
                                text: "Quantity: Scalar value\nof vector"),
                            InstructionText(
                                text:
                                    "Start Direction: Direction\nto start from"),
                            InstructionText(
                                text:
                                    "Degree (°): Degree offset from\nstart direction"),
                            InstructionText(
                                text:
                                    "End Offset: Direction\nof degree offset"),
                          ],
                        ),
                      )),
              icon: const Icon(Icons.question_mark))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 0, 135, 197),
        onPressed: () {
          _quantityControllers.add(TextEditingController());
          _startDirectionControllers.add(["N"]);
          _degreeControllers.add(TextEditingController());
          _endDirectionControllers.add(["E"]);
          additionlist.add(VectorInput(
            quantity: _quantityControllers[_quantityControllers.length - 1],
            start: _startDirectionControllers[
                _startDirectionControllers.length - 1],
            end: _endDirectionControllers[_endDirectionControllers.length - 1],
            degree: _degreeControllers[_degreeControllers.length - 1],
          ));
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
      body: Stack(
        children: [
          Align(
            alignment: (MediaQuery.of(context).size.height >
                    MediaQuery.of(context).size.width)
                ? const Alignment(0, -1)
                : const Alignment(-0.95, 0),
            child: FractionallySizedBox(
              widthFactor: (MediaQuery.of(context).size.height >
                      MediaQuery.of(context).size.width)
                  ? 0.8
                  : 0.425,
              heightFactor: (MediaQuery.of(context).size.height >
                      MediaQuery.of(context).size.width)
                  ? 0.15
                  : 0.6,
              child: FittedBox(
                  child: Text(
                _answerText,
                style: TextStyle(
                    color: (MediaQuery.of(context).platformBrightness ==
                            Brightness.light)
                        ? Colors.black
                        : Colors.white),
              )),
            ),
          ),
          Align(
            alignment: (MediaQuery.of(context).size.height >
                    MediaQuery.of(context).size.width)
                ? const Alignment(0, -0.65)
                : const Alignment(-0.6, -0.9),
            child: IconButton(
              icon: const Icon(
                Icons.copy,
              ),
              onPressed: () async {
                await Clipboard.setData(ClipboardData(text: _answerText));
                Fluttertoast.showToast(msg: 'Saved to Clipboard');
              },
            ),
          ),
          Align(
            alignment: (MediaQuery.of(context).size.height >
                    MediaQuery.of(context).size.width)
                ? const Alignment(0, 0.5)
                : const Alignment(0.7, -0.5),
            child: FractionallySizedBox(
              widthFactor: (MediaQuery.of(context).size.height >
                      MediaQuery.of(context).size.width)
                  ? 0.8
                  : 0.45,
              heightFactor: (MediaQuery.of(context).size.height >
                      MediaQuery.of(context).size.width)
                  ? 0.7
                  : 0.9,
              child: Hero(
                tag: "2D Vector Addition",
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 20,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: ListView.builder(
                      itemCount: additionlist.length,
                      itemBuilder: ((context, index) {
                        return additionlist[index];
                      }),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class VectorInput extends StatefulWidget {
  const VectorInput(
      {super.key,
      required this.quantity,
      required this.start,
      required this.end,
      required this.degree});

  final TextEditingController quantity, degree;
  final List<String> start, end;

  @override
  State<VectorInput> createState() => _VectorInputState(
      quantity: quantity, start: start, end: end, degree: degree);
}

class _VectorInputState extends State<VectorInput> {
  _VectorInputState(
      {required this.quantity,
      required this.start,
      required this.end,
      required this.degree});

  final TextEditingController quantity, degree;
  List<String> start, end;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.9,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: TextField(
              controller: quantity,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: "Quantity",
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 3),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton(
              value: start[0],
              items: ["N", "S", "E", "W"]
                  .map((element) => DropdownMenuItem(
                        value: element,
                        child: Text(element),
                      ))
                  .toList(),
              onChanged: (element) {
                if ((start[0] == "N" || start[0] == "S") &&
                    (element == "E" || element == "W")) {
                  end[0] = "N";
                } else if ((start[0] == "E" || start[0] == "W") &&
                    (element == "N" || element == "S")) {
                  end[0] = "E";
                }
                start[0] = element!.toString();
                setState(() {});
              },
            ),
          ),
          Form(
            key: formKey,
            child: Expanded(
              child: TextFormField(
                maxLength: 3,
                controller: degree,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  counterText: "",
                  hintText: "°",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 3),
                  ),
                ),
                onChanged: (val) {
                  formKey.currentState!.validate();
                },
                validator: (val) {
                  try {
                    if (val!.isEmpty) {
                      return null;
                    }
                    double.parse(val);
                    return null;
                  } catch (e) {
                    return "Not a number";
                  }
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton(
              value: end[0],
              items: ((start[0] == "N" || start[0] == "S")
                      ? ["E", "W"]
                      : ["N", "S"])
                  .map((element) => DropdownMenuItem(
                        value: element,
                        child: Text(element),
                      ))
                  .toList(),
              onChanged: (element) {
                setState(() {
                  end[0] = element!.toString();
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class InstructionText extends StatelessWidget {
  const InstructionText({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FittedBox(
        child: Text(
          text,
          style: TextStyle(
              color: (MediaQuery.of(context).platformBrightness ==
                      Brightness.light)
                  ? Colors.black
                  : Colors.white),
        ),
      ),
    );
  }
}
