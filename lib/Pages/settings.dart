import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  _SettingsState() {
    void setup() async {
      var _tempdata = await savedata.getString('SettingsSave');
      _data =
          ((_tempdata == null) ? {'RoundingNumber': 4} : jsonDecode(_tempdata));
      _checkdata =
          ((_tempdata == null) ? {'RoundingNumber': 4} : jsonDecode(_tempdata));
      roundingcontroller.text = _data['RoundingNumber'].toString();
    }

    setup();
  }
  Map _data = {};
  Map _checkdata = {};
  TextEditingController roundingcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: IconButton(
            onPressed: () {
              _data['RoundingNumber'] = int.parse(roundingcontroller.text);
              if (_data != _checkdata) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: ((context) => AlertDialog(
                        title: const Text('Unsaved Changes'),
                        content: const Text('Are you sure you want to leave?'),
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
        foregroundColor: Colors.black,
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
              decoration: const InputDecoration(
                  labelText: 'How many digits to round answers'),
            ),
            ElevatedButton(
              onPressed: () async {
                _data['RoundingNumber'] = int.parse(roundingcontroller.text);
                await savedata.setString('SettingsSave', jsonEncode(_data));
                _checkdata = _data;
                showDialog(
                  context: context,
                  builder: (context) => const AlertDialog(
                    title: Text('Changes Saved'),
                  ),
                );
              },
              child: const Text('Save'),
            )
          ],
        ),
      ),
    );
  }
}
