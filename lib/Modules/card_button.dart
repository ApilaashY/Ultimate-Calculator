import 'package:flutter/material.dart';

class CardButton extends StatefulWidget {
  CardButton({super.key, required text, this.menu}) {
    this.text = text;
  }
  String text = 'Unknown';
  String? menu;

  @override
  State<CardButton> createState() => _CardButtonState(text: text, menu: menu);
}

class _CardButtonState extends State<CardButton> {
  _CardButtonState({required this.text, this.menu});
  String text = 'Unknown';
  String? menu;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (() => Navigator.pushNamed(context, text)),
      onLongPress: () => (menu != null)
          ? showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text(menu!,
                        style: TextStyle(
                            color: (MediaQuery.of(context).platformBrightness ==
                                    Brightness.light)
                                ? Colors.black
                                : Colors.white)),
                  ))
          : 0,
      style: ElevatedButton.styleFrom(
        elevation: 10,
        backgroundColor: const Color.fromARGB(255, 0, 135, 197),
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
  SectionButton({super.key, required this.text, this.menu});
  String text = 'Unknown';
  String? menu;

  @override
  State<SectionButton> createState() =>
      _SectionButtonState(text: text, menu: menu);
}

class _SectionButtonState extends State<SectionButton> {
  _SectionButtonState({required this.text, this.menu});
  String text = 'Unknown';
  String? menu;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          backgroundColor: const Color.fromARGB(255, 35, 206, 107)),
      onPressed: () => Navigator.pushNamed(context, text),
      onLongPress: () => (menu != null)
          ? showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text(menu!,
                        style: TextStyle(
                            color: (MediaQuery.of(context).platformBrightness ==
                                    Brightness.light)
                                ? Colors.black
                                : Colors.white)),
                  ))
          : 0,
      child: FractionallySizedBox(
        widthFactor: 0.9,
        heightFactor: 0.9,
        child: Text(text.replaceAll(" ", "\n")),
      ),
    );
  }
}

class ExtendedButton extends StatefulWidget {
  ExtendedButton({super.key, required this.text, this.children = const []});
  String text;
  List<Widget> children;

  @override
  State<ExtendedButton> createState() =>
      _ExtendedButtonState(text: text, children: children);
}

class _ExtendedButtonState extends State<ExtendedButton> {
  _ExtendedButtonState({required this.text, this.children = const []});
  String text;
  List<Widget> children;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      color: (MediaQuery.of(context).platformBrightness == Brightness.light)
          ? const Color.fromARGB(255, 165, 226, 255)
          : const Color.fromARGB(255, 0, 135, 197),
      child: Column(children: [
        Expanded(
          flex: 1,
          child: FittedBox(
              child: Text(
            text,
            style: TextStyle(
              color: (MediaQuery.of(context).platformBrightness ==
                      Brightness.light)
                  ? Colors.black
                  : Colors.white,
            ),
          )),
        ),
        Expanded(
            flex: 3,
            child: GridView.count(
              crossAxisCount: 1,
              padding: const EdgeInsets.all(10),
              mainAxisSpacing: 10,
              scrollDirection: Axis.horizontal,
              children: children,
            )),
      ]),
    );
  }
}
