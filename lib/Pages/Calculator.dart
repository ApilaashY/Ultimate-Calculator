// ignore_for_file: must_be_immutable, file_names

import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fraction/fraction.dart';
import 'package:app/Modules/globalfunctions.dart';
import 'package:app/Modules/solver.dart';

TextEditingController _controller = TextEditingController();
bool degreemode = degreeDefault;
bool deciasfrac = false;
String letters = 'abcdefghijklmnopqrstuvwxyz';
Solver solver = Solver();
List<String> history = [];

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => CalculatorState();
}

class CalculatorState extends State<Calculator> {
  CalculatorState() {
    degreemode = degreeDefault;
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
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.history),
            itemBuilder: (context) => history
                .map((e) => PopupMenuItem(
                      child: Text(e),
                      onTap: () {
                        _controller.text += e;
                        setState(() {});
                      },
                    ))
                .toList(),
            onSelected: (val) {
              _controller.text += val;
              setState(() {});
            },
          )
        ],
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
                enabled: false,
                scrollController: ScrollController(keepScrollOffset: false),
                textAlign: TextAlign.end,
                controller: _controller,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    border:
                        OutlineInputBorder(borderSide: BorderSide(width: 10))),
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
              child: Hero(
                tag: "Calculator",
                child: GridView.count(
                  crossAxisCount: 4,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  children: [
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
                      child: FractionallySizedBox(
                          widthFactor: 0.7,
                          heightFactor: 0.5,
                          child: FittedBox(
                              child: Text(
                            (deciasfrac == true) ? 'Frac' : 'Deci',
                          ))),
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
                      child: FractionallySizedBox(
                          widthFactor: 0.7,
                          heightFactor: 0.5,
                          child: FittedBox(
                              child: Text(
                            (degreemode == true) ? 'Deg' : 'Rad',
                          ))),
                    ),
                    FunctionButton(
                      name: 'Clear',
                      child: const Text(
                        'Clear',
                      ),
                    ),
                    FunctionButton(
                        name: 'backspace', child: const Icon(Icons.backspace)),
                    FunctionButton(
                      name: '(',
                      child: const Text(
                        '(',
                      ),
                    ),
                    FunctionButton(
                      name: ')',
                      child: const Text(
                        ')',
                      ),
                    ),
                    FunctionButton(
                      name: 'sin(',
                      child: const Text(
                        'sin',
                      ),
                    ),
                    FunctionButton(
                      name: 'cos(',
                      child: const Text(
                        'cos',
                      ),
                    ),
                    FunctionButton(
                      name: 'tan(',
                      child: const Text(
                        'tan',
                      ),
                    ),
                    FunctionButton(
                      name: 'sin^-1(',
                      child: const Text(
                        'sin^-1',
                      ),
                    ),
                    FunctionButton(
                      name: 'cos^-1(',
                      child: const Text(
                        'cos^-1',
                      ),
                    ),
                    FunctionButton(
                      name: 'tan^-1(',
                      child: const Text(
                        'tan^-1',
                      ),
                    ),
                    FunctionButton(
                      name: '^',
                      child: const Text(
                        'x^y',
                      ),
                    ),
                    FunctionButton(
                      name: '√(',
                      child: const Text(
                        'x√',
                      ),
                    ),
                    FunctionButton(
                      name: 'log(',
                      child: const Text(
                        'log',
                      ),
                    ),
                    FunctionButton(
                      name: 'ln(',
                      child: const Text(
                        'ln',
                      ),
                    ),
                    FunctionButton(
                      name: '7',
                      child: const Text(
                        '7',
                      ),
                    ),
                    FunctionButton(
                      name: '8',
                      child: const Text(
                        '8',
                      ),
                    ),
                    FunctionButton(
                      name: '9',
                      child: const Text(
                        '9',
                      ),
                    ),
                    FunctionButton(
                      name: 'π',
                      child: const Text(
                        'π',
                      ),
                    ),
                    FunctionButton(
                      name: '4',
                      child: const Text(
                        '4',
                      ),
                    ),
                    FunctionButton(
                      name: '5',
                      child: const Text(
                        '5',
                      ),
                    ),
                    FunctionButton(
                      name: '6',
                      child: const Text(
                        '6',
                      ),
                    ),
                    FunctionButton(
                      name: '÷',
                      child: const Text(
                        '÷',
                      ),
                    ),
                    FunctionButton(
                      name: '1',
                      child: const Text(
                        '1',
                      ),
                    ),
                    FunctionButton(
                      name: '2',
                      child: const Text(
                        '2',
                      ),
                    ),
                    FunctionButton(
                      name: '3',
                      child: const Text(
                        '3',
                      ),
                    ),
                    FunctionButton(
                      name: 'X',
                      child: const Text(
                        'X',
                      ),
                    ),
                    FunctionButton(
                      name: '.',
                      child: const Text(
                        '.',
                      ),
                    ),
                    FunctionButton(
                      name: 'Equal',
                      child: const Text(
                        '=',
                      ),
                    ),
                    FunctionButton(
                      name: '+',
                      child: const Text(
                        '+',
                      ),
                    ),
                    FunctionButton(
                      name: '-',
                      child: const Text(
                        '-',
                      ),
                    ),
                  ],
                ),
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
      child: FractionallySizedBox(
          heightFactor: 0.5, widthFactor: 0.7, child: FittedBox(child: child)),
      onPressed: () {
        if (name == 'Equal') {
          try {
            String parseText =
                _controller.text.replaceAll("X", "*").replaceAll("÷", "/");
            parseText = solver.fixBrackets(parseText);
            List<String> translation = solver.translate(parseText);
            if (history.contains(parseText)) {
              history.remove(parseText);
            }
            history.insert(0, parseText);
            double answer =
                solver.solve(translation, (degreemode) ? "Degree" : "Radian");
            _controller.text = roundto(answer.toString());

            if (deciasfrac && answer != answer.floorToDouble()) {
              _controller.text += (answer > 0) ? "+(" : "-(";
              _controller.text +=
                  Fraction.fromDouble(answer - answer.floorToDouble())
                      .toString();
              _controller.text += ")";
            }
          } catch (e) {
            _controller.text = 'Error';
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
