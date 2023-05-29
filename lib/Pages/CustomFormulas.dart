import 'dart:convert';

import 'package:app/Modules/solver.dart';
import 'package:app/Pages/Calculator.dart';
import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

Map<String, String> formulas = {
  "one": "1",
  "two": "2",
  "three": "3",
};
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
      print("Gettings");
      formulas = jsonDecode(tempData);
      print("Gettings");
    }
    return "done";
  }

  Map<String, String> formulas = {
    "one": "1",
    "two": "2",
    "three": "3",
  };
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
              key: UniqueKey(),
              itemBuilder: (context, index) {
                return FractionallySizedBox(
                    widthFactor: 0.9,
                    heightFactor: 0.9,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(formulas.keys.toList()[index]),
                      style: ElevatedButton.styleFrom(
                        elevation: 10,
                        backgroundColor: const Color.fromARGB(255, 0, 135, 197),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
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
                  _FunctionButton(
                    name: '^',
                    child: const Text(
                      'x^y',
                    ),
                  ),
                  _FunctionButton(
                    name: '√(',
                    child: const Text(
                      'x√',
                    ),
                  ),
                  _FunctionButton(
                    name: 'log(',
                    child: const Text(
                      'log',
                    ),
                  ),
                  _FunctionButton(
                    name: 'ln(',
                    child: const Text(
                      'ln',
                    ),
                  ),
                  _FunctionButton(
                    name: 'π',
                    child: const Text(
                      'π',
                    ),
                  ),
                  _FunctionButton(
                    name: '÷',
                    child: const Text(
                      '÷',
                    ),
                  ),
                  _FunctionButton(
                    name: '*',
                    child: const Text(
                      '*',
                    ),
                  ),
                  _FunctionButton(
                    name: '-',
                    child: const Text(
                      '-',
                    ),
                  ),
                  _FunctionButton(
                    name: '+',
                    child: const Text(
                      '+',
                    ),
                  ),
                  _FunctionButton(
                    name: '.',
                    child: const Text(
                      '.',
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
