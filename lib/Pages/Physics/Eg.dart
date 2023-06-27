import 'dart:convert';
import 'package:app/Modules/input_field.dart';
import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:math';
import 'package:app/Modules/globalfunctions.dart';

class GravitationalPotentialEnergy extends StatefulWidget {
  const GravitationalPotentialEnergy({super.key});

  @override
  State<GravitationalPotentialEnergy> createState() =>
      _GravitationalPotentialEnergyState();
}

class _GravitationalPotentialEnergyState
    extends State<GravitationalPotentialEnergy> {
  TextEditingController Height = TextEditingController();
  TextEditingController Mass = TextEditingController();
  TextEditingController Gravity = TextEditingController();
  TextEditingController Eg = TextEditingController();
  void calc() {
    try {
      if (Height.text.isEmpty) {
        Height.text = roundto((double.parse(Eg.text) /
                (double.parse(Mass.text) * double.parse(Gravity.text)))
            .toString());
      } else if (Mass.text.isEmpty) {
        Mass.text = roundto((double.parse(Eg.text) /
                (double.parse(Height.text) * double.parse(Gravity.text)))
            .toString());
      } else if (Gravity.text.isEmpty) {
        Gravity.text = roundto((double.parse(Eg.text) /
                (double.parse(Mass.text) * double.parse(Height.text)))
            .toString());
      } else if (Eg.text.isEmpty) {
        Eg.text = roundto((double.parse(Gravity.text) *
                double.parse(Mass.text) *
                double.parse(Height.text))
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
        title: const Text('Gravitational Potential Energy'),
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
                tag: "Gravitational Potential Energy",
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
                          controller: Height,
                          hintText: 'Height',
                          keyboardType: TextInputType.number,
                          suffixText: 'm',
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.copy,
                          ),
                          onPressed: () async {
                            await Clipboard.setData(
                                ClipboardData(text: Height.text));
                            Fluttertoast.showToast(msg: 'Saved to Clipboard');
                          },
                        ),
                        Inputfield(
                          controller: Mass,
                          hintText: 'Mass',
                          keyboardType: TextInputType.number,
                          suffixText: 'kg',
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.copy,
                          ),
                          onPressed: () async {
                            await Clipboard.setData(
                                ClipboardData(text: Mass.text));
                            Fluttertoast.showToast(msg: 'Saved to Clipboard');
                          },
                        ),
                        Inputfield(
                          controller: Gravity,
                          hintText: 'Gravity',
                          keyboardType: TextInputType.number,
                          suffixText: 'm/s^2',
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.copy,
                          ),
                          onPressed: () async {
                            await Clipboard.setData(
                                ClipboardData(text: Gravity.text));
                            Fluttertoast.showToast(msg: 'Saved to Clipboard');
                          },
                        ),
                        Inputfield(
                          controller: Eg,
                          hintText: 'Eg',
                          keyboardType: TextInputType.number,
                          suffixText: 'J',
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.copy,
                          ),
                          onPressed: () async {
                            await Clipboard.setData(
                                ClipboardData(text: Eg.text));
                            Fluttertoast.showToast(msg: 'Saved to Clipboard');
                          },
                        ),
                        FractionallySizedBox(
                          widthFactor: 0.65,
                          child: ElevatedButton(
                            onPressed: (() => Gravity.text = '9.80665'),
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 0, 135, 197)),
                            child: const Text('Earth Gravity'),
                          ),
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
