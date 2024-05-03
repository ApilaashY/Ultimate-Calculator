import 'dart:math';

import 'package:app/main.dart';
import 'package:fluttertoast/fluttertoast.dart';

bool todaylimitshown = false;

String roundto(String variable) {
  variable = double.parse(variable).toStringAsFixed(roundingnumber);
  if (variable.isNotEmpty) {
    while (variable[variable.length - 1] == '0' && variable.contains('.')) {
      variable = variable.substring(0, variable.length - 1);

      if (variable[variable.length - 1] == '.') {
        variable = variable.replaceAll('.', '');
      }
    }
  }
  return variable;
}

void addpoints(int pointnumber) async {
  DateTime now = DateTime.now();
  var today = DateTime(now.year, now.month, now.day);
  var todaysave = await savedata.getString('today');
  var todaylength = await savedata.getInt('todaylength');

  if (todaysave != DateTime(now.year, now.month, now.day).toString()) {
    todaylength = 0;
  }

  if (todaylength < 10) {
    await savedata.setString('today', today.toString());
    await savedata.setInt('points', points + pointnumber);
    await savedata.setInt('todaylength', todaylength + pointnumber);
    points += pointnumber;
    pointsleft = (todaylength + pointsleft) / 10;
    Fluttertoast.showToast(msg: 'Added 1 Point');
  } else {
    if (todaylimitshown == false) {
      Fluttertoast.showToast(msg: 'Point Limit Hit for Today');
      todaylimitshown = true;
    }
  }
}

class DegreeRad {
  bool degreemode = true;
  DegreeRad(this.degreemode);
  double degrees(double num) {
    if (degreemode == true) {
      return num * (180 / pi);
    }
    return num;
  }

  double radians(double num) {
    if (degreemode == true) {
      return num * (pi / 180);
    }
    return num;
  }

  double fulltriangle(double num) {
    if (degreemode == false) {
      return pi;
    }
    return num;
  }
}

double abs(double value) {
  if (value < 0) return value * -1;
  return value;
}
