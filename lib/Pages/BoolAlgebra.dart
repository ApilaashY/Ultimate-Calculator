// ignore_for_file: must_be_immutable, file_names

import 'package:app/Modules/input_field.dart';
import 'package:app/Modules/globalfunctions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:app/Modules/solver.dart';

TextEditingController _controller = TextEditingController();
boolAlgebraSolver boolSolver = boolAlgebraSolver();
List<String> boolHistory = [];
String letters = 'abcdefghijklmnopqrstuvwxyz';

class BoolCalculator extends StatefulWidget {
  const BoolCalculator({super.key});

  @override
  State<BoolCalculator> createState() => BoolCalculatorState();
}

class BoolCalculatorState extends State<BoolCalculator> {
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
            itemBuilder: (context) => boolHistory
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
          FractionallySizedBox(
            heightFactor: 0.3,
            child: Center(
              child: Column(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.copy,
                    ),
                    onPressed: () async {
                      await Clipboard.setData(
                          ClipboardData(text: _controller.text));
                      Fluttertoast.showToast(msg: 'Saved to Clipboard');
                    },
                  ),
                  FractionallySizedBox(
                    widthFactor: (MediaQuery.of(context).size.height >
                            MediaQuery.of(context).size.width)
                        ? 0.95
                        : 0.3,
                    child: TextField(
                      enabled: false,
                      scrollController:
                          ScrollController(keepScrollOffset: false),
                      textAlign: TextAlign.end,
                      controller: _controller,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 10))),
                      style: TextStyle(
                          fontSize: 35,
                          color: (MediaQuery.of(context).platformBrightness ==
                                  Brightness.light)
                              ? Colors.black
                              : Colors.white),
                    ),
                  ),
                ],
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
                tag: "Boolean Calculator",
                child: GridView.count(
                  crossAxisCount: 4,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  children: [
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
                      name: '1',
                      child: const Text(
                        '1',
                      ),
                    ),
                    FunctionButton(
                      name: '0',
                      child: const Text(
                        '0',
                      ),
                    ),
                    FunctionButton(
                      name: '+',
                      child: const Text(
                        '+',
                      ),
                    ),
                    FunctionButton(
                      name: 'X',
                      child: const Text(
                        'X',
                      ),
                    ),
                    FunctionButton(
                      name: 'Equal',
                      child: const Text(
                        '=',
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
            String equation = _controller.text;
            List<String> translation = boolSolver.translate(_controller.text);
            _controller.text = boolSolver.solve(translation).toString();
            boolHistory.insert(0, equation);
            addpoints(1);
          } catch (e) {
            _controller.text = 'Error';
          }
        } else if (name == 'Clear') {
          _controller.text = '';
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

TextEditingController _testCaseController = TextEditingController();

class TestCases extends StatefulWidget {
  const TestCases({super.key});

  @override
  State<TestCases> createState() => TestCasesState();
}

class TestCasesState extends State<TestCases> {
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
            itemBuilder: (context) => boolHistory
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
          FractionallySizedBox(
            heightFactor: 0.3,
            child: Center(
              child: Column(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.copy,
                    ),
                    onPressed: () async {
                      await Clipboard.setData(
                          ClipboardData(text: _testCaseController.text));
                      Fluttertoast.showToast(msg: 'Saved to Clipboard');
                    },
                  ),
                  FractionallySizedBox(
                    widthFactor: (MediaQuery.of(context).size.height >
                            MediaQuery.of(context).size.width)
                        ? 0.95
                        : 0.3,
                    child: TextField(
                      enabled: false,
                      scrollController:
                          ScrollController(keepScrollOffset: false),
                      textAlign: TextAlign.end,
                      controller: _testCaseController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 10))),
                      style: TextStyle(
                          fontSize: 35,
                          color: (MediaQuery.of(context).platformBrightness ==
                                  Brightness.light)
                              ? Colors.black
                              : Colors.white),
                    ),
                  ),
                ],
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
                tag: "Test Cases",
                child: GridView.count(
                  crossAxisCount: 4,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  children: [
                    TestCaseFunctionButton(
                      name: 'Clear',
                      child: const Text(
                        'Clear',
                      ),
                    ),
                    TestCaseFunctionButton(
                        name: 'backspace', child: const Icon(Icons.backspace)),
                    TestCaseFunctionButton(
                      name: '(',
                      child: const Text(
                        '(',
                      ),
                    ),
                    TestCaseFunctionButton(
                      name: ')',
                      child: const Text(
                        ')',
                      ),
                    ),
                    TestCaseFunctionButton(
                      name: 'x',
                      child: const Text(
                        'x',
                      ),
                    ),
                    TestCaseFunctionButton(
                      name: 'y',
                      child: const Text(
                        'y',
                      ),
                    ),
                    TestCaseFunctionButton(
                      name: 'z',
                      child: const Text(
                        'z',
                      ),
                    ),
                    TestCaseFunctionButton(
                      name: 'a',
                      child: const Text(
                        'a',
                      ),
                    ),
                    TestCaseFunctionButton(
                      name: 'b',
                      child: const Text(
                        'b',
                      ),
                    ),
                    TestCaseFunctionButton(
                      name: 'c',
                      child: const Text(
                        'c',
                      ),
                    ),
                    TestCaseFunctionButton(
                      name: '+',
                      child: const Text(
                        '+',
                      ),
                    ),
                    TestCaseFunctionButton(
                      name: 'X',
                      child: const Text(
                        'X',
                      ),
                    ),
                    TestCaseFunctionButton(
                      name: 'Equal',
                      child: const Text(
                        '=',
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

class TestCaseFunctionButton extends StatelessWidget {
  TestCaseFunctionButton({
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
          List<TableRow> answers;

          try {
            List<String> translation =
                boolSolver.translate(_testCaseController.text);
            List<List<String>> ans = boolSolver.solveCases(translation);
            ans.removeAt(1);
            ans[0].add("=");
            answers = [];
            for (int i = 0; i < ans.length; i++) {
              List<Widget> row = [];
              for (int j = 0; j < ans[i].length; j++) {
                row.add(
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        ans[i][j],
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                );
              }
              answers.add(TableRow(children: row));
            }
          } catch (e) {
            answers = [
              TableRow(
                  children: [
                    Center(
                      child: Text(
                        "Error",
                        style: TextStyle(
                            color: (MediaQuery.of(context).platformBrightness ==
                                    Brightness.light)
                                ? Colors.black
                                : Colors.white),
                      ),
                    )
                  ],
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.white)))
            ];
          }
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.all(25),
                  child: Table(
                    border: TableBorder.all(),
                    children: answers,
                  ),
                );
              });
        } else if (name == 'Clear') {
          _testCaseController.text = '';
        } else if (name == 'backspace') {
          if (_testCaseController.text.isNotEmpty == true) {
            if (letters.contains(_testCaseController
                .text[_testCaseController.text.length - 1])) {
              _testCaseController.text = _testCaseController.text
                  .substring(0, _testCaseController.text.length - 3);
            } else {
              _testCaseController.text = _testCaseController.text
                  .substring(0, _testCaseController.text.length - 1);
            }
          }
        } else if (name == '.') {
          if (_testCaseController.text[_testCaseController.text.length - 1] !=
              '.') {
            _testCaseController.text += name.toString();
          }
        } else {
          _testCaseController.text += name.toString();
        }
      },
    );
  }
}

