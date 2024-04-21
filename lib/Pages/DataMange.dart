import 'package:app/Modules/globalfunctions.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DataManage extends StatefulWidget {
  const DataManage({super.key});

  @override
  State<DataManage> createState() => _DataManageState();
}

class _DataManageState extends State<DataManage> {
  double? mean, median;
  List<double> mode = [];

  void evaluate(String value) {
    value = value.replaceAll("\n", " ").replaceAll(",", " ").trim();
    while (value.contains("  ")) {
      value = value.replaceAll("  ", " ");
    }

    List<String> split = value.split(" ");
    List<double> values = List.filled(split.length, 0);
    int length = split.length;

    for (int i = 0; i < length; i++) {
      try {
        values[i] = double.parse(split[i]);
      } catch (e) {
        mean = null;
        Fluttertoast.showToast(msg: "Values not convertable");
        return;
      }
    }

    values.sort();

    // Calculate Mean
    double total = 0;
    for (int i = 0; i < length; i++) {
      total += values[i];
    }
    mean = total / length;

    // Calculate Median
    if (length % 2 == 1) {
      median = values[(length / 2 - 0.5).floor()];
    } else {
      median =
          (values[(length / 2).round()] + values[(length / 2).round() - 1]) / 2;
    }

    // Calculate Mode
    Map<double, int> freq = {};
    mode = [];
    for (int i = 0; i < length; i++) {
      freq[values[i]] = (freq[values[i]] ?? 0) + 1;

      if (mode.isEmpty ||
          (freq[values[i]] ?? 0) >= (freq[mode[0]] ?? 0) &&
              !mode.contains(values[i])) {
        mode.add(values[i]);
      }
      print(freq);
      print(mode);
    }
    if (mode.isEmpty || freq[mode[0]] == 1) mode = [];

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data Management"),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor:
            (MediaQuery.of(context).platformBrightness == Brightness.light)
                ? Colors.black
                : Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                maxLines: null,
                minLines: null,
                expands: true,
                onChanged: evaluate,
                style: TextStyle(
                  color: (MediaQuery.of(context).platformBrightness ==
                          Brightness.light)
                      ? Colors.black
                      : Colors.white,
                ),
              ),
            ),
          ),
          Expanded(
            child: (mean != null)
                ? GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: 2,
                    children: [
                      const TableText("Mode"),
                      TableText(mode
                          .map((e) => roundto(e.toString()))
                          .toList()
                          .toString()
                          .replaceAll("[", "")
                          .replaceAll("]", "")),
                      const TableText("Median"),
                      TableText(roundto(median.toString())),
                      const TableText("Mean"),
                      TableText(roundto(mean.toString())),
                    ],
                  )
                : Container(),
          ),
        ],
      ),
    );
  }
}

class TableText extends StatelessWidget {
  const TableText(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.6,
      widthFactor: 0.6,
      child: FittedBox(
        child: Text(
          text,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
