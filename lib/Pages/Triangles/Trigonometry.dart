// ignore_for_file: file_names

import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:app/Modules/input_field.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:math';
import 'package:app/Modules/globalfunctions.dart';
import 'package:introduction_screen/introduction_screen.dart';

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
  List instructions = [
    [
      "Hello",
      "Hi",
    ],
    [
      50,
      60,
      50,
      60,
      50,
      60,
    ]
  ];
  bool degreemode = degreeDefault;
  var vector = DegreeRad(true);
  void calc() {
    instructions[0] = [];

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
      void updateNumbers() {
        controllers[0].text = (one != 0) ? roundto(one.toString()) : ""; // A
        controllers[1].text = (two != 0) ? roundto(two.toString()) : ""; // a
        controllers[2].text =
            (three != 0) ? roundto(three.toString()) : ""; // B
        controllers[3].text = (four != 0) ? roundto(four.toString()) : ""; // b
        controllers[4].text = (five != 0) ? roundto(five.toString()) : ""; // C
        controllers[5].text = (six != 0) ? roundto(six.toString()) : ""; // c
      }

      // Get all angles
      if (controllers[0].text.isNotEmpty && controllers[2].text.isNotEmpty) {
        five = (vector.fulltriangle(180) - one - three);
        instructions[0].add("C = 180 - A - B\n$five = 180 - $one - $three");
      } else if (controllers[2].text.isNotEmpty &&
          controllers[4].text.isNotEmpty) {
        one = (vector.fulltriangle(180) - three - five);
        instructions[0].add("A = 180 - B - C\n$one = 180 - $three - $five");
      } else if (controllers[0].text.isNotEmpty &&
          controllers[4].text.isNotEmpty) {
        three = (vector.fulltriangle(180) - one - five);
        instructions[0].add("B = 180 - A - C\n$three = 180 - $one - $five");
      }
      updateNumbers();
      // Cosline Law
      if (controllers[1].text.isNotEmpty &&
          controllers[3].text.isNotEmpty &&
          controllers[4].text.isNotEmpty) {
        six = (sqrt(pow(two, 2) +
            pow(four, 2) -
            (2 * two * four * vector.degrees(cos(vector.radians(five))))));
        instructions[0].add("B = 180 - A - C\n$three = 180 - $one - $five");
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
      updateNumbers();
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
      updateNumbers();
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
        actions: const [
          // IconButton(
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => TrigTeaching(
          //           instructions: instructions[0],
          //           triangle: instructions[1],
          //         ),
          //       ),
          //     );
          //   },
          //   icon: const Icon(Icons.developer_board),
          // ),
        ],
      ),
      body: Stack(
        children: [
          Center(
            child: FractionallySizedBox(
              heightFactor: 0.8,
              widthFactor: 0.8,
              child: Hero(
                tag: "Trigonometry",
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
                            child: Text(
                                "${((degreemode) ? 'Degree' : 'Radian')} Mode"),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Inputfield(
                          controller: controllers[0],
                          hintText: 'A (Angle)',
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
                          hintText: 'a (Side)',
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
                          hintText: 'B (Angle)',
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
                          hintText: 'b (Side)',
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
                          hintText: 'C (Angle)',
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
                          hintText: 'c (Side)',
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
            ),
          )
        ],
      ),
    );
  }
}

class TrigTeaching extends StatelessWidget {
  const TrigTeaching(
      {super.key, required this.instructions, required this.triangle});

  final List instructions;
  final List<int> triangle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: IntroductionScreen(
        onDone: () => Navigator.pop(context),
        done: const Text("Back"),
        showSkipButton: false,
        showNextButton: false,
        pages: instructions
            .map(
              (e) => PageViewModel(
                title: "Step ${(instructions.indexOf(e) + 1).toString()}",
                body: e,
                // image: Center(
                //   child: ClipPath(
                //     clipper: CustomTriangle(triangle: triangle),
                //     child: Container(
                //       width: 200,
                //       height: 200,
                //       color: Colors.red,
                //     ),
                //   ),
                // ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class CustomTriangle extends CustomClipper<Path> {
  CustomTriangle({required this.triangle});
  DegreeRad degreeRad = DegreeRad(true);
  List<int> triangle;

  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;

    triangle = [50, 60, 50, 80, 80, 40];

    Path path = Path();

    path.lineTo(w / 2, 0);
    path.lineTo(
        (w / 2) + (cos(degreeRad.radians(triangle[1] / 2)) * triangle[2]),
        sin(degreeRad.radians(triangle[1] / 2)) * triangle[2]);
    path.lineTo(
        (w / 2) - (cos(degreeRad.radians(triangle[3] / 2)) * triangle[4]),
        sin(degreeRad.radians(triangle[3] / 2)) * triangle[4]);
    h;
    path.lineTo(w / 2, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return true;
  }
}
