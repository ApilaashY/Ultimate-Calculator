import 'dart:convert';

import 'package:app/Modules/input_field.dart';
import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Map<String, String> data = {
  "one": "1",
  "two": "1",
  "three": "1",
  "four": "1",
};

class CustomFormulas extends StatefulWidget {
  const CustomFormulas({super.key});

  @override
  State<CustomFormulas> createState() => _CustomFormulasState();
}

class _CustomFormulasState extends State<CustomFormulas> {
  Future<String> getSaves() async {
    String? encodedData = await savedata.getString("CustomFormulas");
    if (encodedData != null) {
      data = json.decode(encodedData);
    }
    return "Done";
  }

  TextEditingController name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getSaves(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Custom Formulas"),
                backgroundColor: Colors.transparent,
                elevation: 0,
                foregroundColor: (MediaQuery.of(context).platformBrightness ==
                        Brightness.light)
                    ? Colors.black
                    : Colors.white,
              ),
              floatingActionButton: FloatingActionButton(
                child: Icon(Icons.add_rounded),
                backgroundColor: const Color.fromARGB(255, 255, 184, 0),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            actions: [
                              const Center(
                                  child: FractionallySizedBox(
                                      widthFactor: 0.9,
                                      child: FittedBox(
                                          child: Text(
                                              "Enter the name of your new formula")))),
                              Padding(padding: EdgeInsets.all(10)),
                              Center(
                                  child: Inputfield(
                                controller: name,
                              )),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromARGB(255, 0, 135, 197),
                                  ),
                                  onPressed: () {
                                    if (name.text.isEmpty) {
                                      Fluttertoast.showToast(msg: "Name empty");
                                    } else if (data.keys.contains(name.text)) {
                                      Fluttertoast.showToast(
                                          msg: "That name already exists");
                                    } else {
                                      Navigator.pop(context);
                                      Navigator.pushNamed(
                                          context, "FormulaMaker");
                                    }
                                  },
                                  child: const Text("Create"))
                            ],
                          ));
                },
              ),
              body: GridView.builder(
                itemBuilder: (context, index) {
                  return FractionallySizedBox(
                    widthFactor: 0.9,
                    heightFactor: 0.9,
                    child: ElevatedButton(
                      onPressed: () {},
                      onLongPress: () => showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text(data.values.elementAt(index),
                                    style: TextStyle(
                                        color: (MediaQuery.of(context)
                                                    .platformBrightness ==
                                                Brightness.light)
                                            ? Colors.black
                                            : Colors.white)),
                              )),
                      child: FractionallySizedBox(
                        widthFactor: 0.7,
                        heightFactor: 0.5,
                        child: FittedBox(
                          child: Text(
                            data.keys.elementAt(index),
                          ),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        elevation: 10,
                        backgroundColor: const Color.fromARGB(255, 0, 135, 197),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: data.length,
                semanticChildCount: 50,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
              ),
            );
          }
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        });
  }
}

class FormulaMaker extends StatefulWidget {
  const FormulaMaker({Key? key}) : super(key: key);

  @override
  State<FormulaMaker> createState() => _FormulaMakerState();
}

class _FormulaMakerState extends State<FormulaMaker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
