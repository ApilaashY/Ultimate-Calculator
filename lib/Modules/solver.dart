// ignore_for_file: empty_catches, camel_case_types

import 'dart:math' as math;

class Solver {
  String fixBrackets(String equation) {
    String stack = "";
    for (int i = 0; i < equation.length; i++) {
      if (equation[i] == "(") {
        stack += "(";
      } else if (equation[i] == ")") {
        if (stack.isNotEmpty) {
          stack.replaceFirst("/", "");
        } else {
          equation = "($equation";
          i++;
        }
      }
    }

    equation = equation + (")" * stack.length);

    return equation;
  }

  List<String> putMultiplyBetweenNums(List<String> equation) {
    for (int i = 0; i < equation.length - 1; i++) {
      try {
        double.parse(equation[i]);
        double.parse(equation[i + 1]);
        equation.insert(i + 1, "*");
      } catch (e) {}
    }
    return equation;
  }

  List<String> translate(String equation) {
    equation = equation.replaceAll(" ", "").toLowerCase();
    List<String> elements = [];
    String number = "";
    for (int i = 0; i < equation.length; i++) {
      if ("+-*/^√()abcdefghijklmnopqrstuvwxyz".contains(equation[i])) {
        if (number.isNotEmpty) {
          elements.add(number);
          number = "";
        }
        String checkEquation = equation.substring(i);
        if (checkEquation.length >= 3 &&
            (checkEquation.contains("sin") ||
                checkEquation.contains("cos") ||
                checkEquation.contains("tan") ||
                checkEquation.contains("log"))) {
          String part = checkEquation.substring(0, 3);
          for (String element in ["sin", "cos", "tan", "log"]) {
            if (part == element) {
              elements.add("*");
              elements.add(element);
              i += 2;
              break;
            }
          }
        } else if (checkEquation.length <= 2 && checkEquation.contains("ln")) {
          if (checkEquation.substring(0, 2) == "ln") {
            elements.add("ln");
            i++;
          }
        } else {
          bool numBeforeBracket = (i > 0 &&
              equation[i] == '(' &&
              !"+-*/^√()".contains(equation[i - 1]));
          bool numAfterBracket = (i < equation.length - 1 &&
              equation[i] == ')' &&
              !"+-*/^√()".contains(equation[i + 1]));

          if (numBeforeBracket) {
            elements.add("*");
          }

          if (equation[i] == "√" &&
              (i < 1 || !"1234567890".contains(equation[i - 1][0]))) {
            elements.add("2");
          }
          elements.add(equation[i]);

          if (numAfterBracket ||
              (i < equation.length - 1 &&
                  equation[i] == ")" &&
                  equation[i + 1] == "(")) {
            elements.add("*");
          }

          number = "";
        }
      } else {
        if (equation[i] == "√" &&
            (i < 1 || !"1234567890".contains(equation[i - 1][0]))) {
          elements.add("2");
        }
        number += equation[i];
      }
    }

    if (number.isNotEmpty) {
      elements.add(number);
    }

    return elements;
  }

