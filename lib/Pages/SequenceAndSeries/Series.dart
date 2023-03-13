import 'dart:math';

import 'package:app/Modules/input_field.dart';
import 'package:app/Modules/globalfunctions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Series extends StatefulWidget {
  const Series({super.key});

  @override
  State<Series> createState() => _SeriesState();
}

class _SeriesState extends State<Series> {
  TextEditingController first = TextEditingController();
  TextEditingController sum = TextEditingController();
  TextEditingController n = TextEditingController();
  TextEditingController nth = TextEditingController();
  TextEditingController difference = TextEditingController();
  String change = "Arithmetic";

  void calc() {
    try {
      if (change == "Arithmetic") {
        if (true) {
        } else {
          Fluttertoast.showToast(msg: "Not Enough Information");
        }
      } else if (change == "Geometric") {
        if (true) {
        } else {
          Fluttertoast.showToast(msg: "Not Enough Information");
        }
        addpoints(1);
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error");
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor:
            (MediaQuery.of(context).platformBrightness == Brightness.light)
                ? Colors.black
                : Colors.white,
        title: const Text("Series"),
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
              children: [
                Center(
                  child: DropdownButton(
                    items: const [
                      DropdownMenuItem(
                        value: "Arithmetic",
                        child: Text("Arithmetic"),
                      ),
                      DropdownMenuItem(
                        value: "Geometric",
                        child: Text("Geometric"),
                      ),
                    ],
                    onChanged: (val) {
                      change = val.toString();
                      setState(() {});
                    },
                    value: change,
                  ),
                ),
                Inputfield(
                  controller: first,
                  hintText: "First Value",
                  keyboardType: TextInputType.number,
                ),
                IconButton(
                  icon: const Icon(
                    Icons.copy,
                  ),
                  onPressed: () async {
                    await Clipboard.setData(ClipboardData(text: first.text));
                    Fluttertoast.showToast(msg: 'Saved to Clipboard');
                  },
                ),
                Inputfield(
                  controller: nth,
                  hintText: "Nth term",
                  keyboardType: TextInputType.number,
                ),
                IconButton(
                  icon: const Icon(
                    Icons.copy,
                  ),
                  onPressed: () async {
                    await Clipboard.setData(ClipboardData(text: nth.text));
                    Fluttertoast.showToast(msg: 'Saved to Clipboard');
                  },
                ),
                Inputfield(
                  controller: n,
                  hintText: "N",
                  keyboardType: TextInputType.number,
                ),
                IconButton(
                  icon: const Icon(
                    Icons.copy,
                  ),
                  onPressed: () async {
                    await Clipboard.setData(ClipboardData(text: n.text));
                    Fluttertoast.showToast(msg: 'Saved to Clipboard');
                  },
                ),
                Inputfield(
                  controller: difference,
                  hintText: "Common Difference",
                  keyboardType: TextInputType.number,
                ),
                IconButton(
                  icon: const Icon(
                    Icons.copy,
                  ),
                  onPressed: () async {
                    await Clipboard.setData(
                        ClipboardData(text: difference.text));
                    Fluttertoast.showToast(msg: 'Saved to Clipboard');
                  },
                ),
                Inputfield(
                  controller: difference,
                  hintText:
                      "Sum of ${(int.tryParse(n.text) != null) ? int.parse(n.text) : "0"} terms",
                  keyboardType: TextInputType.number,
                ),
                IconButton(
                  icon: const Icon(
                    Icons.copy,
                  ),
                  onPressed: () async {
                    await Clipboard.setData(ClipboardData(text: sum.text));
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
    );
  }
}
