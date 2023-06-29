import 'package:app/Modules/input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:app/Modules/globalfunctions.dart';

class CoefficientofFriction extends StatefulWidget {
  const CoefficientofFriction({super.key});

  @override
  State<CoefficientofFriction> createState() => _CoefficientofFrictionState();
}

class _CoefficientofFrictionState extends State<CoefficientofFriction> {
  TextEditingController friction = TextEditingController();
  TextEditingController normal = TextEditingController();
  TextEditingController mew = TextEditingController();
  void calc() {
    try {
      if (friction.text.isEmpty) {
        friction.text = roundto(
            (double.parse(mew.text) * double.parse(normal.text)).toString());
      } else if (normal.text.isEmpty) {
        normal.text = roundto(
            (double.parse(friction.text) / double.parse(mew.text)).toString());
      } else if (mew.text.isEmpty) {
        mew.text = roundto(
            (double.parse(friction.text) / double.parse(normal.text))
                .toString());
      } else {
        throw 'Not Enough Data';
      }
      addpoints(1);
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error');
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coefficient of Friction'),
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
            alignment: const Alignment(0.0, 0.2),
            child: FractionallySizedBox(
              heightFactor: 0.8,
              widthFactor: 0.8,
              child: Hero(
                tag: "Coefficient of Friction",
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 20,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: ListView(
                      children: [
                        Inputfield(
                          controller: friction,
                          hintText: 'Friction',
                          keyboardType: TextInputType.number,
                          suffixText: 'N',
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.copy,
                          ),
                          onPressed: () async {
                            await Clipboard.setData(
                                ClipboardData(text: friction.text));
                            Fluttertoast.showToast(msg: 'Saved to Clipboard');
                          },
                        ),
                        Inputfield(
                          controller: normal,
                          hintText: 'Normal',
                          keyboardType: TextInputType.number,
                          suffixText: 'N',
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.copy,
                          ),
                          onPressed: () async {
                            await Clipboard.setData(
                                ClipboardData(text: normal.text));
                            Fluttertoast.showToast(msg: 'Saved to Clipboard');
                          },
                        ),
                        Inputfield(
                          controller: mew,
                          hintText: 'Mew',
                          keyboardType: TextInputType.number,
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.copy,
                          ),
                          onPressed: () async {
                            await Clipboard.setData(
                                ClipboardData(text: mew.text));
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
