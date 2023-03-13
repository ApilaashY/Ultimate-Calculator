// ignore_for_file: no_logic_in_create_state, file_names

import 'package:flutter/material.dart';

class Inputfield extends StatefulWidget {
  Inputfield({
    super.key,
    required this.controller,
    this.hintText = '',
    this.suffixText = '',
    this.prefixText = '',
    this.alignment = TextAlign.left,
    this.keyboardType = TextInputType.name,
  });
  TextEditingController controller = TextEditingController();
  String hintText = '';
  String suffixText = '';
  String prefixText = '';
  TextAlign alignment = TextAlign.left;
  TextInputType keyboardType = TextInputType.name;

  @override
  State<Inputfield> createState() => _InputfieldState(
        controller: controller,
        hinttext: hintText,
        suffixtext: suffixText,
        prefixtext: prefixText,
        alignment: alignment,
        keyboardtype: keyboardType,
      );
}

class _InputfieldState extends State<Inputfield> {
  _InputfieldState({
    required this.controller,
    required this.hinttext,
    required this.suffixtext,
    required this.prefixtext,
    required this.keyboardtype,
    required this.alignment,
  });
  TextEditingController controller = TextEditingController();
  String hinttext = '';
  String suffixtext = '';
  String prefixtext = '';
  TextAlign alignment = TextAlign.left;
  TextInputType keyboardtype = TextInputType.name;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.8,
      child: TextField(
        onChanged: (value) => setState(() {}),
        controller: controller,
        keyboardType: keyboardtype,
        textAlign: alignment,
        style: TextStyle(
            color:
                (MediaQuery.of(context).platformBrightness == Brightness.light)
                    ? Colors.black
                    : Colors.white),
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderSide: BorderSide(width: 3),
          ),
          hintText: hinttext,
          suffixText: suffixtext,
          prefixText: prefixtext,
        ),
      ),
    );
  }
}
