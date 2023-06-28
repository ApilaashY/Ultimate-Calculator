import 'dart:math' as math;

import 'package:app/Pages/periodictable.dart';

class Solver {
  String fixBrackets(String equation) {
    int fronts = 0, backs = 0;
    for (int i = 0; i < equation.length; i++) {
      if (equation[i] == "(") {
        fronts++;
      } else if (equation[i] == ")") {
        backs++;
      }
    }

    if (fronts > backs) {
      for (int i = 0; i < fronts - backs; i++) {
        equation += ")";
      }
    } else if (backs > fronts) {
      for (int i = 0; i < backs - fronts; i++) {
        equation = "(" + equation;
      }
    }

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
    equation = equation
        .replaceAll(" ", "")
        .toLowerCase()
        .replaceAll("π", "(${math.pi})");
    List<String> elements = [];
    String number = "", last = "";
    for (int i = 0; i < equation.length; i++) {
      if ("+-*/^√()abcdefghijklmnopqrstuvwxyz".contains(equation[i])) {
        String checkEquation = equation.substring(i);
        if (checkEquation.length >= 3 &&
            (checkEquation.contains("sin") ||
                checkEquation.contains("cos") ||
                checkEquation.contains("tan") ||
                checkEquation.contains("log"))) {
          String part = checkEquation.substring(0, 3);
          for (String element in ["sin", "cos", "tan", "log"]) {
            if (part == element) {
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

          if (number.isNotEmpty) {
            elements.add(number);
          }
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
      last = equation[i];
    }

    if (number.isNotEmpty) {
      elements.add(number);
    }

    return elements;
  }

  double solve(List<String> equation, String angleMode) {
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
        double solveBracket =
            solve(equation.sublist(front + 1, end), angleMode);

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
          double answer =
              (double.parse(equation[i - 1]) * double.parse(equation[i + 1]));
          equation[i] = answer.toString();
          equation.removeAt(i - 1);
          equation.removeAt(i);

          // Break to make sure operations are in correct order
          break;
        } else if (equation[i] == '/') {
          double answer =
              (double.parse(equation[i - 1]) / double.parse(equation[i + 1]));
          equation[i] = answer.toString();
          equation.removeAt(i - 1);
          equation.removeAt(i);

          // Break to make sure operations are in correct order
          break;
        }
      }
    }

    // Solves Addition and Subtraction
    while (equation.contains("-") || equation.contains("+")) {
      for (int i = 0; i < equation.length; i++) {
        if (equation[i] == '+' && i > 0) {
          double answer =
              (double.parse(equation[i - 1]) + double.parse(equation[i + 1]));
          equation[i] = answer.toString();
          equation.removeAt(i - 1);
          equation.removeAt(i);

          // Break to make sure operations are in correct order
          break;
        } else if (equation[i] == '-' && i > 0) {
          double answer =
              (double.parse(equation[i - 1]) - double.parse(equation[i + 1]));
          equation[i] = answer.toString();
          equation.removeAt(i - 1);
          equation.removeAt(i);
          // Break to make sure operations are in correct order
          break;
        }
      }
    }
    return double.parse(equation[0]);
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
      double number, String operation, String angleMode) {
    operation = operation.toLowerCase();
    if (operation == "sin") {
      if (angleMode == "Radian") {
        return math.sin(number);
      }
      return math.sin(number * math.pi / 180);
    } else if (operation == "cos") {
      if (angleMode == "Radian") {
        return math.cos(number);
      }
      return math.cos(number * math.pi / 180);
    } else if (operation == "tan") {
      if (angleMode == "Radian") {
        return math.tan(number);
      }
      return math.tan(number * math.pi / 180);
    }
    return -1;
  }
}
