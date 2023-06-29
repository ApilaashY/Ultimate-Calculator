// ignore_for_file: file_names

import 'package:app/Modules/input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:app/Modules/globalfunctions.dart';

class GravitationalPotentialEnergy extends StatefulWidget {
  const GravitationalPotentialEnergy({super.key});

  @override
  State<GravitationalPotentialEnergy> createState() =>
      _GravitationalPotentialEnergyState();
}

class _GravitationalPotentialEnergyState
    extends State<GravitationalPotentialEnergy> {
  TextEditingController height = TextEditingController();
  TextEditingController mass = TextEditingController();
  TextEditingController gravity = TextEditingController();
  TextEditingController eg = TextEditingController();
  void calc() {
    try {
      if (height.text.isEmpty) {
        height.text = roundto((double.parse(eg.text) /
                (double.parse(mass.text) * double.parse(gravity.text)))
            .toString());
      } else if (mass.text.isEmpty) {
        mass.text = roundto((double.parse(eg.text) /
                (double.parse(height.text) * double.parse(gravity.text)))
            .toString());
      } else if (gravity.text.isEmpty) {
        gravity.text = roundto((double.parse(eg.text) /
                (double.parse(mass.text) * double.parse(height.text)))
            .toString());
      } else if (eg.text.isEmpty) {
        eg.text = roundto((double.parse(gravity.text) *
                double.parse(mass.text) *
                double.parse(height.text))
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
                          controller: height,
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
                                ClipboardData(text: height.text));
                            Fluttertoast.showToast(msg: 'Saved to Clipboard');
                          },
                        ),
                        Inputfield(
                          controller: mass,
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
                                ClipboardData(text: mass.text));
                            Fluttertoast.showToast(msg: 'Saved to Clipboard');
                          },
                        ),
                        Inputfield(
                          controller: gravity,
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
                                ClipboardData(text: gravity.text));
                            Fluttertoast.showToast(msg: 'Saved to Clipboard');
                          },
                        ),
                        Inputfield(
                          controller: eg,
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
                                ClipboardData(text: eg.text));
                            Fluttertoast.showToast(msg: 'Saved to Clipboard');
                          },
                        ),
                        FractionallySizedBox(
                          widthFactor: 0.65,
                          child: ElevatedButton(
                            onPressed: (() => gravity.text = '9.80665'),
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
