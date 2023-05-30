import 'dart:convert';

import 'package:app/Modules/input_field.dart';
import 'package:app/Modules/solver.dart';
import 'package:app/Pages/Calculator.dart';
import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

Map formulas = {};
TextEditingController functionName = TextEditingController();

class CustomFormulas extends StatefulWidget {
  const CustomFormulas({super.key});

  @override
  State<CustomFormulas> createState() => _CustomFormulasState();
}

class _CustomFormulasState extends State<CustomFormulas> {
  Future getFormulas() async {
    String? tempData = await savedata.getString("formulas");
    if (tempData != null) {
      formulas = jsonDecode(tempData);
    }
    return "done";
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getFormulas(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              foregroundColor: (MediaQuery.of(context).platformBrightness ==
                      Brightness.light)
                  ? Colors.black
                  : Colors.white,
            ),
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add),
              backgroundColor: const Color.fromARGB(255, 255, 184, 0),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        actions: [
                          const Text(
                            "Enter the name of your new formula",
                            textAlign: TextAlign.center,
                          ),
                          TextField(
                            controller: functionName,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                if (functionName.text.isNotEmpty &&
                                    formulas[functionName.text] == null) {
                                  Navigator.pushNamed(context, "Formula Maker");
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "Name empty or already taken");
                                }
                              },
                              child: const Text("Create"))
                        ],
                      );
                    });
              },
            ),
            body: GridView.builder(
              itemBuilder: (context, index) {
                return FractionallySizedBox(
                    widthFactor: 0.9,
                    heightFactor: 0.9,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "Formula Calculator",
                            arguments: formulas.keys.toList()[index]);
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 10,
                        backgroundColor:
                            (MediaQuery.of(context).platformBrightness ==
                                    Brightness.light)
                                ? const Color.fromARGB(255, 165, 226, 255)
                                : const Color.fromARGB(255, 0, 135, 197),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                      child: FractionallySizedBox(
                        widthFactor: 0.6,
                        heightFactor: 0.6,
                        child: FittedBox(
                          child: Text(
                            formulas.keys.toList()[index],
                            style: TextStyle(
                                color: (MediaQuery.of(context)
                                            .platformBrightness ==
                                        Brightness.light)
                                    ? Colors.black
                                    : Colors.white),
                          ),
                        ),
                      ),
                    ));
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemCount: formulas.length,
            ),
          );
        }
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

TextEditingController _controller = TextEditingController();

class FormulaMaker extends StatefulWidget {
  const FormulaMaker({Key? key}) : super(key: key);

  @override
  State<FormulaMaker> createState() => _FormulaMakerState();
}

class _FormulaMakerState extends State<FormulaMaker> {
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
          IconButton(
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  formulas[functionName.text] = _controller.text;
                  savedata.setString("formulas", jsonEncode(formulas));
                  Navigator.pop(context);
                  Navigator.pop(context);
                  print("Saved");
                } else {
                  Fluttertoast.showToast(msg: "Formula empty or invalid");
                }
              },
              icon: const Icon(Icons.done)),
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
                scrollController: ScrollController(keepScrollOffset: false),
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
                  _FunctionButton(
                    name: 'Clear',
                    child: const Text(
                      'Clear',
                    ),
                  ),
                  _FunctionButton(
                      name: 'backspace', child: const Icon(Icons.backspace)),
                  _FunctionButton(
                    name: '(',
                    child: const Text(
                      '(',
                    ),
                  ),
                  _FunctionButton(
                    name: ')',
                    child: const Text(
                      ')',
                    ),
                  ),
                  _FunctionButton(
                    name: "x",
                    child: const Text("x"),
                  ),
                  _FunctionButton(
                    name: "y",
                    child: const Text("y"),
                  ),
                  _FunctionButton(
                    name: "z",
                    child: const Text("z"),
                  ),
                  _FunctionButton(
                    name: "a",
                    child: const Text("a"),
                  ),
                  _FunctionButton(
                    name: "b",
                    child: const Text("b"),
                  ),
                  _FunctionButton(
                    name: "c",
                    child: const Text("c"),
                  ),
                  _FunctionButton(
                    name: 'sin(',
                    child: const Text(
                      'sin',
                    ),
                  ),
                  _FunctionButton(
                    name: 'cos(',
                    child: const Text(
                      'cos',
                    ),
                  ),
                  _FunctionButton(
                    name: 'tan(',
                    child: const Text(
                      'tan',
                    ),
                  ),
                  _FunctionButton(
                    name: 'sin^-1(',
                    child: const Text(
                      'sin^-1',
                    ),
                  ),
                  _FunctionButton(
                    name: 'cos^-1(',
                    child: const Text(
                      'cos^-1',
                    ),
                  ),
                  _FunctionButton(
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
                    child: Text(
                      'x√',
                    ),
                  ),
                  FunctionButton(
                    name: 'log(',
                    child: Text(
                      'log',
                    ),
                  ),
                  FunctionButton(
                    name: 'ln(',
                    child: Text(
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
        ],
      ),
    );
  }
}

class _FunctionButton extends StatelessWidget {
  _FunctionButton({
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
        if (name == 'Clear') {
          _controller.text = '';
        } else if (name == 'backspace') {
          if (_controller.text.isNotEmpty == true) {
            _controller.text =
                _controller.text.substring(0, _controller.text.length - 1);
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

class FormulaCalculator extends StatefulWidget {
  FormulaCalculator({required this.name});
  String name;

  @override
  State<FormulaCalculator> createState() => _FormulaCalculatorState(name: name);
}

class _FormulaCalculatorState extends State<FormulaCalculator> {
  _FormulaCalculatorState({required this.name}) {
    formula = formulas[name];
    print(name);
    print(solver.translate(formula));
    list = [
      Inputfield(
        controller: TextEditingController(text: formula),
        enabled: false,
        suffixText: "Formula",
      ),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text((degree) ? "Degree Mode" : "Radian Mode"),
        Switch.adaptive(
            value: degree,
            onChanged: (val) {
              degree = val;
              setState(() {});
            })
      ]),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text((deciAsFrac) ? "Decimals" : "Fractions"),
        Switch.adaptive(
            value: deciAsFrac,
            onChanged: (val) {
              deciAsFrac = val;
              setState(() {});
            })
      ]),
    ];
  }
  Solver solver = new Solver();
  String name;
  String formula = "";
  bool degree = true;
  bool deciAsFrac = false;
  List<Widget> list = []

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor:
            (MediaQuery.of(context).platformBrightness == Brightness.light)
                ? Colors.black
                : Colors.white,
        title: Text(name),
      ),
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.8,
          heightFactor: 0.5,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 20,
            child: ListView.builder(
              children:
            ),
          ),
        ),
      ),
    );
  }
}