// class TestCases extends StatefulWidget {
//   const TestCases({super.key});

//   @override
//   State<TestCases> createState() => _TestCasesState();
// }

// class _TestCasesState extends State<TestCases> {
//   TextEditingController controller = TextEditingController();
//   List<TableRow> answers = [];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         foregroundColor:
//             (MediaQuery.of(context).platformBrightness == Brightness.light)
//                 ? Colors.black
//                 : Colors.white,
//         elevation: 0,
//         title: const Text("Test Cases"),
//       ),
//       body: Center(
//         child: FractionallySizedBox(
//           widthFactor: 0.5,
//           heightFactor: 0.6,
//           child: Card(
//             child: ListView(
//               itemExtent: 50,
//               children: [
//                 const SizedBox(height: 20),
//                 Inputfield(
//                   controller: controller,
//                   hintText: "Equation",
//                 ),
//                 const SizedBox(height: 20),
//                 FractionallySizedBox(
//                   widthFactor: 0.6,
//                   child: ElevatedButton(
//                       onPressed: () {
//                         try {
//                           List ans = boolSolver.solveCases(
//                               boolSolver.translate(controller.text));
//                           answers = [];
//                           for (int i = 0; i < ans.length; i++) {
//                             List<Widget> row = [];
//                             for (int j = 0; j < ans[i].length; j++) {
//                               row.add(Center(
//                                   child: Padding(
//                                 padding: const EdgeInsets.all(2.0),
//                                 child: Text(ans[i][j]),
//                               )));
//                             }
//                             if (i == 0) {
//                               row.add(const Center(child: Text("")));
//                             }
//                             answers.add(TableRow(children: row));
//                           }
//                         } catch (e) {
//                           answers = [
//                             const TableRow(
//                                 children: [Center(child: Text("Error"))])
//                           ];
//                         }
//                         setState(() {});
//                       },
//                       child: const Text("Solve")),
//                 ),
//                 const SizedBox(height: 20),
//                 FractionallySizedBox(
//                   widthFactor: 0.6,
//                   child: Table(
//                     border: TableBorder.all(),
//                     children: answers,
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class SimplificationCheck extends StatefulWidget {
  const SimplificationCheck({super.key});

  @override
  State<SimplificationCheck> createState() => _SimplificationCheckState();
}

class _SimplificationCheckState extends State<SimplificationCheck> {
  TextEditingController equation1 = TextEditingController();
  TextEditingController equation2 = TextEditingController();
  bool equal = false;
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
        title: const Text("Simplification Check"),
      ),
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.5,
          heightFactor: 0.6,
          child: Card(
            child: ListView(
              itemExtent: 50,
              children: [
                const SizedBox(height: 20),
                Inputfield(
                  onChanged: (val) {
                    equal = boolSolver.correctSimplifcation(
                        equation1.text, equation2.text);
                    setState(() {});
                  },
                  controller: equation1,
                  hintText: "Equation 1",
                ),
                const SizedBox(height: 20),
                Inputfield(
                  onChanged: (val) {
                    equal = boolSolver.correctSimplifcation(
                        equation1.text, equation2.text);
                    setState(() {});
                  },
                  controller: equation2,
                  hintText: "Equation 2",
                ),
                const SizedBox(height: 20),
                Center(
                    child: Icon(
                  (equal) ? Icons.check : Icons.cancel,
                  color: (equal) ? Colors.green : Colors.red,
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
