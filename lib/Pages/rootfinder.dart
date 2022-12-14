import 'dart:convert';

import 'package:app/Modules/globalfunctions.dart';
import 'package:app/Modules/input_field.dart';
import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

import 'package:fluttertoast/fluttertoast.dart';

class RootFinder extends StatefulWidget {
  const RootFinder({super.key});

  @override
  State<RootFinder> createState() => _RootFinderState();
}

class _RootFinderState extends State<RootFinder> {
  String _answerText = ' ';
  TextEditingController atext = TextEditingController(),
      btext = TextEditingController(),
      ctext = TextEditingController();
  void calc() {
    try {
      double a = double.parse(atext.text);
      double b = double.parse(btext.text);
      double c = double.parse(ctext.text);
      double answerone = ((-b + sqrt(pow(b, 2) - 4 * a * c)) / (2 * a));
      double answertwo = ((-b - sqrt(pow(b, 2) - 4 * a * c)) / (2 * a));
      if (answerone.isNaN || answertwo.isNaN) {
        Fluttertoast.showToast(msg: 'Error');
      } else if (answerone == answertwo) {
        _answerText = roundto(answerone.toString());
      } else {
        _answerText =
            '${roundto(answerone.toString())},\n${roundto(answertwo.toString())}';
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
      body: Stack(
        children: [
          Align(
            alignment: (MediaQuery.of(context).size.height >
                    MediaQuery.of(context).size.width)
                ? const Alignment(0, -0.8)
                : const Alignment(-1, 0),
            child: FractionallySizedBox(
              widthFactor: (MediaQuery.of(context).size.height >
                      MediaQuery.of(context).size.width)
                  ? 0.8
                  : 0.5,
              heightFactor: (MediaQuery.of(context).size.height >
                      MediaQuery.of(context).size.width)
                  ? 0.2
                  : 0.6,
              child: FittedBox(
                child: Text(
                  _answerText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: (MediaQuery.of(context).platformBrightness ==
                              Brightness.light)
                          ? Colors.black
                          : Colors.white),
                ),
              ),
            ),
          ),
          Align(
            alignment: (MediaQuery.of(context).size.height >
                    MediaQuery.of(context).size.width)
                ? const Alignment(0, -0.35)
                : const Alignment(-0.55, -0.9),
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
                  ? 0.5
                  : 0.9,
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
                        controller: atext,
                        keyboardType: TextInputType.number,
                        hintText: 'a',
                      ),
                      Inputfield(
                        controller: btext,
                        keyboardType: TextInputType.number,
                        hintText: 'b',
                      ),
                      Inputfield(
                        controller: ctext,
                        keyboardType: TextInputType.number,
                        hintText: 'c',
                      ),
                      FractionallySizedBox(
                        widthFactor: 0.8,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 0, 135, 197)),
                          onPressed: calc,
                          child: const Text('Solve'),
                        ),
                      )
                    ],
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
