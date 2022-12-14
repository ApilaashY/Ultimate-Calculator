import 'dart:convert';
import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fraction/fraction.dart';
import 'package:function_tree/function_tree.dart';
import 'package:app/Modules/globalfunctions.dart';

TextEditingController _controller = TextEditingController();
bool degreemode = true;
bool deciasfrac = false;
String letters = 'abcdefghijklmnopqrstuvwxyz';

class Calculator extends StatefulWidget {
  @override
  State<Calculator> createState() => CalculatorState();
}

class CalculatorState extends State<Calculator> {
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
      body: Stack(
        children: [
          Align(
            alignment: (MediaQuery.of(context).size.height >
                    MediaQuery.of(context).size.width)
                ? const Alignment(0.0, -0.9)
                : const Alignment(-0.7, -0.7),
            child: IconButton(
              icon: const Icon(
                Icons.copy,
              ),
              onPressed: () async {
                await Clipboard.setData(ClipboardData(text: _controller.text));
                Fluttertoast.showToast(msg: 'Saved to Clipboard');
              },
            ),
          ),
          Align(
            alignment: (MediaQuery.of(context).size.height >
                    MediaQuery.of(context).size.width)
                ? const Alignment(0.0, -0.8)
                : const Alignment(-0.9, -0.3),
            child: FractionallySizedBox(
              widthFactor: (MediaQuery.of(context).size.height >
                      MediaQuery.of(context).size.width)
                  ? 0.95
                  : 0.3,
              child: TextField(
                scrollController: ScrollController(keepScrollOffset: false),
                autofocus: true,
                readOnly: true,
                textAlign: TextAlign.end,
                controller: _controller,
                keyboardType: TextInputType.number,
                style: TextStyle(
                    fontSize: 35,
                    color: (MediaQuery.of(context).platformBrightness ==
                            Brightness.light)
                        ? Colors.black
                        : Colors.white),
              ),
            ),
          ),
          Align(
            alignment: (MediaQuery.of(context).size.height >
                    MediaQuery.of(context).size.width)
                ? const Alignment(0.0, 0.8)
                : const Alignment(0.9, -0.2),
            child: FractionallySizedBox(
              heightFactor: (MediaQuery.of(context).size.height >
                      MediaQuery.of(context).size.width)
                  ? 0.7
                  : 0.9,
              widthFactor: (MediaQuery.of(context).size.height >
                      MediaQuery.of(context).size.width)
                  ? 0.95
                  : 0.6,
              child: GridView.count(
                scrollDirection: (MediaQuery.of(context).size.height >
                        MediaQuery.of(context).size.width)
                    ? Axis.vertical
                    : Axis.horizontal,
                crossAxisCount: 4,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                children: [
                  const SizedBox(),
                  const SizedBox(),
                  const SizedBox(),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromARGB(255, 0, 135, 197)),
                        shape: MaterialStateProperty.all<CircleBorder>(
                            const CircleBorder())),
                    onPressed: () {
                      deciasfrac = !deciasfrac;
                      setState(() {});
                    },
                    onLongPress: (() {
                      showDialog(
                        context: context,
                        builder: (context) => const SimpleDialog(
                          title: Text('Represent Decimals as Fractions'),
                        ),
                      );
                    }),
                    child: Text(
                      (deciasfrac == true) ? 'Frac' : 'Deci',
                      style: TextStyle(
                          fontSize: (MediaQuery.of(context).size.height >
                                  MediaQuery.of(context).size.width)
                              ? 20
                              : 12),
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromARGB(255, 0, 135, 197)),
                        shape: MaterialStateProperty.all<CircleBorder>(
                            const CircleBorder())),
                    onPressed: () {
                      degreemode = !degreemode;
                      setState(() {});
                    },
                    child: Text(
                      (degreemode == true) ? 'Deg' : 'Rad',
                      style: TextStyle(
                          fontSize: (MediaQuery.of(context).size.height >
                                  MediaQuery.of(context).size.width)
                              ? 30
                              : 15),
                    ),
                  ),
                  FunctionButton(
                    name: '(',
                    child: const Text(
                      '(',
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                  FunctionButton(
                    name: ')',
                    child: const Text(
                      ')',
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                  FunctionButton(
                    name: 'Clear',
                    child: Text(
                      'Clear',
                      style: TextStyle(
                          fontSize: (MediaQuery.of(context).size.height >
                                  MediaQuery.of(context).size.width)
                              ? 18
                              : 10),
                    ),
                  ),
                  FunctionButton(
                    name: 'sin(',
                    child: Text(
                      'sin',
                      style: TextStyle(
                          fontSize: (MediaQuery.of(context).size.height >
                                  MediaQuery.of(context).size.width)
                              ? 30
                              : 15),
                    ),
                  ),
                  FunctionButton(
                    name: 'cos(',
                    child: Text(
                      'cos',
                      style: TextStyle(
                          fontSize: (MediaQuery.of(context).size.height >
                                  MediaQuery.of(context).size.width)
                              ? 30
                              : 15),
                    ),
                  ),
                  FunctionButton(
                    name: 'tan(',
                    child: Text(
                      'tan',
                      style: TextStyle(
                          fontSize: (MediaQuery.of(context).size.height >
                                  MediaQuery.of(context).size.width)
                              ? 30
                              : 15),
                    ),
                  ),
                  FunctionButton(
                    name: '^',
                    child: Image.asset('assets/Calculator/Exponent.png'),
                  ),
                  FunctionButton(
                    name: 'sin^-1(',
                    child: const Text(
                      'sin^-1',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  FunctionButton(
                    name: 'cos^-1(',
                    child: const Text(
                      'cos^-1',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  FunctionButton(
                    name: 'tan^-1(',
                    child: const Text(
                      'tan^-1',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  FunctionButton(
                    name: '2√',
                    child: Text(
                      '2√',
                      style: TextStyle(
                          fontSize: (MediaQuery.of(context).size.height >
                                  MediaQuery.of(context).size.width)
                              ? 30
                              : 15),
                    ),
                  ),
                  FunctionButton(
                    name: 'log(',
                    child: Text(
                      'log',
                      style: TextStyle(
                          fontSize: (MediaQuery.of(context).size.height >
                                  MediaQuery.of(context).size.width)
                              ? 30
                              : 15),
                    ),
                  ),
                  FunctionButton(
                    name: 'π',
                    child: const Text(
                      'π',
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                  FunctionButton(
                    name: 'abs(',
                    child: Text(
                      'abs',
                      style: TextStyle(
                          fontSize: (MediaQuery.of(context).size.height >
                                  MediaQuery.of(context).size.width)
                              ? 30
                              : 15),
                    ),
                  ),
                  FunctionButton(
                      name: 'backspace', child: const Icon(Icons.backspace)),
                  FunctionButton(
                    name: '7',
                    child: const Text(
                      '7',
                      style: TextStyle(fontSize: 50),
                    ),
                  ),
                  FunctionButton(
                    name: '8',
                    child: const Text(
                      '8',
                      style: TextStyle(fontSize: 50),
                    ),
                  ),
                  FunctionButton(
                    name: '9',
                    child: const Text(
                      '9',
                      style: TextStyle(fontSize: 50),
                    ),
                  ),
                  FunctionButton(
                    name: '÷',
                    child: const Text(
                      '÷',
                      style: TextStyle(fontSize: 50),
                    ),
                  ),
                  FunctionButton(
                    name: '4',
                    child: const Text(
                      '4',
                      style: TextStyle(fontSize: 50),
                    ),
                  ),
                  FunctionButton(
                    name: '5',
                    child: const Text(
                      '5',
                      style: TextStyle(fontSize: 50),
                    ),
                  ),
                  FunctionButton(
                    name: '6',
                    child: const Text(
                      '6',
                      style: TextStyle(fontSize: 50),
                    ),
                  ),
                  FunctionButton(
                    name: 'x',
                    child: const Text(
                      'x',
                      style: TextStyle(fontSize: 50),
                    ),
                  ),
                  FunctionButton(
                    name: '1',
                    child: const Text(
                      '1',
                      style: TextStyle(fontSize: 50),
                    ),
                  ),
                  FunctionButton(
                    name: '2',
                    child: const Text(
                      '2',
                      style: TextStyle(fontSize: 50),
                    ),
                  ),
                  FunctionButton(
                    name: '3',
                    child: const Text(
                      '3',
                      style: TextStyle(fontSize: 50),
                    ),
                  ),
                  FunctionButton(
                    name: '-',
                    child: const Text(
                      '-',
                      style: TextStyle(fontSize: 50),
                    ),
                  ),
                  FunctionButton(
                    name: '0',
                    child: const Text(
                      '0',
                      style: TextStyle(fontSize: 50),
                    ),
                  ),
                  FunctionButton(
                    name: '.',
                    child: const Text(
                      '.',
                      style: TextStyle(fontSize: 50),
                    ),
                  ),
                  FunctionButton(
                    name: 'Equal',
                    child: const Text(
                      '=',
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                  FunctionButton(
                    name: '+',
                    child: const Text(
                      '+',
                      style: TextStyle(fontSize: 50),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FunctionButton extends StatelessWidget {
  FunctionButton({
    super.key,
    this.child = const Text('Hi'),
    this.name = 'Nothing',
  });
  Widget child;
  String name;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              const Color.fromARGB(255, 0, 135, 197)),
          shape: MaterialStateProperty.all<CircleBorder>(const CircleBorder())),
      child: child,
      onPressed: () {
        if (name == 'Equal') {
          _controller.text = _controller.text.replaceAll('x', '*');
          _controller.text = _controller.text.replaceAll('÷', '/');
          _controller.text = _controller.text.replaceAll('π', '(pi)');
          if (degreemode == true) {
            String degreeequation = _controller.text;
            degreeequation = degreeequation.replaceAll('sin(', 'sin((pi/180)*');
            degreeequation = degreeequation.replaceAll('cos(', 'cos((pi/180)*');
            degreeequation = degreeequation.replaceAll('tan(', 'tan((pi/180)*');
            degreeequation =
                degreeequation.replaceAll('sin^-1(', 'sin^-1((pi/180)*');
            degreeequation =
                degreeequation.replaceAll('cos^-1(', 'cos^-1((pi/180)*');
            degreeequation =
                degreeequation.replaceAll('tan^-1(', 'tan^-1((pi/180)*');
            List brackets = [];
            degreeequation.split('').forEach((var i) {
              if (i == '(') {
                brackets.add('(');
              } else if (i == ')') {
                try {
                  brackets.removeAt(0);
                } catch (e) {}
              }
            });
            for (var _ in brackets) {
              degreeequation += ')';
            }
            try {
              String calc = degreeequation.interpret().toString();
              if (deciasfrac == true) {
                if (double.parse(calc) != double.parse(calc).floor()) {
                  double decimal =
                      double.parse(calc) - double.parse(calc).floor();
                  _controller.text =
                      '${double.parse(calc).floor()} ${Fraction.fromDouble(decimal)}';
                } else {
                  _controller.text = roundto(calc);
                }
              } else {
                _controller.text = roundto(calc);
              }
            } catch (e) {
              _controller.text = 'Error';
            }
          } else {
            List brackets = [];
            _controller.text.split('').forEach((var i) {
              if (i == '(') {
                brackets.add('(');
              } else if (i == ')') {
                try {
                  brackets.removeAt(0);
                } catch (e) {}
              }
              for (var _ in brackets) {
                _controller.text += ')';
              }
            });
            try {
              String calc = _controller.text.interpret().toString();
              if (deciasfrac == true) {
                if (double.parse(calc) != double.parse(calc).floor()) {
                  double decimal =
                      double.parse(calc) - double.parse(calc).floor();
                  _controller.text =
                      '${double.parse(calc).floor()} ${Fraction.fromDouble(decimal)}';
                } else {
                  _controller.text = roundto(calc);
                }
              } else {
                _controller.text = roundto(calc);
              }
            } catch (e) {
              _controller.text = 'Error';
            }
          }
        } else if (name == 'Clear') {
          _controller.text = '';
        } else if (name == 'modeselect') {
          degreemode = !degreemode;
        } else if (name == 'backspace') {
          if (_controller.text.isNotEmpty == true) {
            if (letters
                .contains(_controller.text[_controller.text.length - 1])) {
              _controller.text =
                  _controller.text.substring(0, _controller.text.length - 3);
            } else {
              _controller.text =
                  _controller.text.substring(0, _controller.text.length - 1);
            }
          }
        } else if (name == '.') {
          if (_controller.text[_controller.text.length - 1] != '.') {
            _controller.text += name.toString();
          }
        } else {
          _controller.text += name.toString();
        }
      },
    );
  }
}
