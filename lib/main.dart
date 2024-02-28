// ignore_for_file: prefer_typing_uninitialized_variables, dead_code, use_build_context_synchronously

import 'dart:convert';
import 'dart:io' show Platform;
import 'dart:math';
// import 'dart:html' as html;
import 'package:app/Pages/BoolAlgebra.dart';
import 'package:app/Pages/Converter.dart';
import 'package:app/Pages/CustomFormulas.dart';
import 'package:app/Pages/Finance/AnnuityDue.dart';
import 'package:app/Pages/Finance/CompoundInterest.dart';
import 'package:app/Pages/Finance/OrdinaryAnnuity.dart';
import 'package:app/Pages/Finance/SimpleInterest.dart';
import 'package:app/Pages/GCF.dart';
import 'package:app/Pages/LCM.dart';
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
import 'package:app/Pages/Triangles/Pythagorean.dart';
import 'package:app/Pages/Triangles/Trigonometry.dart';
import 'package:app/Pages/factors.dart';
import 'package:app/Pages/graph.dart';
import 'package:app/Pages/periodictable.dart';
import 'package:app/Pages/prime.dart';
import 'package:app/Pages/rootfinder.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'Modules/loadas.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Modules/routes.dart' as routes;
import 'Modules/card_button.dart';
import 'firebase_options.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:galaxy_store_in_app_review/galaxy_store_in_app_review.dart';
import 'package:flutter/foundation.dart' as foundation;

var savedata;
int roundingnumber = 4;
bool sigfigrounding = false;
String firstCurrencyValue = "AED - United Arab Emirates Dirham";
String secondCurrencyValue = "AED - United Arab Emirates Dirham";
bool degreeDefault = true;
int points = 0;
double pointsleft = 0;
bool webMode = false;
BannerAd? bannerAd;

