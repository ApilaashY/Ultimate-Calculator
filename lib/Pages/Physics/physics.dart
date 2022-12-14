// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

String calctype = '';

class Physics extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Physics'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor:
            (MediaQuery.of(context).platformBrightness == Brightness.light)
                ? Colors.black
                : Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GridView.count(
            crossAxisCount: (() {
              if (MediaQuery.of(context).size.height >
                  MediaQuery.of(context).size.width) {
                return 2;
              }
              return 6;
            })(),
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            children: [
              PhysicsButton(text: 'Vector Addition'),
              PhysicsButton(text: 'Work'),
            ]),
      ),
    );
  }
}

class PhysicsButton extends StatefulWidget {
  PhysicsButton({super.key, required this.text}) {}
  String text = 'Unknown';

  @override
  State<PhysicsButton> createState() => _PhysicsButtonState(text: text);
}

class _PhysicsButtonState extends State<PhysicsButton> {
  _PhysicsButtonState({required this.text});
  String text = 'Unknown';
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (() => Navigator.pushNamed(context, text)),
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
