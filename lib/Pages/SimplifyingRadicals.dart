import 'package:app/Modules/input_field.dart';
import 'package:flutter/material.dart';

class SimplifyingRadicals extends StatefulWidget {
  const SimplifyingRadicals({super.key});

  @override
  State<SimplifyingRadicals> createState() => _SimplifyingRadicalsState();
}

class _SimplifyingRadicalsState extends State<SimplifyingRadicals> {
  TextEditingController radController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor:
            (MediaQuery.of(context).platformBrightness == Brightness.light)
                ? Colors.black
                : Colors.white,
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
              children: [Inputfield(controller: radController)],
            ),
          ),
        ),
      ),
    );
  }
}
