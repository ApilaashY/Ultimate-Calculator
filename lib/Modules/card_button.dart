import 'package:flutter/material.dart';

class CardButton extends StatefulWidget {
  CardButton({super.key, required text}) {
    this.text = text;
  }
  String text = 'Unknown';

  @override
  State<CardButton> createState() => _CardButtonState(text);
}

class _CardButtonState extends State<CardButton> {
  _CardButtonState(words) {
    text = words;
  }
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

class ColorText extends StatelessWidget {
  ColorText({super.key, required this.text, this.size = 25});
  String text = '';
  num size = 25;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: double.parse(size.toString()),
        color: (MediaQuery.of(context).platformBrightness == Brightness.light)
            ? Colors.black
            : Colors.white,
      ),
    );
  }
}

class SectionButton extends StatefulWidget {
  SectionButton({super.key, required text}) {
    this.text = text;
  }
  String text = 'Unknown';

  @override
  State<SectionButton> createState() => _SectionButtonState(text: text);
}

class _SectionButtonState extends State<SectionButton> {
  _SectionButtonState({required text}) {
    this.text = text;
  }

  String text = 'Unknown';
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          backgroundColor: const Color.fromARGB(255, 35, 206, 107)),
      onPressed: () {
        Navigator.pushNamed(context, text);
      },
      child: Text(text.replaceAll(" ", "\n"),
          style: TextStyle(
            color:
                (MediaQuery.of(context).platformBrightness == Brightness.dark)
                    ? Colors.white
                    : Colors.black,
          )),
    );
  }
}