  List<String> solve(List<String> equation, AngleType angleMode,
      {bool exactValue = true}) {
    if (!exactValue) {
      for (int i = 0; i < equation.length; i++) {
        if (equation[i] == "π") {
          equation[i] = math.pi.toString();
        }
      }
    }

    // Determines negative and positive numbers
    String last = " ";
    for (int i = 0; i < equation.length; i++) {
      if (("+-/*(".contains(last) && "+-".contains(equation[i])) ||
          (i == 0 && "+-".contains(equation[i]))) {
        if (equation[i] == "+") {
          equation.removeAt(i);
        } else {
          equation.removeAt(i);
          equation[i] = (-double.parse(equation[i])).toString();
        }
      }

      last = equation[i];
    }

    // Solves Brackets
    while (equation.contains("(") && equation.contains(")")) {
      //int front = equation.lastIndexOf("(");
      int end = equation.indexOf(")");
      int front = _highestIndexBefore(_indexesOf(equation, "("), end);
      if (end - front >= 1) {
        String solveBracket = solve(equation.sublist(front + 1, end), angleMode,
            exactValue: exactValue)[0];

        equation[front] = solveBracket.toString();
        for (int i = 0; i < end - front; i++) {
          equation.removeAt(front + 1);
        }
      }
    }

    // Solves Sin, Cos, Tan, Log
    while (equation.contains("sin") ||
        equation.contains("cos") ||
        equation.contains("tan") ||
        equation.contains("ln") ||
        equation.contains("log")) {
      for (int i = 0; i < equation.length; i++) {
        if ("sin cos tan".contains(equation[i])) {
          String answer = (_adjustableSinCosTan(
                  double.parse(equation[i + 2]), equation[i], angleMode))
              .toString();
          equation[i] = answer;
          equation.removeAt(i + 1);
          equation.removeAt(i + 1);
        } else if (equation[i] == "ln") {
          String answer = math.log(double.parse(equation[i + 2])).toString();
          equation[i] = answer;
          equation.removeAt(i + 1);
          equation.removeAt(i + 1);
        } else if (equation[i] == "log") {
          String answer =
              (math.log(double.parse(equation[i + 2])) * math.log10e)
                  .toString();
          equation[i] = answer;
          equation.removeAt(i + 1);
          equation.removeAt(i + 1);
        }
      }
    }

    // Solves Exponents
    while (equation.contains("^")) {
      int i = equation.indexOf("^");
      num answer = math.pow(
          double.parse(equation[i - 1]), double.parse(equation[i + 1]));
      equation[i] = answer.toString();
      equation.removeAt(i - 1);
      equation.removeAt(i);
    }

    // Solves Roots
    while (equation.contains("√")) {
      int i = equation.indexOf("√");
      num answer = math.pow(
          double.parse(equation[i + 1]), 1 / double.parse(equation[i - 1]));
      equation[i] = answer.toString();
      equation.removeAt(i - 1);
      equation.removeAt(i);
    }

    // Solves brackets beside numbers multiplication first (&)
    while (equation.contains("&")) {
      int i = equation.indexOf("&");
      double answer =
          (double.parse(equation[i - 1]) * double.parse(equation[i + 1]));
      equation[i] = answer.toString();
      equation.removeAt(i - 1);
      equation.removeAt(i);
    }

    // Solves Multiplicaiton and Division
    while (equation.contains("*") || equation.contains("/")) {
      for (int i = 0; i < equation.length; i++) {
        if (equation[i] == '*') {
          if (exactValue &&
              (equation[i - 1].contains("/") ||
                  equation[i + 1].contains("/"))) {
            List<String> first = ((equation[i - 1].contains("/"))
                    ? equation[i - 1]
                    : "${equation[i - 1]}/1")
                .split("/");
            List<String> second = ((equation[i + 1].contains("/"))
                    ? equation[i + 1]
                    : "${equation[i + 1]}/1")
                .split("/");
            equation[i] =
                "${double.parse(first[0]) * double.parse(second[0])}/${double.parse(first[1]) * double.parse(second[1])}";
            equation.removeAt(i - 1);
            equation.removeAt(i);
          } else {
            double answer =
                (double.parse(equation[i - 1]) * double.parse(equation[i + 1]));
            equation[i] = answer.toString();
            equation.removeAt(i - 1);
            equation.removeAt(i);
          }

          // Break to make sure operations are in correct order
          break;
        } else if (equation[i] == '/') {
          if (exactValue) {
            if (equation[i - 1].contains("/") ||
                equation[i + 1].contains("/")) {
              List<String> first = ((equation[i - 1].contains("/"))
                      ? equation[i - 1]
                      : "${equation[i - 1]}/1")
                  .split("/");
              List<String> second = ((equation[i + 1].contains("/"))
                      ? equation[i + 1]
                      : "${equation[i + 1]}/1")
                  .split("/");
              equation[i] =
                  "${double.parse(first[0]) * double.parse(second[1])}/${double.parse(first[1]) * double.parse(second[0])}";
              equation.removeAt(i - 1);
              equation.removeAt(i);
            } else {
              equation[i] = "${equation[i - 1]}/${equation[i + 1]}";
              equation.removeAt(i - 1);
              equation.removeAt(i);
            }
          } else {
            double answer =
                (double.parse(equation[i - 1]) / double.parse(equation[i + 1]));
            equation[i] = answer.toString();
            equation.removeAt(i - 1);
            equation.removeAt(i);
          }
          // Break to make sure operations are in correct order
          break;
        }
      }
    }

    // Solves Addition and Subtraction
    while (equation.contains("-") || equation.contains("+")) {
      for (int i = 0; i < equation.length; i++) {
        if (equation[i] == '+' && i > 0) {
          if (exactValue &&
              (equation[i - 1].contains("/") ||
                  equation[i + 1].contains("/"))) {
            List<String> first = ((equation[i - 1].contains("/"))
                    ? equation[i - 1]
                    : "${equation[i - 1]}/1")
                .split("/");
            List<String> second = ((equation[i + 1].contains("/"))
                    ? equation[i + 1]
                    : "${equation[i + 1]}/1")
                .split("/");
            List<String> newEquation = [
              (double.parse(first[0]) * double.parse(second[1])).toString(),
              "+",
              (double.parse(second[0]) * double.parse(first[1])).toString()
            ];
            equation[i] =
                "${solve(newEquation, angleMode, exactValue: true)[0]}/${double.parse(first[1]) * double.parse(second[1])}";
            equation.removeAt(i - 1);
            equation.removeAt(i);
          } else {
            double answer =
                (double.parse(equation[i - 1]) + double.parse(equation[i + 1]));
            equation[i] = answer.toString();
            equation.removeAt(i - 1);
            equation.removeAt(i);
          }

          // Break to make sure operations are in correct order
          break;
        } else if (equation[i] == '-' && i > 0) {
          if (exactValue &&
              (equation[i - 1].contains("/") ||
                  equation[i + 1].contains("/"))) {
            List<String> first = ((equation[i - 1].contains("/"))
                    ? equation[i - 1]
                    : "${equation[i - 1]}/1")
                .split("/");
            List<String> second = ((equation[i + 1].contains("/"))
                    ? equation[i + 1]
                    : "${equation[i + 1]}/1")
                .split("/");
            List<String> newEquation = [
              (double.parse(first[0]) * double.parse(second[1])).toString(),
              "-",
              (double.parse(second[0]) * double.parse(first[1])).toString()
            ];
            equation[i] =
                "${solve(newEquation, angleMode, exactValue: true)[0]}/${double.parse(first[1]) * double.parse(second[1])}";
            equation.removeAt(i - 1);
            equation.removeAt(i);
          } else {
            double answer =
                (double.parse(equation[i - 1]) - double.parse(equation[i + 1]));
            equation[i] = answer.toString();
            equation.removeAt(i - 1);
            equation.removeAt(i);
          }
          // Break to make sure operations are in correct order
          break;
        }
      }
    }
    if (equation[0].contains("/")) {
      equation = [reduce(equation[0])];
    }
    return equation;
  }

