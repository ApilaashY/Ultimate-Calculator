import 'dart:convert';

import 'package:app/Pages/BoolAlgebra.dart';
import 'package:app/Pages/CustomFormulas.dart';
import 'package:app/Pages/DataMange.dart';
import 'package:app/Pages/Finance/AnnuityDue.dart';
import 'package:app/Pages/Finance/CompoundInterest.dart';
import 'package:app/Pages/Finance/SimpleInterest.dart';
import 'package:app/Pages/Finance/OrdinaryAnnuity.dart';
import 'package:app/Pages/Physics/Eg.dart';
import 'package:app/Pages/Physics/Ek.dart';
import 'package:app/Pages/Physics/cooffriction.dart';
import 'package:app/Pages/Physics/ohm.dart';
import 'package:app/Pages/Physics/vectoraddition.dart';
import 'package:app/Pages/Physics/vectorsubtraction.dart';
import 'package:app/Pages/Physics/work.dart';
import 'package:app/Pages/SequenceAndSeries/Sequence.dart';
import 'package:app/Pages/SequenceAndSeries/Series.dart';
import 'package:app/Pages/SimplifyingRadicals.dart';
import 'package:app/Pages/Triangles/DegandRad.dart';
import 'package:app/Pages/factors.dart';
import 'package:app/Pages/graph.dart';
import 'package:app/Pages/prime.dart';
import 'package:flutter/material.dart';

import 'package:app/main.dart';
import 'package:app/Pages/Calculator.dart';
import 'package:app/Pages/Converter.dart';
import 'package:app/Pages/GCF.dart';
import 'package:app/Pages/LCM.dart';
import 'package:app/Pages/Triangles/Pythagorean.dart';
import 'package:app/Pages/rootfinder.dart';
import 'package:app/Pages/Triangles/Trigonometry.dart';
import 'package:app/Pages/settings.dart';
import 'package:app/Pages/periodictable.dart';

