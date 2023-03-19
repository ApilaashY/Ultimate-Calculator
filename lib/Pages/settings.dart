import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:app/Pages/Converter.dart' as converter;

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  Future setup() async {
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
    _checkdata = _data;
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
    return 'done';
  }

  Map _data = {};
  Map _checkdata = {};
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
                automaticallyImplyLeading: false,
                title: IconButton(
                    onPressed: () {
                      _data['RoundingNumber'] =
                          int.parse(roundingcontroller.text);
                      if (_data != _checkdata) {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: ((context) => AlertDialog(
                                title: const Text('Unsaved Changes'),
                                content: const Text(
                                    'Are you sure you want to leave?'),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Cancel'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Leave'),
                                  ),
                                ],
                              )),
                        );
                      } else {
                        Navigator.pop(context);
                      }
                    },
                    icon: const Icon(Icons.arrow_back)),
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
                                color: (MediaQuery.of(context)
                                            .platformBrightness ==
                                        Brightness.light)
                                    ? Colors.black
                                    : Colors.white)),
                        DropdownButton(
                          style: TextStyle(
                            color: (MediaQuery.of(context).platformBrightness ==
                                    Brightness.light)
                                ? Colors.black
                                : Colors.white,
                          ),
                          value: _firstCurrencyValue,
                          items: converter.typeMap["Currency"]!
                              .map((String dropDownStringItem) {
                            return DropdownMenuItem(
                              value: dropDownStringItem,
                              child: Text(dropDownStringItem),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            print(newValue.toString());
                            setState(() {
                              _firstCurrencyValue = newValue.toString();
                            });
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
                            setState(() {
                              _secondCurrencyValue = newValue.toString();
                            });
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
                                color: (MediaQuery.of(context)
                                            .platformBrightness ==
                                        Brightness.light)
                                    ? Colors.black
                                    : Colors.white)),
                        Switch.adaptive(
                            value: _degreeDefault,
                            onChanged: (val) {
                              setState(() => _degreeDefault = val);
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
                    ElevatedButton(
                      onPressed: () async {
                        try {
                          print(_degreeDefault);
                          _data['RoundingNumber'] =
                              int.parse(roundingcontroller.text);
                          _data['sigfigrounding'] = _sigfig;
                          _data['firstCurrency'] = _firstCurrencyValue;
                          _data['secondCurrency'] = _secondCurrencyValue;
                          _data['degreeDefault'] = _degreeDefault;
                          await savedata.setString(
                              'SettingsSave', jsonEncode(_data));
                          _checkdata = _data;
                          roundingnumber = int.parse(roundingcontroller.text);
                          sigfigrounding = _sigfig;
                          showDialog(
                            context: context,
                            builder: (context) => const AlertDialog(
                              title: Text('Changes Saved'),
                            ),
                          );
                        } catch (e) {
                          Fluttertoast.showToast(msg: 'Error');
                        }
                      },
                      child: const Text('Save'),
                    )
                  ],
                ),
              ),
            );
          }
          return Scaffold(
            body: Center(child: CircularProgressIndicator.adaptive()),
          );
        });
  }
}
