import 'package:app/Pages/Physics/physics.dart';
import 'package:app/Pages/Physics/vectoraddition.dart';
import 'package:app/Pages/Physics/work.dart';
import 'package:flutter/material.dart';

import 'package:app/main.dart';
import 'package:app/Pages/calculator.dart';
import 'package:app/Pages/converter.dart';
import 'package:app/Pages/finance.dart';
import 'package:app/Pages/gcf.dart';
import 'package:app/Pages/lcm.dart';
import 'package:app/Pages/pythagorean.dart';
import 'package:app/Pages/quadratics.dart';
import 'package:app/Pages/rootfinder.dart';
import 'package:app/Pages/surfacearea.dart';
import 'package:app/Pages/trigonometry.dart';
import 'package:app/Pages/volume.dart';
import 'package:app/Pages/settings.dart';
import 'package:app/Pages/periodictable.dart';
import 'package:app/Pages/science.dart';
import 'package:app/Pages/graph.dart';

Route<dynamic> controller(RouteSettings settings) {
  if (settings.name == 'Home') {
    return MaterialPageRoute(builder: (context) => Home());
  } else if (settings.name == 'Calculator') {
    return MaterialPageRoute(builder: (context) => Calculator());
  } else if (settings.name == 'Converter') {
    return MaterialPageRoute(builder: (context) => const Converter());
  } else if (settings.name == 'SurfaceArea') {
    return MaterialPageRoute(builder: (context) => Home());
  } else if (settings.name == 'Volume') {
    return MaterialPageRoute(builder: (context) => const Volume());
  } else if (settings.name == 'VolumeCalculator') {
    return MaterialPageRoute(builder: (context) => const VolumeCalculator());
  } else if (settings.name == 'GCF') {
    return MaterialPageRoute(builder: (context) => const GCF());
  } else if (settings.name == 'LCM') {
    return MaterialPageRoute(builder: (context) => const LCM());
  } else if (settings.name == 'Pythagorean') {
    return MaterialPageRoute(builder: (context) => const Pythagorean());
  } else if (settings.name == 'Trigonometry') {
    return MaterialPageRoute(builder: (context) => const Trigonometry());
  } else if (settings.name == 'Quadratics') {
    return MaterialPageRoute(builder: (context) => Quadratics());
  } else if (settings.name == 'Root Finder') {
    return MaterialPageRoute(builder: (context) => RootFinder());
  } else if (settings.name == 'Finance') {
    return MaterialPageRoute(builder: (context) => Home());
  } else if (settings.name == 'Science') {
    return MaterialPageRoute(builder: (context) => Science());
  } else if (settings.name == 'Periodic Table') {
    return MaterialPageRoute(builder: (context) => const PeriodicTable());
  } else if (settings.name == 'Physics') {
    return MaterialPageRoute(builder: (context) => Physics());
  } else if (settings.name == 'Vector Addition') {
    return MaterialPageRoute(builder: (context) => VectorAddition());
  } else if (settings.name == 'Graphs') {
    return MaterialPageRoute(builder: (context) => Home());
  } else if (settings.name == 'Settings') {
    return MaterialPageRoute(builder: (context) => const Settings());
  } else if (settings.name == 'Work') {
    return MaterialPageRoute(builder: (context) => const Work());
  } else {
    throw 'Page Not Found';
  }
}
