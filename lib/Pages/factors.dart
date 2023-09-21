import 'package:app/Modules/input_field.dart';
import 'package:flutter/material.dart';

class Factors extends StatefulWidget {
  const Factors({super.key});

  @override
  State<Factors> createState() => _FactorsState();
}

class _FactorsState extends State<Factors> {
  List<int> factors = [];

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
          widthFactor: 0.8,
          child: Hero(
            tag: "Factors",
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
                      onChanged: (newVal) {
                        try {
                          factors = [];
                          for (int i = 1; i <= int.parse(newVal); i++) {
                            if (int.parse(newVal) % i == 0) {
                              factors.add(i);
                            }
                          }
                        } catch (e) {}
                        setState(() {});
                      },
                    ),
                    const SizedBox(height: 20),
                    Wrap(
                      alignment: WrapAlignment.center,
                      children: factors
                          .map((e) => Chip(label: Text(e.toString())))
                          .toList(),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
