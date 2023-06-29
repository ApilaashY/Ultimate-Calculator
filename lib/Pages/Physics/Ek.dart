// ignore_for_file: file_names

import 'package:app/Modules/input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:math';
import 'package:app/Modules/globalfunctions.dart';

class KineticEnergy extends StatefulWidget {
  const KineticEnergy({super.key});

  @override
  State<KineticEnergy> createState() => _KineticEnergyState();
}

class _KineticEnergyState extends State<KineticEnergy> {
  TextEditingController mass = TextEditingController();
  TextEditingController velocity = TextEditingController();
  TextEditingController ek = TextEditingController();
  void calc() {
    try {
      if (mass.text.isEmpty) {
        mass.text = roundto(
            (double.parse(ek.text) / pow(double.parse(velocity.text), 2) * 2)
                .toString());
      } else if (velocity.text.isEmpty) {
        velocity.text = roundto(
            (sqrt(double.parse(ek.text) / (double.parse(mass.text) / 2)))
                .toString());
      } else if (ek.text.isEmpty) {
        ek.text = roundto(
            (double.parse(mass.text) / 2 * pow(double.parse(velocity.text), 2))
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
        title: const Text('Kinetic Energy'),
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
                tag: "Kinetic Energy",
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
                          controller: mass,
                          hintText: 'Mass',
                          keyboardType: TextInputType.number,
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
                          controller: velocity,
                          hintText: 'Velocity',
                          keyboardType: TextInputType.number,
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.copy,
                          ),
                          onPressed: () async {
                            await Clipboard.setData(
                                ClipboardData(text: velocity.text));
                            Fluttertoast.showToast(msg: 'Saved to Clipboard');
                          },
                        ),
                        Inputfield(
                          controller: ek,
                          hintText: 'Ek',
                          keyboardType: TextInputType.number,
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.copy,
                          ),
                          onPressed: () async {
                            await Clipboard.setData(
                                ClipboardData(text: ek.text));
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
