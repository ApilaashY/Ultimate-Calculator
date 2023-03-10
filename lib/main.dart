// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Modules/routes.dart' as routes;
import 'Modules/card_button.dart';
import 'Modules/loadas.dart';
import 'firebase_options.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

var savedata;
int roundingnumber = 4;
bool sigfigrounding = false;
int points = 0;
double pointsleft = 0;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

Future setup() async {
  // Setting up shared preferences
  savedata = await SharedPreferences.getInstance();
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
  if (savedata.getString('SettingsSave') != null) {
    roundingnumber =
        (jsonDecode(savedata.getString('SettingsSave'))['RoundingNumber'] !=
                null)
            ? jsonDecode(savedata.getString('SettingsSave'))['RoundingNumber']
            : 4;
    sigfigrounding =
        (jsonDecode(savedata.getString('SettingsSave'))['sigfigrounding'] !=
                null)
            ? jsonDecode(savedata.getString('SettingsSave'))['sigfigrounding']
            : false;
  } else {
    roundingnumber = 4;
    sigfigrounding = false;
  }

  return 'done';
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      theme: ThemeData.light().copyWith(
          primaryColor: const Color.fromARGB(255, 0, 135, 197),
          textTheme:
              GoogleFonts.robotoMonoTextTheme(Theme.of(context).textTheme)),
      darkTheme: ThemeData.dark().copyWith(
          primaryColor: const Color.fromARGB(255, 0, 135, 197),
          textTheme:
              GoogleFonts.robotoMonoTextTheme(Theme.of(context).textTheme)),
      onGenerateRoute: routes.controller,
      initialRoute: 'Home',
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Random randomnum = Random();
  RewardedAd? ad = null;
  initState() {
    super.initState();
    if (randomnum.nextInt(10) == 0 &&
        defaultTargetPlatform == TargetPlatform.android) {
      Future.delayed(Duration.zero, () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              'Would you like to rate my app',
              style: TextStyle(
                  color: (MediaQuery.of(context).platformBrightness ==
                          Brightness.light)
                      ? Colors.black
                      : Colors.white),
            ),
            actions: [
              ElevatedButton(
                  onPressed: () async {
                    try {
                      await launchUrl(Uri.parse(
                          'https://apps.samsung.com/appquery/appDetail.as?appId=app.ultimatecalculator.www'));
                    } catch (e) {
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Rate'))
            ],
          ),
        );
      });
    }
    //showinter();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: setup(),
      builder: (context, snap) {
        if (snap.hasData) {
          return Scaffold(
            appBar: AppBar(
              foregroundColor: (MediaQuery.of(context).platformBrightness ==
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
                          builder: (context) => AlertDialog(
                                title: const Text(
                                    "The Ultimate Calculator will be removed from the Samsung Galaxy Store on March 1st, 2022, if you wish to continue using it, download it from the Ultimate Calculator website."),
                                actions: [
                                  ElevatedButton(
                                      onPressed: () async {
                                        try {
                                          await launchUrl(Uri.parse(
                                              'https://ultimatecalculator.netlify.app'));
                                        } catch (e) {
                                          Navigator.pop(context);
                                        }
                                      },
                                      child: const Text("Website"))
                                ],
                              ));
                    },
                    icon: const Icon(Icons.question_mark_rounded))
              ],
              leading: IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () => Navigator.pushNamed(context, "Settings"),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: (MediaQuery.of(context).platformBrightness ==
                      Brightness.light)
                  ? const Color.fromARGB(255, 165, 226, 255)
                  : const Color.fromARGB(255, 0, 135, 197),
              child: Icon(
                Icons.add_rounded,
                color: (MediaQuery.of(context).platformBrightness ==
                        Brightness.light)
                    ? Colors.black
                    : Colors.white,
              ),
              onPressed: () {
                TextEditingController newone = TextEditingController();
                showDialog(
                  context: context,
                  builder: (context) => SimpleDialog(
                    title: Text(
                      'Add Function or Report Bug',
                      style: TextStyle(
                          color: (MediaQuery.of(context).platformBrightness ==
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
                                    builder: (context) => const AlertDialog(
                                          title: Text(
                                              'Thank you for your request'),
                                        ));
                              }
                            } catch (e) {
                              showDialog(
                                  context: context,
                                  builder: (context) => const AlertDialog(
                                        title: Text('Failed to send request'),
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
            ),
            body: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                scrollDirection: (MediaQuery.of(context).size.height >
                        MediaQuery.of(context).size.width)
                    ? Axis.vertical
                    : Axis.horizontal,
                children: [
                  Card(
                    key: UniqueKey(),
                    elevation: 0,
                    color: (MediaQuery.of(context).platformBrightness ==
                            Brightness.light)
                        ? const Color.fromARGB(255, 165, 226, 255)
                        : const Color.fromARGB(255, 0, 135, 197),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: FractionallySizedBox(
                      key: const ObjectKey("points"),
                      widthFactor: 0.85,
                      heightFactor: 0.85,
                      child: Column(
                        children: [
                          Expanded(
                            child: FittedBox(
                                child: Text(
                              'Points:\n$points',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: (MediaQuery.of(context)
                                            .platformBrightness ==
                                        Brightness.light)
                                    ? Colors.black
                                    : Colors.white,
                              ),
                            )),
                          ),
                          ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    const Color.fromARGB(255, 0, 135, 197)),
                              ),
                              onPressed: () {
                                var rewardedAd;
                                RewardedAd.load(
                                  adUnitId: (defaultTargetPlatform ==
                                          TargetPlatform.android)
                                      ? 'ca-app-pub-4914732861439858/8814232396'
                                      : (defaultTargetPlatform ==
                                              TargetPlatform.iOS)
                                          ? 'ca-app-pub-4914732861439858/8194257629'
                                          : '',
                                  request: const AdRequest(),
                                  rewardedAdLoadCallback:
                                      RewardedAdLoadCallback(
                                    onAdLoaded: (ad) {
                                      rewardedAd = ad;
                                      rewardedAd?.show(
                                        onUserEarnedReward: ((ad, reward) {
                                          debugPrint(
                                              "My Reward Amount -> ${reward.amount}");
                                        }),
                                      );

                                      rewardedAd?.fullScreenContentCallback =
                                          FullScreenContentCallback(
                                              onAdFailedToShowFullScreenContent:
                                                  (RewardedAd ad, err) {
                                        ad.dispose();
                                      }, onAdDismissedFullScreenContent:
                                                  (RewardedAd ad) {
                                        ad.dispose();
                                        int gotpoints =
                                            randomnum.nextInt(5) + 1;
                                        points += gotpoints;
                                        savedata.setInt('points', points);
                                        setState(() {});
                                        showDialog(
                                          context: context,
                                          builder: (builder) => AlertDialog(
                                            title: Text(
                                                "You got $gotpoints points"),
                                          ),
                                        );
                                      });
                                    },
                                    onAdFailedToLoad: (err) {
                                      debugPrint(err.message);
                                    },
                                  ),
                                );
                              },
                              child: const Text("Get Points"))
                        ],
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 0,
                    child: RotatedBox(
                      quarterTurns: -1,
                      child: LinearProgressIndicator(
                        value: pointsleft,
                      ),
                    ),
                  ),
                  CardButton(
                    text: 'Calculator',
                  ),
                  CardButton(
                    text: 'Converter',
                  ),
                  /*CardButton(
                  text: 'Surface Area',
                ),
                CardButton(
                  text: 'Volume',
                ),*/
                  CardButton(
                    text: 'Science',
                  ),
                  CardButton(
                    text: 'Root Finder',
                  ),
                  CardButton(
                    text: 'Pythagorean',
                  ),
                  CardButton(
                    text: 'Trigonometry',
                  ),
                  CardButton(
                    text: 'GCF',
                  ),
                  CardButton(
                    text: 'LCM',
                  ),
                  CardButton(
                    text: 'Sequences',
                  ),
                  CardButton(
                    text: 'Series',
                  ),
                  CardButton(
                    text: 'Finance',
                  ),
                ],
              ),
            ),
          );
        }
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
