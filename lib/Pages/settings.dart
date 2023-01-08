import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
      _data = ((_tempdata == null)
          ? {'RoundingNumber': 4, 'sigfigrounding': false}
          : jsonDecode(_tempdata));
      _checkdata = _data;
      roundingcontroller.text = _data['RoundingNumber'].toString();
      _sigfig =
          (_data['sigfigrounding'] != null) ? _data['sigfigrounding'] : false;
      setState(() {});
    }

    setup();
  }
  Map _data = {};
  Map _checkdata = {};
  TextEditingController roundingcontroller = TextEditingController();
  bool _sigfig = false;
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
              enabled: !_sigfig,
              style: TextStyle(
                  color: (MediaQuery.of(context).platformBrightness ==
                          Brightness.light)
                      ? Colors.black
                      : Colors.white),
              decoration: const InputDecoration(
                  labelText: 'How many digits to round answers'),
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
                  _data['RoundingNumber'] = int.parse(roundingcontroller.text);
                  _data['sigfigrounding'] = _sigfig;
                  await savedata.setString('SettingsSave', jsonEncode(_data));
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
}