void main() async {
  try {
    if (Platform.isAndroid || Platform.isIOS) {
      webMode = false;
    }
    WidgetsFlutterBinding.ensureInitialized();
    await MobileAds.instance.initialize();
  } catch (e) {
    webMode = true;
  }
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: MaterialApp(
            debugShowCheckedModeBanner: true,
            theme: (!webMode)
                ? ThemeData.light().copyWith(
                    primaryColor: const Color.fromARGB(255, 0, 135, 197),
                    textTheme:
                        GoogleFonts.latoTextTheme(Theme.of(context).textTheme))
                : ThemeData.light().copyWith(
                    primaryColor: const Color.fromARGB(255, 0, 135, 197),
                  ),
            darkTheme: (!webMode)
                ? ThemeData.dark().copyWith(
                    elevatedButtonTheme: ElevatedButtonThemeData(
                        style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white)),
                    primaryColor: const Color.fromARGB(255, 0, 135, 197),
                    textTheme:
                        GoogleFonts.latoTextTheme(Theme.of(context).textTheme))
                : ThemeData.dark().copyWith(
                    elevatedButtonTheme: ElevatedButtonThemeData(
                        style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white)),
                    primaryColor: const Color.fromARGB(255, 0, 135, 197),
                  ),
            onGenerateRoute: routes.controller,
            initialRoute: 'Home',
          ),
        ),
        (bannerAd != null)
            ? SizedBox(
                height: bannerAd?.size.height.toDouble(),
                width: bannerAd?.size.width.toDouble(),
                child: AdWidget(ad: (bannerAd as BannerAd)),
              )
            : const SizedBox(height: 0),
      ],
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  _HomeState() {
    if (!webMode && foundation.kReleaseMode) {
      try {
        Fluttertoast.showToast(msg: "Showing ad");
      } catch (e) {}
      showinter();
    }
  }
  Future setup() async {
    savedata = await SharedPreferences.getInstance();
    var snap;
    try {
      snap = await FirebaseFirestore.instance
          .collection('News')
          .doc('CurrentNews')
          .get();
      snap = snap.data()['News'].replaceAll("\\n", '\n');
    } catch (e) {
      snap =
          "News not avaliable\n\nSome Things can be Long Pressed to get Details";
    }

    // Setting up shared preferences
    DateTime now = DateTime.now();
    var temppoints = await savedata.getInt('points');
    var todaysave = await savedata.getString('today');
    var todaylength = await savedata.getInt('todaylength');
    temppoints ??= 0;
    todaylength ??= 0;

    if (todaysave != DateTime(now.year, now.month, now.day).toString()) {
      todaylength = 0;
    }
    pointsleft = todaylength / 10;
    points = temppoints;
    String? settingsSave = await savedata.getString('SettingsSave');
    Map? settings = (settingsSave != null) ? jsonDecode(settingsSave) : null;
    if (settings != null) {
      roundingnumber =
          (settings['RoundingNumber'] != null) ? settings['RoundingNumber'] : 4;
      sigfigrounding = (settings['sigfigrounding'] != null)
          ? settings['sigfigrounding']
          : false;
      firstCurrencyValue = (settings['firstCurrency'] != null)
          ? settings['firstCurrency']
          : "AED - United Arab Emirates Dirham";
      secondCurrencyValue = (settings['secondCurrency'] != null)
          ? settings['secondCurrency']
          : "AED - United Arab Emirates Dirham";
      degreeDefault = (settings['degreeDefault'] != null)
          ? settings['degreeDefault']
          : true;
    }

    // Setup recomended modules
    String? tempData = savedata.getString("Recomended");
    if (tempData != null) {
      Map<String, dynamic> items = jsonDecode(tempData);

      List<String> names = items.keys.toList();
      List values = items.values.toList();
      for (int i = 0; i < values.length - 1; i++) {
        int highest = i;
        for (int j = i + 1; j < values.length; j++) {
          if (values[highest] < values[j]) {
            highest = j;
          }
        }
        int save = values[i];
        values[i] = values[highest];
        values[highest] = save;

        String saveName = names[i];
        names[i] = names[highest];
        names[highest] = saveName;
      }

      recomended = names.sublist(0, 3);
    }

    // Setup banner ad
    if (!webMode) {
      bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: (defaultTargetPlatform == TargetPlatform.android)
            ? "ca-app-pub-4914732861439858/4773120079"
            : "ca-app-pub-4914732861439858/9643457319",
        listener: BannerAdListener(
          onAdLoaded: ((ad) {}),
          onAdFailedToLoad: (ad, error) {
            ad.dispose();
          },
        ),
        request: const AdRequest(),
      );

      bannerAd?.load();
    }

    return snap;
  }

  int _barIndex = 0;
  List<String> recomended = [];

  Map<String, Widget> nameWidgetDatabase = {
    'Calculator': const BoolCalculator(),
    'Converter': const Converter(),
    'GCF': const GCF(),
    'LCM': const LCM(),
    'Pythagorean': const Pythagorean(),
    'Trigonometry': const Trigonometry(),
    'Root Finder': const RootFinder(),
    'Periodic Table': const PeriodicTable(),
    '2D Vector Addition': const VectorAddition(),
    '2D Vector Subtraction': const VectorSubtraction(),
    'Graphs': const Graphs(),
    'Work': const Work(),
    'Gravitational Potential Energy': const GravitationalPotentialEnergy(),
    'Coefficient of Friction': const CoefficientofFriction(),
    'Kinetic Energy': const KineticEnergy(),
    "Ohm's Law": const Ohm(),
    "Sequences": const Sequence(),
    "Series": const Series(),
    "Simple Interest": const SimpleInterest(),
    "Compound Interest": const CompoundInterest(),
    "Ordinary Annuity": const OrdinaryAnnuity(),
    "Annuity Due": const AnnuityDue(),
    "Degree Radian Converter": const DegAndRad(),
    "Simplifying Radicals": const SimplifyingRadicals(),
    "Custom Formulas": const CustomFormulas(),
    'Boolean Calculator': const BoolCalculator(),
    'Test Cases': const TestCases(),
    "Factors": const Factors(),
    "Prime": const Prime(),
  };
  Random randomnum = Random();
  RewardedAd? ad;
  @override
  initState() {
    super.initState();
    void rate() async {
      if (randomnum.nextInt(10) == 0 &&
          defaultTargetPlatform == TargetPlatform.android &&
          await GalaxyStoreInAppReview.isAvailable()) {
        await GalaxyStoreInAppReview.requestReview();
      }
    }

    rate();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: setup(),
      builder: (context, snap) {
        List<Widget> bodyChildren = [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: GridView.extent(
              shrinkWrap: true,
              childAspectRatio: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              maxCrossAxisExtent: 1500,
              children: [
                Card(
                  elevation: 10,
                  color: (MediaQuery.of(context).platformBrightness ==
                          Brightness.light)
                      ? const Color.fromARGB(255, 165, 226, 255)
                      : const Color.fromARGB(255, 0, 135, 197),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: FractionallySizedBox(
                    key: ObjectKey(points),
                    widthFactor: 0.9,
                    heightFactor: 0.9,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 3,
                          child: FittedBox(
                              child: Text(
                            'Points:\n$points',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color:
                                  (MediaQuery.of(context).platformBrightness ==
                                          Brightness.light)
                                      ? Colors.black
                                      : Colors.white,
                            ),
                          )),
                        ),
                        (() {
                          if (!webMode && false) {
                            return Expanded(
                              flex: 1,
                              child: FractionallySizedBox(
                                widthFactor: 0.5,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        const Color.fromARGB(255, 0, 135, 197)),
                                  ),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) =>
                                          AlertDialog.adaptive(
                                        title: const Text(
                                            "Would you like to watch an ad to get 1-5 points for free?"),
                                        actions: [
                                          ElevatedButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: const Text("Cancel"),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              //Navigator.pop(context);
                                              try {
                                                var rewardedAd;
                                                RewardedAd.load(
                                                  adUnitId: (defaultTargetPlatform ==
                                                          TargetPlatform
                                                              .android)
                                                      ? 'ca-app-pub-4914732861439858/8814232396'
                                                      : (defaultTargetPlatform ==
                                                              TargetPlatform
                                                                  .iOS)
                                                          ? 'ca-app-pub-4914732861439858/8194257629'
                                                          : '',
                                                  request: const AdRequest(),
                                                  rewardedAdLoadCallback:
                                                      RewardedAdLoadCallback(
                                                    onAdLoaded: (ad) {
                                                      rewardedAd = ad;
                                                      rewardedAd?.show(
                                                        onUserEarnedReward:
                                                            ((ad, reward) {
                                                          debugPrint(
                                                              "My Reward Amount -> ${reward.amount}");
                                                        }),
                                                      );

                                                      rewardedAd
                                                              ?.fullScreenContentCallback =
                                                          FullScreenContentCallback(
                                                              onAdFailedToShowFullScreenContent:
                                                                  (RewardedAd
                                                                          ad,
                                                                      err) {
                                                        ad.dispose();
                                                      }, onAdDismissedFullScreenContent:
                                                                  (RewardedAd
                                                                      ad) {
                                                        ad.dispose();
                                                        int gotpoints =
                                                            randomnum.nextInt(
                                                                    5) +
                                                                1;
                                                        points += gotpoints;
                                                        savedata.setInt(
                                                            'points', points);
                                                        setState(() {});
                                                        showDialog(
                                                          context: context,
                                                          builder: (builder) =>
                                                              AlertDialog(
                                                            title: Text(
                                                              "You got $gotpoints points",
                                                              style: TextStyle(
                                                                  color: (MediaQuery.of(context)
                                                                              .platformBrightness ==
                                                                          Brightness
                                                                              .light)
                                                                      ? Colors
                                                                          .black
                                                                      : Colors
                                                                          .white),
                                                            ),
                                                          ),
                                                        );
                                                      });
                                                    },
                                                    onAdFailedToLoad: (err) {
                                                      debugPrint(err.message);
                                                    },
                                                  ),
                                                );
                                              } catch (e) {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        AlertDialog.adaptive(
                                                          title: Text(
                                                            "Ad not avaliable",
                                                            style: TextStyle(
                                                                color: (MediaQuery.of(context)
                                                                            .platformBrightness ==
                                                                        Brightness
                                                                            .light)
                                                                    ? Colors
                                                                        .black
                                                                    : Colors
                                                                        .white),
                                                          ),
                                                        ));
                                              }
                                            },
                                            child: const Text("Watch"),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                  child: const FractionallySizedBox(
                                    widthFactor: 0.95,
                                    heightFactor: 0.5,
                                    child: FittedBox(child: Text("Get Points")),
                                  ),
                                ),
                              ),
                            );
                          }
                          return const SizedBox();
                        })()
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Stack(
                    children: [
                      FractionallySizedBox(
                        widthFactor: 1,
                        heightFactor: 1,
                        child: RotatedBox(
                          quarterTurns: -1,
                          child: LinearProgressIndicator(
                            value: pointsleft,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: FractionallySizedBox(
                          widthFactor: 0.95,
                          heightFactor: pointsleft,
                          child: FittedBox(
                            child: Text(
                                "${(pointsleft * 10).toStringAsFixed(0)}/10 points left to collect today"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                CardButton(
                  text: 'Calculator',
                  menu: "A normal calculator",
                ),
                CardButton(
                  text: 'Converter',
                  menu: "Converts numbers to different types",
                ),
                CardButton(
                  text: 'Graphs',
                ),
                CardButton(
                  text: 'Custom Formulas',
                  menu: "Create, save, and use your own formulas",
                ),
                /*CardButton(
                  text: 'Surface Area',
                ),
                CardButton(
                  text: 'Volume',
                ),*/
                CardButton(
                  text: 'Simplifying Radicals',
                ),
                ExtendedButton(
                  text: "Physics",
                  children: [
                    SectionButton(
                      text: "2D Vector Addition",
                      menu: "Add multiple vectors together",
                    ),
                    SectionButton(
                      text: "2D Vector Subtraction",
                      menu: "Subtract multiple vectors",
                    ),
                    SectionButton(text: 'Work'),
                    SectionButton(text: 'Gravitational Potential Energy'),
                    SectionButton(text: 'Kinetic Energy'),
                    SectionButton(text: 'Coefficient of Friction'),
                    SectionButton(text: "Ohm's Law"),
                  ],
                ),
                CardButton(
                  text: 'Periodic Table',
                ),
                ExtendedButton(
                  text: "Triangles",
                  children: [
                    SectionButton(text: "Trigonometry"),
                    SectionButton(text: 'Pythagorean'),
                    SectionButton(text: 'Degree Radian Converter'),
                  ],
                ),
                ExtendedButton(
                  text: "Finance",
                  children: [
                    SectionButton(text: "Simple Interest"),
                    SectionButton(text: 'Compound Interest'),
                    SectionButton(
                        text: 'Ordinary Annuity',
                        menu: "Compounds after payment"),
                    SectionButton(
                        text: 'Annuity Due', menu: "Compounds before payment"),
                  ],
                ),
                ExtendedButton(
                  text: "Sequences and Series",
                  children: [
                    SectionButton(text: "Sequences"),
                    SectionButton(text: 'Series'),
                  ],
                ),
                CardButton(
                  text: 'Root Finder',
                ),
                ExtendedButton(
                  text: "Boolean Algebra",
                  children: [
                    SectionButton(
                        text: "Boolean Calculator",
                        menu: "A calculator specially made for boolean math"),
                    SectionButton(
                      text: "Test Cases",
                      menu: "Get all possible cases for a boolean formula",
                    ),
                  ],
                ),
                CardButton(
                  text: 'GCF',
                ),
                CardButton(
                  text: 'LCM',
                ),
                CardButton(
                  text: 'Factors',
                ),
                CardButton(
                  text: 'Prime',
                ),
                (() {
                  if (webMode) {
                    return Card(
                      elevation: 10,
                      color: (MediaQuery.of(context).platformBrightness ==
                              Brightness.light)
                          ? const Color.fromARGB(255, 165, 226, 255)
                          : const Color.fromARGB(255, 0, 135, 197),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: const FractionallySizedBox(
                        widthFactor: 0.9,
                        heightFactor: 0.9,
                        child: FittedBox(
                            child:
                                Text("Updated Nov 26th, 2023\nVersion 3.7.0")),
                      ),
                    );
                  }
                  return const SizedBox();
                })(),
              ],
            ),
          ),
        ];

        if (snap.hasData) {
          if (recomended.length >= 3) {
            try {
              bodyChildren
                  .add((nameWidgetDatabase[recomended[0]] ?? const SizedBox()));
              bodyChildren
                  .add((nameWidgetDatabase[recomended[1]] ?? const SizedBox()));
              bodyChildren
                  .add((nameWidgetDatabase[recomended[2]] ?? const SizedBox()));
            } catch (e) {}
          }
          if (webMode && defaultTargetPlatform == TargetPlatform.android) {
            return Scaffold(
              body: Center(
                child: FractionallySizedBox(
                  widthFactor: 0.5,
                  heightFactor: 0.3,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 10,
                      backgroundColor: const Color.fromARGB(255, 0, 135, 197),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                    ),
                    onPressed: () {
//                       Comment for Mobile Use

//                        html.AnchorElement anchorElement =
//                            html.AnchorElement(href: 'ultimatecalculator.apk');
//                        anchorElement.download = 'ultimatecalculator.apk';
//                        anchorElement.click();
                    },
                    child: const FractionallySizedBox(
                        widthFactor: 0.9,
                        heightFactor: 0.9,
                        child: FittedBox(child: Text("Download for Android"))),
                  ),
                ),
              ),
            );
          }
          return Scaffold(
            appBar: (_barIndex == 0)
                ? AppBar(
                    foregroundColor:
                        (MediaQuery.of(context).platformBrightness ==
                                Brightness.light)
                            ? Colors.black
                            : Colors.white,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    actions: [
                      IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => Dialog(
                                    child: Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            "Try out my new app\n\nWorkbook\n\nOrganize and manage your projects",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: (MediaQuery.of(context)
                                                            .platformBrightness ==
                                                        Brightness.light)
                                                    ? Colors.black
                                                    : Colors.white),
                                          ),
                                          Center(
                                            child: ElevatedButton(
                                                onPressed: () async {
                                                  try {
                                                    await launchUrl(Uri.parse(
                                                        'https://workbook.onrender.com/#/'));
                                                  } catch (e) {
                                                    Navigator.pop(context);
                                                  }
                                                },
                                                child: const Text("Website")),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ));
                        },
                        icon: const Icon(Icons.question_mark),
                      ),
                      (!webMode && false)
                          ? IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text(snap.data.toString(),
                                          style: TextStyle(
                                              color: (MediaQuery.of(context)
                                                          .platformBrightness ==
                                                      Brightness.light)
                                                  ? Colors.black
                                                  : Colors.white)),
                                      actions: [
                                        ElevatedButton(
                                            onPressed: () async {
                                              try {
                                                await launchUrl(Uri.parse(
                                                    'https://ultimate-calculator.onrender.com'));
                                              } catch (e) {
                                                Navigator.pop(context);
                                              }
                                            },
                                            child: const Text("Website"))
                                      ],
                                    );
                                  },
                                );
                              },
                              icon: const Icon(Icons.newspaper))
                          : const SizedBox(),
                    ],
                    leading: IconButton(
                      icon: const Icon(Icons.settings),
                      onPressed: () => Navigator.pushNamed(context, "Settings"),
                    ),
                  )
                : null,
            bottomNavigationBar: (recomended.isNotEmpty)
                ? BottomNavigationBar(
                    currentIndex: _barIndex,
                    selectedItemColor:
                        (MediaQuery.of(context).platformBrightness ==
                                Brightness.light)
                            ? Colors.black
                            : Colors.white,
                    unselectedItemColor: Colors.grey,
                    showUnselectedLabels: true,
                    showSelectedLabels: true,
                    items: [
                      const BottomNavigationBarItem(
                          icon: Icon(Icons.home), label: "Home"),
                      BottomNavigationBarItem(
                          icon: const Icon(Icons.label), label: recomended[0]),
                      BottomNavigationBarItem(
                          icon: const Icon(Icons.label), label: recomended[1]),
                      BottomNavigationBarItem(
                          icon: const Icon(Icons.label), label: recomended[2]),
                    ],
                    onTap: (index) {
                      setState(() {
                        _barIndex = index;
                      });
                    },
                  )
                : null,
            floatingActionButton: (_barIndex == 0)
                ? FloatingActionButton(
                    backgroundColor: const Color.fromARGB(255, 255, 184, 0),
                    child: const Icon(
                      Icons.add_rounded,
                    ),
                    onPressed: () {
                      TextEditingController newone = TextEditingController();
                      showAnimatedDialog(
                        context: context,
                        barrierDismissible: true,
                        animationType: DialogTransitionType.scale,
                        curve: Curves.fastOutSlowIn,
                        duration: const Duration(milliseconds: 250),
                        builder: (context) => SimpleDialog(
                          title: Text(
                            'Send a Request to add a Function or Report a Bug',
                            style: TextStyle(
                                color: (MediaQuery.of(context)
                                            .platformBrightness ==
                                        Brightness.light)
                                    ? Colors.black
                                    : Colors.white),
                          ),
                          children: [
                            FractionallySizedBox(
                              widthFactor: 0.8,
                              child: TextField(
                                controller: newone,
                              ),
                            ),
                            FractionallySizedBox(
                              widthFactor: 0.65,
                              child: ElevatedButton(
                                onPressed: () {
                                  try {
                                    if (newone.text.isNotEmpty) {
                                      FirebaseFirestore.instance
                                          .collection('Function Suggestions')
                                          .add({'New Function': newone.text});
                                      Navigator.pop(context);
                                      showDialog(
                                          context: context,
                                          builder: (context) =>
                                              const AlertDialog(
                                                title: Text(
                                                    'Thank you for your request'),
                                              ));
                                    }
                                  } catch (e) {
                                    showDialog(
                                        context: context,
                                        builder: (context) => const AlertDialog(
                                              title: Text(
                                                  'Failed to send request'),
                                            ));
                                  }
                                },
                                child: const Text('Add'),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  )
                : null,
            body: bodyChildren[_barIndex],
          );
        }

        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
