import 'package:app/Modules/input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:app/Modules/globalfunctions.dart';

class Work extends StatefulWidget {
  const Work({super.key});

  @override
  State<Work> createState() => _WorkState();
}

class _WorkState extends State<Work> {
  TextEditingController work = TextEditingController();
  TextEditingController force = TextEditingController();
  TextEditingController displacement = TextEditingController();
  void calc() {
    try {
      if (work.text.isEmpty) {
        work.text = roundto(
            (double.parse(force.text) * double.parse(displacement.text))
                .toString());
      } else if (force.text.isEmpty) {
        force.text = roundto(
            (double.parse(work.text) / double.parse(displacement.text))
                .toString());
      } else if (displacement.text.isEmpty) {
        displacement.text = roundto(
            (double.parse(work.text) / double.parse(force.text)).toString());
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
        title: const Text('Work'),
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
                tag: "Work",
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
                          controller: force,
                          hintText: 'Force',
                          keyboardType: TextInputType.number,
                          suffixText: 'N',
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.copy,
                          ),
                          onPressed: () async {
                            await Clipboard.setData(
                                ClipboardData(text: force.text));
                            Fluttertoast.showToast(msg: 'Saved to Clipboard');
                          },
                        ),
                        Inputfield(
                          controller: displacement,
                          hintText: 'Displacement',
                          keyboardType: TextInputType.number,
                          suffixText: 'm',
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.copy,
                          ),
                          onPressed: () async {
                            await Clipboard.setData(
                                ClipboardData(text: displacement.text));
                            Fluttertoast.showToast(msg: 'Saved to Clipboard');
                          },
                        ),
                        Inputfield(
                          controller: work,
                          hintText: 'Work',
                          keyboardType: TextInputType.number,
                          suffixText: 'J',
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.copy,
                          ),
                          onPressed: () async {
                            await Clipboard.setData(
                                ClipboardData(text: work.text));
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