  List<int> _indexesOf(List<String> list, String search) {
    List<int> x = [];
    for (int i = 0; i < list.length; i++) {
      if (list[i] == search) {
        x.add(i);
      }
    }
    return x;
  }

  int _highestIndexBefore(List<int> indexes, int high) {
    for (int i = 0; i < indexes.length; i++) {
      if (indexes[i] > high && i == 0) {
        return -1;
      }

      if (indexes[i] > high && indexes[i - 1] < high) {
        return indexes[i - 1];
      }
    }
    return indexes[indexes.length - 1];
  }

  double _adjustableSinCosTan(
      double number, String operation, AngleType angleMode) {
    operation = operation.toLowerCase();
    if (operation == "sin") {
      if (angleMode == AngleType.Radians) {
        return math.sin(number);
      }
      return math.sin(number * math.pi / 180);
    } else if (operation == "cos") {
      if (angleMode == AngleType.Radians) {
        return math.cos(number);
      }
      return math.cos(number * math.pi / 180);
    } else if (operation == "tan") {
      if (angleMode == AngleType.Radians) {
        return math.tan(number);
      }
      return math.tan(number * math.pi / 180);
    }
    return -1;
  }

  String reduce(String equation) {
    List splitEquation = equation.split("/");
    int first = int.parse(double.parse(splitEquation[0]).round().toString());
    int second = int.parse(double.parse(splitEquation[1]).round().toString());
    int gcf = first.gcd(second);
    return "${first / gcf}/${second / gcf}";
  }
}

class boolAlgebraSolver {
  List<String> translate(String equation) {
    equation = equation.replaceAll(" ", "");
    List<String> elements = [];
    String number = "";
    String alphabet = "abcxyz";
    for (int i = 0; i < equation.length; i++) {
      if (("!*+()$alphabet").contains(equation[i])) {
        if (number.isNotEmpty) {
          elements.add(number);
        }
        elements.add(equation[i]);
        number = "";
        if (i < equation.length - 1 &&
            ("$alphabet)").contains(equation[i]) &&
            ("$alphabet(").contains(equation[i + 1])) {
          elements.add("*");
        }
      } else {
        number += equation[i];
      }
    }
    if (number.isNotEmpty) {
      elements.add(number);
    }
    return elements;
  }

