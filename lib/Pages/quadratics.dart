// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

String calctype = '';

class Quadratics extends StatelessWidget {
  const Quadratics({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quadratics'),
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
              QuadraticButton(text: 'Root Finder'),
            ]),
      ),
    );
  }
}

class QuadraticButton extends StatefulWidget {
  QuadraticButton({super.key, required this.text}) {}
  String text = 'Unknown';

  @override
  State<QuadraticButton> createState() => _QuadraticButtonState(text: text);
}

class _QuadraticButtonState extends State<QuadraticButton> {
  _QuadraticButtonState({required this.text});
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
