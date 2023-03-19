import 'package:app/Pages/Finance/AnnuityDue.dart';
import 'package:app/Pages/Finance/CompoundInterest.dart';
import 'package:app/Pages/Finance/SimpleInterest.dart';
import 'package:app/Pages/Finance/OrdinaryAnnuity.dart';
import 'package:app/Pages/Physics/Eg.dart';
import 'package:app/Pages/Physics/Ek.dart';
import 'package:app/Pages/Physics/cooffriction.dart';
import 'package:app/Pages/Physics/ohm.dart';
import 'package:app/Pages/Physics/vectoraddition.dart';
import 'package:app/Pages/Physics/work.dart';
import 'package:app/Pages/SequenceAndSeries/Sequence.dart';
import 'package:app/Pages/SequenceAndSeries/Series.dart';
import 'package:app/Pages/Triangles/DegandRad.dart';
import 'package:flutter/material.dart';

import 'package:app/main.dart';
import 'package:app/Pages/calculator.dart';
import 'package:app/Pages/converter.dart';
import 'package:app/Pages/gcf.dart';
import 'package:app/Pages/lcm.dart';
import 'package:app/Pages/Triangles/Pythagorean.dart';
import 'package:app/Pages/rootfinder.dart';
import 'package:app/Pages/surfacearea.dart';
import 'package:app/Pages/Triangles/Trigonometry.dart';
import 'package:app/Pages/volume.dart';
import 'package:app/Pages/settings.dart';
import 'package:app/Pages/periodictable.dart';
import 'package:app/Pages/graph.dart';

Route<dynamic> controller(RouteSettings settings) {
  if (settings.name == 'Home') {
    return MaterialPageRoute(builder: (context) => const Home());
  } else if (settings.name == 'Calculator') {
    return MaterialPageRoute(builder: (context) => Calculator());
  } else if (settings.name == 'Converter') {
    return MaterialPageRoute(builder: (context) => const Converter());
  } else if (settings.name == 'SurfaceArea') {
    return MaterialPageRoute(builder: (context) => const Home());
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
  } else if (settings.name == 'Root Finder') {
    return MaterialPageRoute(builder: (context) => const RootFinder());
  } else if (settings.name == 'Periodic Table') {
    return MaterialPageRoute(builder: (context) => const PeriodicTable());
  } else if (settings.name == 'Vector Addition') {
    return MaterialPageRoute(builder: (context) => const VectorAddition());
  } else if (settings.name == 'Graphs') {
    return MaterialPageRoute(builder: (context) => const Home());
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
  } else {
    throw 'Page Not Found';
  }
}