  List<List<String>> solveCases(List<String> equation) {
    Map charMap = {
      "a": 1,
      "b": 2,
      "c": 3,
      "x": 4,
      "y": 5,
      "z": 6,
    };
    List<List<String>> cases = [[]];
    List places = [];
    String seen = "";
    cases[0] = [];
    for (int i = 0; i < equation.length; i++) {
      if ("abcxyz".contains(equation[i])) {
        if (seen.contains(equation[i])) {
          cases[0][seen.indexOf(equation[i])] += (" $i");
        } else {
          cases[0].add(i.toString());
          seen += equation[i];
        }
      }
    }

    for (int i = 0; i < cases[0].length; i++) {
      places.add(charMap[equation[int.parse(cases[0][i].split(" ")[0])]]);
    }

    for (int i = 0; i < places.length; i++) {
      int lowest = i;
      for (int j = i; j < places.length; j++) {
        if (places[j] < places[lowest]) {
          lowest = j;
        }
      }

      int tempValue = places[i];
      String tempValueList = cases[0][i];

      places[i] = places[lowest];
      cases[0][i] = cases[0][lowest];

      places[lowest] = tempValue;
      cases[0][lowest] = tempValueList;
    }

    List<String> caseNums = nums(cases[0].length);
    for (String x in caseNums) {
      cases.add(x.split(""));
    }

    for (int i = 1; i < cases.length; i++) {
      List<String> tempEquation = List.from(equation);
      for (int x = 0; x < cases[0].length; x++) {
        for (String y in cases[0][x].split(" ")) {
          tempEquation[int.parse(y)] = cases[i][x];
        }
      }
      cases[i].add(solve(tempEquation).toString());
    }

    for (int i = 0; i < cases[0].length; i++) {
      cases[0][i] = equation[int.parse(cases[0][i].split(" ")[0])];
    }
    return cases;
  }

  List<String> nums(int digits) {
    List<String> list = [];
    for (int i = 0; i <= math.pow(2, digits); i++) {
      list.add(numToBin(i, digits));
    }
    return list;
  }

  String numToBin(int number, int max) {
    String numberString = "";
    for (int i = max - 1; i >= 0; i--) {
      if (math.pow(2, i) < number) {
        numberString += "1";
        number -= int.parse(math.pow(2, i).toString());
      } else {
        numberString += "0";
      }
    }
    return numberString;
  }

  bool correctSimplifcation(String equation1, String equation2) {
    List eq1 = solveCases(translate(equation1));
    List eq2 = solveCases(translate(equation2));

    for (int i = 0; i < eq1.length; i++) {
      for (int j = 0; j < eq1[i].length; j++) {
        if (eq1[i][j] != eq2[i][j]) {
          return false;
        }
      }
    }
    return true;
  }

  int solve(List<String> equation) {
    // Solves Brackets
    while (equation.contains("(") || equation.contains(")")) {
      int end = equation.indexOf(")");
      int front = highestIndexBefore(indexesOf(equation, "("), end);

      if (end - front >= 1) {
        int solveBracket = solve(equation.sublist(front + 1, end));

        equation[front] = solveBracket.toString();
        for (int i = 0; i < end - front; i++) {
          equation.removeAt(front + 1);
        }
      }
    }
    //Solve opposites
    for (int i = 0; i < equation.length - 1; i++) {
      if (equation[i] == "!") {
        equation.removeAt(i);
        if (equation[i] == "0") {
          equation[i] = "1";
        } else {
          equation[i] = "0";
        }
      }
    }
    // Solves multiplication
    while (equation.contains("*")) {
      for (int i = 1; i < equation.length - 1; i++) {
        if (equation[i] == "*") {
          equation[i] =
              (int.parse(equation[i - 1]) * int.parse(equation[i + 1]))
                  .toString();
          equation.removeAt(i - 1);
          equation.removeAt(i);
        }
      }
    }
    // Solves addition
    while (equation.contains("+")) {
      for (int i = 1; i < equation.length - 1; i++) {
        if (equation[i] == "+") {
          equation[i] =
              (int.parse(equation[i - 1]) + int.parse(equation[i + 1]) > 0)
                  ? "1"
                  : "0";

          equation.removeAt(i - 1);
          equation.removeAt(i);
        }
      }
    }
    return int.parse(equation[0]);
  }

  List<int> indexesOf(List<String> list, String search) {
    List<int> x = [];
    for (int i = 0; i < list.length; i++) {
      if (list[i] == search) {
        x.add(i);
      }
    }
    return x;
  }

  int highestIndexBefore(List<int> indexes, int high) {
    for (int i = 0; i < indexes.length; i++) {
      if (indexes[i] > high && i == 0) {
        return -1;
      }

      if (indexes[i] > high && indexes[i - 1] < high) {
        return indexes[i - 1];
      }
    }
    return indexes[indexes.length - 1];
  }
}

enum AngleType {
  Degrees,
  Radians,
}
