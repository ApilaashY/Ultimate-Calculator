import 'package:flutter/material.dart';

class CustomFormulas extends StatefulWidget {
  const CustomFormulas({super.key});

  @override
  State<CustomFormulas> createState() => _CustomFormulasState();
}

class _CustomFormulasState extends State<CustomFormulas> {
  Future getFormulas() async {
    return "done";
  }

  Map<String, String> formulas = {
    "one": "1",
    "two": "2",
    "three": "3",
  };
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getFormulas(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              foregroundColor: (MediaQuery.of(context).platformBrightness ==
                      Brightness.light)
                  ? Colors.black
                  : Colors.white,
            ),
            body: GridView.builder(
              itemBuilder: (context, index) {
                return FractionallySizedBox(
                    widthFactor: 0.9,
                    heightFactor: 0.9,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(formulas.keys.toList()[index]),
                      style: ElevatedButton.styleFrom(
                        elevation: 10,
                        backgroundColor: const Color.fromARGB(255, 0, 135, 197),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                    ));
              },
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: formulas.length,
            ),
          );
        }
        return Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

class FormulaMaker extends StatefulWidget {
  const FormulaMaker({Key? key}) : super(key: key);

  @override
  State<CustomFormulas> createState() => _CustomFormulasState();
}

class _FormulaMakerState extends State<CustomFormulas> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
