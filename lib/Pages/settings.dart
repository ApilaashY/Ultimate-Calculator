import 'dart:io';

import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:app/Pages/Converter.dart' as converter;

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  Future setup() async {
    if (!setupDone) {
      String? _tempdata = await savedata.getString('SettingsSave');
      _data = ((_tempdata == null)
          ? {
              'RoundingNumber': 4,
              'sigfigrounding': false,
              'firstCurrency': "AED - United Arab Emirates Dirham",
              'secondCurrency': "AED - United Arab Emirates Dirham",
              'degreeDefault': true,
            }
          : jsonDecode(_tempdata));
      roundingcontroller.text = _data['RoundingNumber'].toString();
      _sigfig =
          (_data['sigfigrounding'] != null) ? _data['sigfigrounding'] : false;
      _firstCurrencyValue = (_data['firstCurrency'] != null)
          ? _data['firstCurrency']
          : "AED - United Arab Emirates Dirham";
      _secondCurrencyValue = (_data['secondCurrency'] != null)
          ? _data['secondCurrency']
          : "AED - United Arab Emirates Dirham";
      _degreeDefault =
          (_data['degreeDefault'] != null) ? _data['degreeDefault'] : true;
      setupDone = true;
    }
    return 'done';
  }

  void save() async {
    try {
      _data['RoundingNumber'] = (roundingcontroller.text.isNotEmpty)
          ? int.parse(roundingcontroller.text)
          : 0;
      _data['sigfigrounding'] = _sigfig;
      _data['firstCurrency'] = _firstCurrencyValue;
      _data['secondCurrency'] = _secondCurrencyValue;
      _data['degreeDefault'] = _degreeDefault;
      await savedata.setString('SettingsSave', jsonEncode(_data));
      roundingnumber = (roundingcontroller.text.isNotEmpty)
          ? int.parse(roundingcontroller.text)
          : 0;
      sigfigrounding = _sigfig;
      degreeDefault = _degreeDefault;
      firstCurrencyValue = _firstCurrencyValue;
      secondCurrencyValue = _secondCurrencyValue;
      Fluttertoast.showToast(msg: "Saved");
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error');
    }
  }

  bool setupDone = false;
  Map _data = {};
  TextEditingController roundingcontroller = TextEditingController();
  bool _sigfig = false;
  String _firstCurrencyValue = "AED - United Arab Emirates Dirham";
  String _secondCurrencyValue = "AED - United Arab Emirates Dirham";
  bool _degreeDefault = true;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: setup(),
      builder: (context, snap) {
        if (snap.hasData) {
          return Scaffold(
            appBar: AppBar(
              foregroundColor: (MediaQuery.of(context).platformBrightness ==
                      Brightness.light)
                  ? Colors.black
                  : Colors.white,
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: Padding(
              padding: const EdgeInsets.all(15),
              child: ListView(
                children: [
                  TextFormField(
                    controller: roundingcontroller,
                    maxLength: 1,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    enabled: !_sigfig,
                    onChanged: (val) => save(),
                    style: TextStyle(
                        color: (MediaQuery.of(context).platformBrightness ==
                                Brightness.light)
                            ? Colors.black
                            : Colors.white),
                    decoration: const InputDecoration(
                        labelText: 'How many digits to round answers'),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10),
                  ),
                  Column(
                    children: [
                      Text("Default Currencies",
                          style: TextStyle(
                              color:
                                  (MediaQuery.of(context).platformBrightness ==
                                          Brightness.light)
                                      ? Colors.black
                                      : Colors.white)),
                      DropdownButton(
                        value: _firstCurrencyValue,
                        style: TextStyle(
                          color: (MediaQuery.of(context).platformBrightness ==
                                  Brightness.light)
                              ? Colors.black
                              : Colors.white,
                        ),
                        items: converter.typeMap['Currency']!
                            .map((String dropDownStringItem) {
                          return DropdownMenuItem(
                            value: dropDownStringItem,
                            child: Text(dropDownStringItem),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(
                              () => _firstCurrencyValue = newValue.toString());
                          save();
                        },
                      ),
                      DropdownButton(
                        style: TextStyle(
                          color: (MediaQuery.of(context).platformBrightness ==
                                  Brightness.light)
                              ? Colors.black
                              : Colors.white,
                        ),
                        value: _secondCurrencyValue,
                        items: converter.typeMap["Currency"]!
                            .map((String dropDownStringItem) {
                          return DropdownMenuItem(
                            value: dropDownStringItem,
                            child: Text(dropDownStringItem),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(
                              () => _secondCurrencyValue = newValue.toString());
                          save();
                        },
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10),
                  ),
                  Row(
                    children: [
                      Text("Degree Mode Default",
                          style: TextStyle(
                              color:
                                  (MediaQuery.of(context).platformBrightness ==
                                          Brightness.light)
                                      ? Colors.black
                                      : Colors.white)),
                      Switch.adaptive(
                          value: _degreeDefault,
                          onChanged: (val) {
                            setState(() => _degreeDefault = val);
                            save();
                          })
                    ],
                  ),
                  /*
                Row(
                  children: [
                    const Text("Round to Significant Figures"),
                    Checkbox(
                        value: _sigfig,
                        onChanged: (value) {
                          setState(() {
                            if (value != null) {
                              _sigfig = value;
                            }
                          });
                        })
                  ],
                ),*/
                ],
              ),
            ),
          );
        }
        return const Scaffold(
          body: Center(child: CircularProgressIndicator.adaptive()),
        );
      },
    );
  }
}
