import 'dart:convert';

import 'package:app/Modules/card_button.dart';
import 'package:app/Modules/globalfunctions.dart';
import 'package:app/Modules/input_field.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:app/main.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:introduction_screen/introduction_screen.dart';

class VectorAddition extends StatefulWidget {
  const VectorAddition({super.key});

  @override
  State<VectorAddition> createState() => _VectorAdditionState();
}

class _VectorAdditionState extends State<VectorAddition> {
  @override
  initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      if (savedata.getBool('VectorAdditionTeaching') != true) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const VectorAdditionTeaching()));
      }
    });
    additionlist = [
      FractionallySizedBox(
        widthFactor: 0.8,
        child: Row(
          children: [
            IconButton(
                onPressed: () {
                  if (_controllers.length > 1) {
                    additionlist.removeRange(
                        additionlist.length - 2, additionlist.length - 1);
                    _controllers.removeRange(
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
      Inputfield(controller: _controllers[0])
    ];
  }

  List<Widget> additionlist = [];
  final List<TextEditingController> _controllers = [TextEditingController()];
  String _answerText = ' ';
  var vectorcalc = DegreeRad(true);
  void calc() {
    try {
      Map _distancemap = {
        'N': 0,
        'S': 0,
        'E': 0,
        'W': 0,
      };
      List _diss = [];
      for (var i in _controllers) {
        _diss.add(i.text);
      }
      for (var i in _diss) {
        if (i.isEmpty) continue;
        i.split('').forEach((char) {
          if ('1234567890[]EWSN.'.contains(char) == false)
            i = i.replaceAll(char, '');
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
        _distancemap[vector[3]] +=
            sin(vectorcalc.radians(double.parse(vector[2]))) *
                double.parse(vector[0]);
        _distancemap[vector[1]] +=
            cos(vectorcalc.radians(double.parse(vector[2]))) *
                double.parse(vector[0]);
      }
      double north = _distancemap['N'] - _distancemap['S'];
      double east = _distancemap['E'] - _distancemap['W'];
      int zerocounter = 0;
      String singledirection = '';
      _distancemap.forEach((key, value) {
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
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 0, 135, 197),
        onPressed: () {
          _controllers.add(TextEditingController());
          additionlist.add(Inputfield(
            controller: _controllers[_controllers.length - 1],
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
                tag: "Vector Addition",
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

class VectorAdditionTeaching extends StatefulWidget {
  const VectorAdditionTeaching({super.key});

  @override
  State<VectorAdditionTeaching> createState() => _VectorAdditionTeachingState();
}

class _VectorAdditionTeachingState extends State<VectorAdditionTeaching> {
  bool showval = false;
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      showDoneButton: true,
      done: const Text(
        'Done',
      ),
      onDone: (() async {
        if (showval == true) {
          savedata.setBool('VectorAdditionTeaching', true);
        }
        Navigator.pop(context);
      }),
      showNextButton: true,
      next: ElevatedButton(
        onPressed: () {},
        child: const Text('Done'),
      ),
      pages: [
        PageViewModel(
          title: '',
          bodyWidget: Column(
            children: [
              ColorText(
                text:
                    'Please Write Values in Correct Format or answers may not be accurate',
                size: 25,
              ),
              const Icon(
                Icons.check,
                color: Colors.green,
              ),
              ColorText(text: '38m[N34°E]'),
              ColorText(text: '2[S46W]'),
              ColorText(text: '65N[N]'),
              const SizedBox(
                height: 20,
              ),
              const Icon(
                Icons.circle,
                color: Colors.red,
              ),
              ColorText(text: '38m[Right]'),
              ColorText(text: '2'),
              ColorText(text: '[N]65N'),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ColorText(text: "Don't show again"),
                  Checkbox(
                    value: showval,
                    onChanged: ((value) {
                      showval = !showval;
                      setState(() {});
                    }),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