Route<dynamic> controller(RouteSettings settings) {
  if (savedata != null) {
    Map recommended = {
      'Calculator': 0,
      'Converter': 0,
      'GCF': 0,
      'LCM': 0,
      'Pythagorean': 0,
      'Trigonometry': 0,
      'Root Finder': 0,
      'Periodic Table': 0,
      '2D Vector Addition': 0,
      '2D Vector Subtraction': 0,
      'Graphs': 0,
      'Work': 0,
      'Gravitational Potential Energy': 0,
      'Coefficient of Friction': 0,
      'Kinetic Energy': 0,
      "Ohm's Law": 0,
      "Sequences": 0,
      "Series": 0,
      "Simple Interest": 0,
      "Compound Interest": 0,
      "Ordinary Annuity": 0,
      "Annuity Due": 0,
      "Degree Radian Converter": 0,
      "Simplifying Radicals": 0,
      "Custom Formulas": 0,
      'Boolean Calculator': 0,
      'Test Cases': 0,
      "Factors": 0,
      "Prime": 0,
      "Data Management": 0,
    };
    bool? reset = savedata.getBool("Reset");
    String? resetDate = savedata.getString("ResetDate");

    DateTime now = DateTime.now();
    var today = DateTime(now.year, now.month);

    if (reset == false && resetDate != today.toString()) {
      savedata.setBool("Reset", true);
      savedata.setString("ResetDate", today.toString());
    } else {
      String? data = savedata.getString("Recomended");
      if (data != null) {
        recommended = jsonDecode(data);
      }
    }
    recommended[settings.name] = (recommended[settings.name] ?? 0) + 1;
    savedata.setString("Recomended", jsonEncode(recommended));
  }
  if (settings.name == 'Home') {
    return MaterialPageRoute(builder: (context) => const Home());
  } else if (settings.name == 'Calculator') {
    return MaterialPageRoute(builder: (context) => const Calculator());
  } else if (settings.name == 'Converter') {
    return MaterialPageRoute(builder: (context) => const Converter());
  } else if (settings.name == 'SurfaceArea') {
    return MaterialPageRoute(builder: (context) => const Home());
  } else if (settings.name == 'GCF') {
    return MaterialPageRoute(builder: (context) => const GCF());
  } else if (settings.name == 'LCM') {
    return MaterialPageRoute(builder: (context) => const LCM());
  } else if (settings.name == 'Pythagorean') {
    return MaterialPageRoute(builder: (context) => const Pythagorean());
  } else if (settings.name == 'Trigonometry') {
    return MaterialPageRoute(builder: (context) => const Trigonometry());
  } else if (settings.name == 'Root Finder') {
    return MaterialPageRoute(builder: (context) => const RootFinder());
  } else if (settings.name == 'Periodic Table') {
    return MaterialPageRoute(builder: (context) => const PeriodicTable());
  } else if (settings.name == '2D Vector Addition') {
    return MaterialPageRoute(builder: (context) => const VectorAddition());
  } else if (settings.name == '2D Vector Subtraction') {
    return MaterialPageRoute(builder: (context) => const VectorSubtraction());
  } else if (settings.name == 'Graphs') {
    return MaterialPageRoute(builder: (context) => const Graphs());
  } else if (settings.name == 'Settings') {
    return MaterialPageRoute(builder: (context) => const Settings());
  } else if (settings.name == 'Work') {
    return MaterialPageRoute(builder: (context) => const Work());
  } else if (settings.name == 'Gravitational Potential Energy') {
    return MaterialPageRoute(
        builder: (context) => const GravitationalPotentialEnergy());
  } else if (settings.name == 'Coefficient of Friction') {
    return MaterialPageRoute(
        builder: (context) => const CoefficientofFriction());
  } else if (settings.name == 'Kinetic Energy') {
    return MaterialPageRoute(builder: (context) => const KineticEnergy());
  } else if (settings.name == "Ohm's Law") {
    return MaterialPageRoute(builder: (context) => const Ohm());
  } else if (settings.name == "Sequences") {
    return MaterialPageRoute(builder: (context) => const Sequence());
  } else if (settings.name == "Series") {
    return MaterialPageRoute(builder: (context) => const Series());
  } else if (settings.name == "Simple Interest") {
    return MaterialPageRoute(builder: (context) => const SimpleInterest());
  } else if (settings.name == "Compound Interest") {
    return MaterialPageRoute(builder: (context) => const CompoundInterest());
  } else if (settings.name == "Ordinary Annuity") {
    return MaterialPageRoute(builder: (context) => const OrdinaryAnnuity());
  } else if (settings.name == "Annuity Due") {
    return MaterialPageRoute(builder: (context) => const AnnuityDue());
  } else if (settings.name == "Degree Radian Converter") {
    return MaterialPageRoute(builder: (context) => const DegAndRad());
  } else if (settings.name == "Simplifying Radicals") {
    return MaterialPageRoute(builder: (context) => const SimplifyingRadicals());
  } else if (settings.name == "Custom Formulas") {
    return MaterialPageRoute(builder: (context) => const CustomFormulas());
  } else if (settings.name == "Formula Maker") {
    return MaterialPageRoute(
        builder: (context) =>
            FormulaMaker(name: settings.arguments.toString()));
  } else if (settings.name == "Formula Calculator") {
    return MaterialPageRoute(
        builder: (context) =>
            FormulaCalculator(name: settings.arguments.toString()));
  } else if (settings.name == 'Boolean Calculator') {
    return MaterialPageRoute(builder: (context) => const BoolCalculator());
  } else if (settings.name == 'Test Cases') {
    return MaterialPageRoute(builder: (context) => const TestCases());
  } else if (settings.name == 'Factors') {
    return MaterialPageRoute(builder: (context) => const Factors());
  } else if (settings.name == 'Prime') {
    return MaterialPageRoute(builder: (context) => const Prime());
  } else if (settings.name == "Data Management") {
    return MaterialPageRoute(builder: (context) => const DataManage());
  } else {
    throw 'Page Not Found';
  }
}
