import 'package:app/Modules/input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:app/Modules/globalfunctions.dart';

class Ohm extends StatefulWidget {
  const Ohm({super.key});

  @override
  State<Ohm> createState() => _OhmState();
}

class _OhmState extends State<Ohm> {
  TextEditingController current = TextEditingController();
  TextEditingController resistance = TextEditingController();
  TextEditingController voltage = TextEditingController();
  void calc() {
    try {
      if (current.text.isEmpty) {
        current.text = roundto(
            (double.parse(voltage.text) / double.parse(resistance.text))
                .toString());
      } else if (resistance.text.isEmpty) {
        resistance.text = roundto(
            (double.parse(voltage.text) / double.parse(current.text))
                .toString());
      } else if (voltage.text.isEmpty) {
        voltage.text = roundto(
            (double.parse(current.text) * double.parse(resistance.text))
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
        title: const Text('Ohm'),
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
                          controller: current,
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
                                ClipboardData(text: current.text));
                            Fluttertoast.showToast(msg: 'Saved to Clipboard');
                          },
                        ),
                        Inputfield(
                          controller: resistance,
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
                                ClipboardData(text: resistance.text));
                            Fluttertoast.showToast(msg: 'Saved to Clipboard');
                          },
                        ),
                        Inputfield(
                          controller: voltage,
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
                                ClipboardData(text: voltage.text));
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
