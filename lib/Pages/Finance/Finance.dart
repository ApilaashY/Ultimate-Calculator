import 'package:app/Modules/card_button.dart';
import 'package:flutter/material.dart';

class Finance extends StatefulWidget {
  const Finance({super.key});

  @override
  State<Finance> createState() => _FinanceState();
}

class _FinanceState extends State<Finance> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Science'),
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
              CardButton(text: 'Simple Interest'),
              CardButton(text: 'Compound Interest'),
              CardButton(text: 'Annuity'),
            ]),
      ),
    );
    ;
  }
}
