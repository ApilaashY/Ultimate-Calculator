import 'dart:math';

import 'package:app/Modules/input_field.dart';
import 'package:flutter/material.dart';

class Prime extends StatefulWidget {
  const Prime({super.key});

  @override
  State<Prime> createState() => _PrimeState();
}

class _PrimeState extends State<Prime> {
  bool isPrime = false;

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
            tag: "Prime",
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
                          isPrime = true;
                          for (int i = 2;
                              i <= sqrt(int.parse(newVal)).ceil();
                              i++) {
                            if (int.parse(newVal) % i == 0) {
                              isPrime = false;
                              break;
                            }
                          }
                        } catch (e) {
                          isPrime = false;
                        }
                        setState(() {});
                      },
                    ),
                    const SizedBox(height: 20),
                    (isPrime)
                        ? const Icon(
                            Icons.check,
                            color: Colors.green,
                          )
                        : const Icon(
                            Icons.close,
                            color: Colors.red,
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
