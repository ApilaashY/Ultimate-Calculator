// ignore_for_file: file_names, no_logic_in_create_state

import 'package:app/Modules/input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

String chosenshape = 'Triangle';
Map calcfields = {
  'Triangle': 2,
};

class Volume extends StatefulWidget {
  const Volume({super.key});

  @override
  State<Volume> createState() => _VolumeState();
}

class _VolumeState extends State<Volume> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor:
            (MediaQuery.of(context).platformBrightness == Brightness.light)
                ? Colors.black
                : Colors.white,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          children: [
            VolumeCardButton(text: 'Circle'),
            VolumeCardButton(text: 'Triangle'),
            VolumeCardButton(text: 'Rectangle'),
            VolumeCardButton(text: 'Trapazoid'),
            VolumeCardButton(text: 'Pentagon'),
            VolumeCardButton(text: 'Hexagon'),
            VolumeCardButton(text: 'Heptagon'),
            VolumeCardButton(text: 'Octogon'),
          ],
        ),
      ),
    );
  }
}

class VolumeCardButton extends StatefulWidget {
  VolumeCardButton({super.key, required this.text}) {
    chosenshape = 'Triangle';
  }
  final String text;

  @override
  State<VolumeCardButton> createState() => VolumeCardButtonState(text);
}

class VolumeCardButtonState extends State<VolumeCardButton> {
  VolumeCardButtonState(words) {
    text = words;
  }
  String text = 'Unknown';
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (() => Navigator.pushNamed(context, 'VolumeCalculator')),
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor:
            (MediaQuery.of(context).platformBrightness == Brightness.light)
                ? const Color.fromARGB(255, 165, 226, 255)
                : const Color.fromARGB(255, 0, 135, 197),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
      child: FractionallySizedBox(
        widthFactor: 0.9,
        heightFactor: 0.9,
        child: FittedBox(
          child: Text(
            text.replaceAll(' ', '\n'),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: (MediaQuery.of(context).platformBrightness ==
                      Brightness.light)
                  ? Colors.black
                  : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class VolumeCalculator extends StatefulWidget {
  const VolumeCalculator({super.key});

  @override
  State<VolumeCalculator> createState() => _VolumeCalculatorState();
}

class _VolumeCalculatorState extends State<VolumeCalculator> {
  List controllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];
  List<Widget> inputlist = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    int i = 0;
    while (calcfields[chosenshape] > 0) {
      inputlist = [];
      inputlist.add(Inputfield(controller: controllers[i + 1]));
      inputlist.add(IconButton(
        icon: const Icon(
          Icons.copy,
        ),
        onPressed: () async {
          await Clipboard.setData(ClipboardData(text: controllers[i + 1].text));
          Fluttertoast.showToast(msg: 'Saved to Clipboard');
        },
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.8,
          heightFactor: 0.6,
          child: Card(
            elevation: 20,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: ListView(
              children: inputlist,
            ),
          ),
        ),
      ),
    );
  }
}
