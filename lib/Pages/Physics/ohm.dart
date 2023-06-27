import 'dart:convert';
import 'package:app/Modules/input_field.dart';
import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:math';
import 'package:app/Modules/globalfunctions.dart';

class Ohm extends StatefulWidget {
  const Ohm({super.key});

  @override
  State<Ohm> createState() => _OhmState();
}

class _OhmState extends State<Ohm> {
  TextEditingController Current = TextEditingController();
  TextEditingController Resistance = TextEditingController();
  TextEditingController Voltage = TextEditingController();
  void calc() {
    try {
      if (Current.text.isEmpty) {
        Current.text = roundto(
            (double.parse(Voltage.text) / double.parse(Resistance.text))
                .toString());
      } else if (Resistance.text.isEmpty) {
        Resistance.text = roundto(
            (double.parse(Voltage.text) / double.parse(Current.text))
                .toString());
      } else if (Voltage.text.isEmpty) {
        Voltage.text = roundto(
            (double.parse(Current.text) * double.parse(Resistance.text))
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
        title: Text('Ohm'),
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
                tag: "Ohm's Law",
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
                          controller: Current,
                          hintText: 'Current',
                          keyboardType: TextInputType.number,
                          suffixText: 'A',
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.copy,
                          ),
                          onPressed: () async {
                            await Clipboard.setData(
                                ClipboardData(text: Current.text));
                            Fluttertoast.showToast(msg: 'Saved to Clipboard');
                          },
                        ),
                        Inputfield(
                          controller: Resistance,
                          hintText: 'Resistance',
                          keyboardType: TextInputType.number,
                          suffixText: 'Ω',
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.copy,
                          ),
                          onPressed: () async {
                            await Clipboard.setData(
                                ClipboardData(text: Resistance.text));
                            Fluttertoast.showToast(msg: 'Saved to Clipboard');
                          },
                        ),
                        Inputfield(
                          controller: Voltage,
                          hintText: 'Voltage',
                          keyboardType: TextInputType.number,
                          suffixText: 'V',
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.copy,
                          ),
                          onPressed: () async {
                            await Clipboard.setData(
                                ClipboardData(text: Voltage.text));
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
