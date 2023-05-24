import 'dart:math';

import 'package:app/Modules/input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SimplifyingRadicals extends StatefulWidget {
  const SimplifyingRadicals({super.key});

  @override
  State<SimplifyingRadicals> createState() => _SimplifyingRadicalsState();
}

class _SimplifyingRadicalsState extends State<SimplifyingRadicals> {
  TextEditingController radController = TextEditingController();
  TextEditingController answerController = TextEditingController();
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
      ),
      body: Center(
        child: FractionallySizedBox(
          heightFactor: 0.8,
          widthFactor: 0.85,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 20,
            child: ListView(
              padding: EdgeInsets.only(top: 20),
              children: [
                FractionallySizedBox(
                  widthFactor: 0.8,
                  child: TextField(
                    onChanged: (val) {
                      int num = 1;
                      int rad = int.parse(radController.text);

                      int start = rad;
                      int startSq = sqrt(start).floor() + 1;
                      start = int.parse(pow(startSq - 1, 2).toString());
                      try {
                        for (int i = rad; i > 0; i -= startSq * 2 - 1) {
                          if (sqrt(i) == sqrt(i).round() &&
                              (rad / i) == (rad / i).round()) {
                            num = sqrt(i).round();
                            break;
                          }
                        }
                        answerController.text =
                            ((num > 1) ? (num).toString() : '') +
                                (((rad / (num * num)) > 1)
                                    ? "√${(rad / (num * num)).round()}"
                                    : '');
                      } catch (e) {
                        answerController.text = '0';
                      }
                      setState(() {});
                    },
                    controller: radController,
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                        color: (MediaQuery.of(context).platformBrightness ==
                                Brightness.light)
                            ? Colors.black
                            : Colors.white),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 3),
                      ),
                      hintText: "√",
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.copy,
                  ),
                  onPressed: () async {
                    await Clipboard.setData(
                        ClipboardData(text: radController.text));
                    Fluttertoast.showToast(msg: 'Saved to Clipboard');
                  },
                ),
                Inputfield(
                  controller: answerController,
                  enabled: false,
                ),
                IconButton(
                  icon: const Icon(
                    Icons.copy,
                  ),
                  onPressed: () async {
                    await Clipboard.setData(
                        ClipboardData(text: answerController.text));
                    Fluttertoast.showToast(msg: 'Saved to Clipboard');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
