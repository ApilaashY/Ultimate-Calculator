// ignore_for_file: avoid_print, empty_catches, library_private_types_in_public_api

import 'dart:convert';
import 'dart:io';

import 'package:app/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:app/Modules/globalfunctions.dart';

var unittypes = [
  'Length',
  'Volume',
  'Weight',
  'Currency',
  'Temperature',
  'Time',
];
var unittypevalue = unittypes[0];
var types = lengthtypes;
var firsttypevalue = lengthtypes[0];
var secondtypevalue = lengthtypes[0];
var lengthtypes = [
  'Millimeter',
  'Centimeter',
  'Decimeter',
  'Meter',
  'Decameter',
  'Hecameter',
  'Killometer',
  'Inch',
  'Feet',
  'Yard',
  'Mile'
];
var volumetypes = [
  'Milliliter',
  'Centiliter',
  'Deciliter',
  'Liter',
  'Decaliter',
  'Hecaliter',
  'Killoliter',
  'Teaspoon',
  'Tablespoon',
  'US Cup',
  'US Pint',
  'US Quart',
  'US Gallon',
  'Imperial Cup',
  'Imperial Pint',
  'Imperial Quart',
  'Imperial Gallon'
];
var weighttypes = [
  'Milligram',
  'Centigram',
  'Decigram',
  'Gram',
  'Decagram',
  'Hecagram',
  'Killogram',
  'Ounce',
  'Pound',
  'US Ton',
  'Imperial Ton'
];
var temperaturetypes = [
  'Celsius',
  'Fahrenheit',
  'Kelvin',
];
var timetypes = [
  'Nanosecond',
  'Microsecond',
  'Millisecond',
  'Second',
  'Minute',
  'Hour',
  'Day',
  'Week',
  'Month',
  'Calendar Year',
  'Decade',
  'Century'
];
var currencytypes = [
  'AED - United Arab Emirates Dirham',
  'AFN - Afghan Afghani',
  'ALL - Albanian Lek',
  'AMD - Armenian Dram',
  'ANG - Netherlands Antillean Guilder',
  'AOA - Angolan Kwanza',
  'ARS - Argentine Peso',
  'AUD - Australian Dollar',
  'AWG - Aruban Florin',
  'AZN - Azerbaijani Manat',
  'BAM - Bosnia-Herzegovina Convertible Mark',
  'BBD - Bajan dollar',
  'BDT - Bangladeshi Taka',
  'BGN - Bulgarian Lev',
  'BHD - Bahraini Dinar',
  'BIF - Burundian Franc',
  'BMD - Bermudan Dollar',
  'BND - Brunei Dollar',
  'BOB - Bolivian Boliviano',
  'BRL - Brazilian Real',
  'BSD - Bahamian Dollar',
  'BTC - Bitcoin',
  'BTN - Bhutan currency',
  'BWP - Botswanan Pula',
  'BYN - Belarusian Ruble',
  'BZD - Belize Dollar',
  'CAD - Canadian Dollar',
  'CDF - Congolese Franc',
  'CHF - Swiss Franc',
  'CLF - Chilean Unit of Account (UF)',
  'CLP - Chilean Peso',
  'CNH - Chinese Yuan',
  'CNY - Chinese Yuan',
  'COP - Colombian Peso',
  'CRC - Costa Rican Colón',
  'CUC - Cuban Convertible Peso',
  'CUP - Cuban Peso',
  'CVE - Cape Verdean Escudo',
  'CZK - Czech Koruna',
  'DJF - Djiboutian Franc',
  'DKK - Danish Krone',
  'DOP - Dominican Peso',
  'DZD - Algerian Dinar',
  'EGP - Egyptian Pound',
  'ERN - Eritrean Nakfa',
  'ETB - Ethiopian Birr',
  'EUR - Euro',
  'FJD - Fijian Dollar',
  'FKP - Falkland Island Pound',
  'GBP - Pound sterling',
  'GEL - Georgian Lari',
  'GGP - Pound sterling',
  'GHS - Ghanaian Cedi',
  'GIP - Gibraltar Pound',
  'GMD - Gambian dalasi',
  'GNF - Guinean Franc',
  'GTQ - Guatemalan Quetzal',
  'GYD - Guyanaese Dollar',
  'HKD - Hong Kong Dollar',
  'HNL - Honduran Lempira',
  'HRK - Croatian Kuna',
  'HTG - Haitian Gourde',
  'HUF - Hungarian Forint',
  'IDR - Indonesian Rupiah',
  'ILS - Israeli New Shekel',
  'IMP - Isle of Man Pound',
  'INR - Indian Rupee',
  'IQD - Iraqi Dinar',
  'IRR - Iranian Rial',
  'ISK - Icelandic Króna',
  'JEP - Jersey Pound',
  'JMD - Jamaican Dollar',
  'JOD - Jordanian Dinar',
  'JPY - Japanese Yen',
  'KES - Kenyan Shilling',
  'KGS - Kyrgystani Som',
  'KHR - Cambodian riel',
  'KMF - Comorian franc',
  'KPW - North Korean Won',
  'KRW - South Korean won',
  'KWD - Kuwaiti Dinar',
  'KYD - Cayman Islands Dollar',
  'KZT - Kazakhstani Tenge',
  'LAK - Laotian Kip',
  'LBP - Lebanese pound',
  'LKR - Sri Lankan Rupee',
  'LRD - Liberian Dollar',
  'LSL - Lesotho loti',
  'LYD - Libyan Dinar',
  'MAD - Moroccan Dirham',
  'MDL - Moldovan Leu',
  'MGA - Malagasy Ariary',
  'MKD - Macedonian Denar',
  'MMK - Myanmar Kyat',
  'MNT - Mongolian Tughrik',
  'MOP - Macanese Pataca',
  'MRU - Mauritian Rupee',
  'MUR - Mauritian Rupee',
  'MVR - Maldivian Rufiyaa',
  'MWK - Malawian Kwacha',
  'MXN - Mexican Peso',
  'MYR - Malaysian Ringgit',
  'MZN - Mozambican metical',
  'NAD - Namibian dollar',
  'NGN - Nigerian Naira',
  'NIO - Nicaraguan Córdoba',
  'NOK - Norwegian Krone',
  'NPR - Nepalese Rupee',
  'NZD - New Zealand Dollar',
  'OMR - Omani Rial',
  'PAB - Panamanian Balboa',
  'PEN - Sol',
  'PGK - Papua New Guinean Kina',
  'PHP - Philippine peso',
  'PKR - Pakistani Rupee',
  'PLN - Poland złoty',
  'PYG - Paraguayan Guarani',
  'QAR - Qatari Rial',
  'RON - Romanian Leu',
  'RSD - Serbian Dinar',
  'RUB - Russian Ruble',
  'RWF - Rwandan franc',
  'SAR - Saudi Riyal',
  'SBD - Solomon Islands Dollar',
  'SCR - Seychellois Rupee',
  'SDG - Sudanese pound',
  'SEK - Swedish Krona',
  'SGD - Singapore Dollar',
  'SHP - Saint Helenian Pound',
  'SLL - Sierra Leonean Leone',
  'SOS - Somali Shilling',
  'SRD - Surinamese Dollar',
  'SSP - South Sudanese Pound',
  'STD - Sao Tomean Dobra',
  'STN - Sao Tomean Dobra',
  'SVC - Singapore Dollar',
  'SYP - Syrian Pound',
  'SZL - Swazi Lilangeni',
  'THB - Thai Baht',
  'TJS - Tajikistani Somoni',
  'TMT - Turkmenistani manat',
  'TND - Tunisian Dinar',
  'TOP - Tongan Paʻanga',
  'TRY - Turkish lira',
  'TTD - Trinidad & Tobago Dollar',
  'TWD - New Taiwan dollar',
  'TZS - Tanzanian Shilling',
  'UAH - Ukrainian hryvnia',
  'UGX - Ugandan Shilling',
  'USD - United States Dollar',
  'UYU - Uruguayan Peso',
  'UZS - Uzbekistani Som',
  'VES - Sovereign Bolivar',
  'VND - Vietnamese dong',
  'VUV - Ni-Vanuatu Vatu',
  'WST - Samoa Tala',
  'XAF - Central African CFA franc',
  'XAG - Silver Ounce',
  'XAU - Gold Ounce',
  'XCD - East Caribbean Dollar',
  'XDR - IMF Special Drawing Rights',
  'XOF - West African CFA franc',
  'XPD - Ounces of Palladium',
  'XPF - CFP Franc',
  'XPI - Platinum Ounce',
  'YER - Yemeni Rial',
  'ZAR - South African Rand',
  'ZMW - Zambian Kwacha',
  'ZWL - Zimbabwean Dollar'
];

var unitmap = {
  // Length
  'Meter': 1.0,
  'Millimeter': 1000.0,
  'Centimeter': 100.0,
  'Decimeter': 10.0,
  'Decameter': 0.1,
  'Hecameter': 0.01,
  'Killometer': 0.001,
  'Inch': 39.37007874,
  'Feet': 3.280839895,
  'Yard': 1.093613298,
  'Mile': 0.0006213711922,
  // Area

  // Volume
  'Liter': 1.0,
  'Milliliter': 1000.0,
  'Centiliter': 100.0,
  'Deciliter': 10.0,
  'Decaliter': 0.1,
  'Hecaliter': 0.01,
  'Killoliter': 0.001,
  'US Teaspoon': 202.884136211058,
  'US Tablespoon': 67.628045403686,
  'US Cup': 4.1666666666667,
  'US Pint': 2.1133764188651872,
  'US Quart': 1.0566882094325936,
  'US Gallon': 0.2642007926,
  'Imperial Teaspoon': 168.93631288135127040,
  'Imperial Tablespoon': 56.312104296954814464,
  'Imperial Cup': 3.5195082824588410880,
  'Imperial Pint': 1.7597539863927023616,
  'Imperial Quart': 0.8798769931963511808,
  'Imperial Gallon': 0.2199692482990877952,
  // Weight
  'Gram': 1,
  'Milligram': 1000,
  'Centigram': 100,
  'Decigram': 10,
  'Decagram': 0.1,
  'Hecagram': 0.01,
  'Killogram': 0.001,
  'Ounce': 0.035273961949580410880,
  'Pound': 0.0022046226218487758848,
  'US Ton': 0.0000011023113109243881472,
  'Imperial Ton': 0.00000098420652761106071552,
  // Time
  'Nanosecond': 3600000000000,
  'Microsecond': 3600000000,
  'Millisecond': 3600000,
  'Second': 3600,
  'Minute': 60,
  'Hour': 1,
  'Day': 0.041666666666667,
  'Week': 0.0059523809523809523809523809,
  'Month': 0.0013698630136986301369863013,
  'Calendar Year': 0.0001141552511415525114155251,
  'Decade': 0.0000114155251141552511415525,
  'Century': 0.0000011415525114155251141552,
};

var positionnumber = 0.5;
var firstnumbercontroller = TextEditingController();
var secondnumbercontroller = TextEditingController();
var wifiopac = 0;
var icontype = 'Warning';

class Converter extends StatefulWidget {
  const Converter({super.key});

  @override
  _ConverterState createState() => _ConverterState();
}

class _ConverterState extends State<Converter> {
  ThemeData theme = ThemeData.light();
  ThemeData darktheme = ThemeData.dark();
  late Map rates;
  var it = 1;
  _ConverterState() {
    void setmoney() async {
      try {
        try {
          Uri baseUri = Uri.parse('http://www.convertmymoney.com/rates.json');
          final response = await http.get(baseUri);
          Map<String, dynamic> jsonResponse =
              json.decode(response.body) as Map<String, dynamic>;
          rates = jsonResponse.remove("rates") as Map<String, dynamic>;
          icontype = 'Good';
          savedata.setString('rates', json.encode(rates));
        } catch (er) {
          var strrates = savedata.getString('rates');
          try {
            rates = json.decode(strrates);
            icontype = 'Caution';
          } catch (e) {
            icontype = 'Warning';
          }
        }
        setState(() {});
      } catch (e) {}
    }

    setmoney();
  }

  void update(place) {
    try {
      if (place == 'first') {
        var answer = '';
        if (firsttypevalue == 'Celsius' && secondtypevalue == 'Fahrenheit') {
          answer = ((double.parse(firstnumbercontroller.text) * 9 / 5) + 32)
              .toString();
        } else if (firsttypevalue == 'Celsius' && secondtypevalue == 'Kelvin') {
          answer =
              (double.parse(firstnumbercontroller.text) + 273.15).toString();
        } else if (firsttypevalue == 'Celsius' &&
            secondtypevalue == 'Celsius') {
          answer = (double.parse(firstnumbercontroller.text)).toString();
        } else if (firsttypevalue == 'Fahrenheit' &&
            secondtypevalue == 'Celsius') {
          answer = ((double.parse(firstnumbercontroller.text) - 32) * 5 / 9)
              .toString();
        } else if (firsttypevalue == 'Fahrenheit' &&
            secondtypevalue == 'Kelvin') {
          answer =
              ((double.parse(firstnumbercontroller.text) - 32) * 5 / 9 + 273.15)
                  .toString();
        } else if (firsttypevalue == 'Fahrenheit' &&
            secondtypevalue == 'Fahrenheit') {
          answer = (double.parse(firstnumbercontroller.text)).toString();
        } else if (firsttypevalue == 'Kelvin' && secondtypevalue == 'Celsius') {
          answer =
              (double.parse(firstnumbercontroller.text) - 273.15).toString();
        } else if (firsttypevalue == 'Kelvin' &&
            secondtypevalue == 'Fahrenheit') {
          answer =
              ((double.parse(firstnumbercontroller.text) - 273.15) * 9 / 5 + 32)
                  .toString();
        } else if (firsttypevalue == 'Kelvin' && secondtypevalue == 'Kelvin') {
          answer = (double.parse(firstnumbercontroller.text)).toString();
        } else if (unittypevalue == 'Currency') {
          answer = (double.parse(firstnumbercontroller.text) /
                  rates[(firsttypevalue.split(' - '))[0]] *
                  rates[(secondtypevalue.split(' - '))[0]])
              .toString();
          answer = roundto(answer);
        } else {
          answer = (double.parse(firstnumbercontroller.text) /
                  unitmap[firsttypevalue]! *
                  unitmap[secondtypevalue]!)
              .toString();
        }
        answer = answer.replaceAll('.0', '');
        setState(() {
          secondnumbercontroller.text = answer;
        });
      }
    } catch (e) {
      print(e);
      if (place == 'first') {
        secondnumbercontroller.text = '';
      } else if (place == 'second') {
        firstnumbercontroller.text = '';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        foregroundColor:
            (MediaQuery.of(context).platformBrightness == Brightness.light)
                ? Colors.black
                : Colors.white,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: (() {
        if (MediaQuery.of(context).size.height >
            MediaQuery.of(context).size.width) {
          return Stack(
            children: [
              Align(
                alignment: const Alignment(0, -0.8),
                child: FractionallySizedBox(
                  heightFactor: 0.2,
                  widthFactor: 0.4,
                  child: FittedBox(
                    child: Text(
                      'Unit Type',
                      style: TextStyle(
                        color: (MediaQuery.of(context).platformBrightness ==
                                Brightness.light)
                            ? Colors.black
                            : Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: const Alignment(0, -0.9),
                child: FractionallySizedBox(
                  child: Opacity(
                    opacity: double.parse(wifiopac.toString()),
                    child: IconButton(icon: (() {
                      if (icontype == 'Good') {
                        return const Icon(
                          Icons.check,
                          color: Colors.green,
                        );
                      } else if (icontype == 'Caution') {
                        return const Icon(
                          Icons.warning,
                          color: Colors.yellow,
                        );
                      } else if (icontype == 'Warning') {
                        return const Icon(
                          Icons.circle,
                          color: Colors.red,
                        );
                      } else {
                        return const Icon(Icons.question_mark);
                      }
                    })(), onPressed: () {
                      if (icontype != 'Good') {
                        if (Platform.isAndroid) {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: (() {
                                if (icontype == 'Good') {
                                  return const Text('You Connection is Great');
                                }
                                if (icontype == 'Caution') {
                                  return const Text(
                                      'Data Not Entirely Reliable');
                                } else if (icontype == 'Warning') {
                                  return const Text('Connection Not Avaliable');
                                }
                              })(),
                              content: (() {
                                if (icontype == 'Caution') {
                                  return const Text(
                                      'You do not have a stable internet conection at the moment, so the rates will be of the same from when you last opened the converter. Therefore the rates will not be exact.');
                                } else if (icontype == 'Warning') {
                                  return const Text(
                                      'You do not have a stable internet connection at the moment and can not make conversions');
                                }
                              })(),
                            ),
                            barrierDismissible: true,
                          );
                        } else if (Platform.isIOS) {
                          showCupertinoDialog(
                            context: context,
                            builder: (context) => CupertinoAlertDialog(
                              title: (() {
                                if (icontype == 'Caution') {
                                  return const Text(
                                      'Data Not Entirely Reliable');
                                } else if (icontype == 'Warning') {
                                  return const Text('Connection Not Avaliable');
                                }
                              })(),
                              content: (() {
                                if (icontype == 'Caution') {
                                  return const Text(
                                      'You do not have a stable internet conection at the moment, so the rates will be of the same from when you last opened the converter. Therefore the rates will not be exact.');
                                } else if (icontype == 'Warning') {
                                  return const Text(
                                      'You do not have a stable internet connection at the moment and can not make conversions');
                                }
                              })(),
                            ),
                            barrierDismissible: true,
                          );
                        }
                      }
                    }),
                  ),
                ),
              ),
              Align(
                alignment: const Alignment(0.0, -0.5),
                child: DropdownButton(
                  style: TextStyle(
                    color: (MediaQuery.of(context).platformBrightness ==
                            Brightness.light)
                        ? Colors.black
                        : Colors.white,
                  ),
                  value: unittypevalue,
                  items: unittypes.map((String dropDownStringItem) {
                    return DropdownMenuItem(
                      value: dropDownStringItem,
                      child: Text(dropDownStringItem),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      unittypevalue = newValue.toString();
                      wifiopac = 0;
                      if (unittypevalue == 'Currency') {
                        types = currencytypes;
                        positionnumber = 0.5;
                        wifiopac = 1;
                      } else if (unittypevalue == 'Length') {
                        types = lengthtypes;
                        positionnumber = 0.5;
                      } else if (unittypevalue == 'Temperature') {
                        types = temperaturetypes;
                        positionnumber = 0.5;
                      } else if (unittypevalue == 'Time') {
                        types = timetypes;
                        positionnumber = 0.6;
                      } else if (unittypevalue == 'Volume') {
                        types = volumetypes;
                        positionnumber = 0.7;
                      } else if (unittypevalue == 'Weight') {
                        types = weighttypes;
                        positionnumber = 0.5;
                      }
                      firsttypevalue = types[0];
                      secondtypevalue = types[0];
                    });
                  },
                ),
              ),
              (() {
                if (icontype != 'Warning') {
                  return Stack(children: [
                    Align(
                      alignment: const Alignment(0.0, -0.2),
                      child: FractionallySizedBox(
                          widthFactor: 0.85,
                          heightFactor: 0.2,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            elevation: 20,
                            child: ListView(children: [
                              Center(
                                child: DropdownButton(
                                  value: firsttypevalue,
                                  style: TextStyle(
                                    color: (MediaQuery.of(context)
                                                .platformBrightness ==
                                            Brightness.light)
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                  items: types.map((String dropDownStringItem) {
                                    return DropdownMenuItem(
                                      value: dropDownStringItem,
                                      child: Text(dropDownStringItem),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      firsttypevalue = newValue.toString();
                                    });
                                    update('first');
                                  },
                                ),
                              ),
                              Center(
                                child: DropdownButton(
                                  value: secondtypevalue,
                                  style: TextStyle(
                                    color: (MediaQuery.of(context)
                                                .platformBrightness ==
                                            Brightness.light)
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                  items: types.map((String dropDownStringItem) {
                                    return DropdownMenuItem(
                                      value: dropDownStringItem,
                                      child: Text(dropDownStringItem),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      secondtypevalue = newValue.toString();
                                    });
                                    update('first');
                                  },
                                ),
                              ),
                            ]),
                          )),
                    ),
                    Align(
                      alignment: const Alignment(0.0, 0.7),
                      child: FractionallySizedBox(
                        widthFactor: 0.85,
                        heightFactor: 0.3,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 20,
                          child: ListView(
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.copy,
                                ),
                                onPressed: () async {
                                  await Clipboard.setData(ClipboardData(
                                      text: firstnumbercontroller.text));
                                  Fluttertoast.showToast(
                                      msg: 'Saved to Clipboard');
                                },
                              ),
                              Center(
                                child: FractionallySizedBox(
                                  widthFactor: 0.8,
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    controller: firstnumbercontroller,
                                    style: TextStyle(
                                      color: (MediaQuery.of(context)
                                                  .platformBrightness ==
                                              Brightness.light)
                                          ? Colors.black
                                          : Colors.white,
                                    ),
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                    ),
                                    onChanged: (text) {
                                      update('first');
                                    },
                                  ),
                                ),
                              ),
                              Center(
                                  child: FractionallySizedBox(
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      var save = firsttypevalue;
                                      var savenumber =
                                          firstnumbercontroller.text;
                                      firsttypevalue = secondtypevalue;
                                      firstnumbercontroller.text =
                                          secondnumbercontroller.text;
                                      secondtypevalue = save;
                                      secondnumbercontroller.text = savenumber;
                                    });
                                  },
                                  icon:
                                      const Icon(Icons.compare_arrows_rounded),
                                ),
                              )),
                              Center(
                                child: FractionallySizedBox(
                                  widthFactor: 0.8,
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    controller: secondnumbercontroller,
                                    enabled: false,
                                    style: TextStyle(
                                      color: (MediaQuery.of(context)
                                                  .platformBrightness ==
                                              Brightness.light)
                                          ? Colors.black
                                          : Colors.white,
                                    ),
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                    ),
                                    onChanged: (text) {
                                      update('first');
                                    },
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.copy,
                                ),
                                onPressed: () async {
                                  await Clipboard.setData(ClipboardData(
                                      text: secondnumbercontroller.text));
                                  Fluttertoast.showToast(
                                      msg: 'Saved to Clipboard');
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ]);
                } else {
                  if (unittypevalue != 'Currency') {
                    return Stack(children: [
                      Align(
                        alignment: const Alignment(0, -0.25),
                        child: DropdownButton(
                          value: firsttypevalue,
                          items: types.map((String dropDownStringItem) {
                            return DropdownMenuItem(
                              value: dropDownStringItem,
                              child: Text(dropDownStringItem),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              firsttypevalue = newValue.toString();
                            });
                            update('first');
                          },
                        ),
                      ),
                      Align(
                        alignment: const Alignment(0, -0.075),
                        child: DropdownButton(
                          value: secondtypevalue,
                          items: types.map((String dropDownStringItem) {
                            return DropdownMenuItem(
                              value: dropDownStringItem,
                              child: Text(dropDownStringItem),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              secondtypevalue = newValue.toString();
                            });
                            update('first');
                          },
                        ),
                      ),
                      Align(
                        alignment: const Alignment(0, 0.2),
                        child: FractionallySizedBox(
                          widthFactor: 0.8,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: firstnumbercontroller,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (text) {
                              update('first');
                            },
                          ),
                        ),
                      ),
                      Align(
                        alignment: const Alignment(0, 0.6),
                        child: FractionallySizedBox(
                          widthFactor: 0.8,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: secondnumbercontroller,
                            enabled: false,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (text) {
                              update('first');
                            },
                          ),
                        ),
                      ),
                      Align(
                          alignment: const Alignment(0, 0.4),
                          child: FractionallySizedBox(
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  var save = firsttypevalue;
                                  var savenumber = firstnumbercontroller.text;
                                  firsttypevalue = secondtypevalue;
                                  firstnumbercontroller.text =
                                      secondnumbercontroller.text;
                                  secondtypevalue = save;
                                  secondnumbercontroller.text = savenumber;
                                });
                              },
                              icon: const Icon(Icons.compare_arrows_rounded),
                            ),
                          )),
                    ]);
                  }
                  return Stack();
                }
              })()
            ],
          );
        }
        return Stack(
          children: [
            Align(
              alignment: const Alignment(-0.6, -0.4),
              child: FractionallySizedBox(
                heightFactor: 0.15,
                widthFactor: 0.3,
                child: FittedBox(
                  child: Text(
                    'Unit Type',
                    style: TextStyle(
                      color: (MediaQuery.of(context).platformBrightness ==
                              Brightness.light)
                          ? Colors.black
                          : Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: const Alignment(-0.5, -0.85),
              child: FractionallySizedBox(
                child: Opacity(
                  opacity: double.parse(wifiopac.toString()),
                  child: IconButton(
                    icon: (() {
                      if (icontype == 'Good') {
                        return const Icon(
                          Icons.check,
                          color: Colors.green,
                        );
                      } else if (icontype == 'Caution') {
                        return const Icon(
                          Icons.warning,
                          color: Colors.yellow,
                        );
                      } else if (icontype == 'Warning') {
                        return const Icon(
                          Icons.circle,
                          color: Colors.red,
                        );
                      } else {
                        return const Icon(Icons.question_mark);
                      }
                    })(),
                    onPressed: () {
                      if (Platform.isAndroid) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: (() {
                              if (icontype == 'Caution') {
                                return const Text('Data Not Entirely Reliable');
                              } else if (icontype == 'Warning') {
                                return const Text('Connection Not Avaliable');
                              }
                            })(),
                            content: (() {
                              if (icontype == 'Caution') {
                                return const Text(
                                    'You do not have a stable internet conection at the moment, so the rates will be of the same from when you last opened the converter. Therefore the rates will not be exact.');
                              } else if (icontype == 'Warning') {
                                return const Text(
                                    'You do not have a stable internet connection at the moment and can not make conversions');
                              }
                            })(),
                          ),
                          barrierDismissible: true,
                        );
                      } else if (Platform.isIOS) {
                        showCupertinoDialog(
                          context: context,
                          builder: (context) => CupertinoAlertDialog(
                            title: (() {
                              if (icontype == 'Caution') {
                                return const Text('Data Not Entirely Reliable');
                              } else if (icontype == 'Warning') {
                                return const Text('Connection Not Avaliable');
                              }
                            })(),
                            content: (() {
                              if (icontype == 'Caution') {
                                return const Text(
                                    'You do not have a stable internet conection at the moment, so the rates will be of the same from when you last opened the converter. Therefore the rates will not be exact.');
                              } else if (icontype == 'Warning') {
                                return const Text(
                                    'You do not have a stable internet connection at the moment and can not make conversions');
                              }
                            })(),
                          ),
                          barrierDismissible: true,
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
            Align(
              alignment: const Alignment(-0.65, 0.0),
              child: SizedBox(
                width: width / 3,
                child: DropdownButton(
                  style: TextStyle(
                    color: (MediaQuery.of(context).platformBrightness ==
                            Brightness.light)
                        ? Colors.black
                        : Colors.white,
                  ),
                  value: unittypevalue,
                  items: unittypes.map((String dropDownStringItem) {
                    return DropdownMenuItem(
                      value: dropDownStringItem,
                      child: Text(dropDownStringItem),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      unittypevalue = newValue.toString();
                      wifiopac = 0;
                      if (unittypevalue == 'Length') {
                        types = lengthtypes;
                        positionnumber = 0.5;
                      } else if (unittypevalue == 'Weight') {
                        types = weighttypes;
                        positionnumber = 0.5;
                      } else if (unittypevalue == 'Volume') {
                        types = volumetypes;
                        positionnumber = 0.5;
                      } else if (unittypevalue == 'Time') {
                        types = timetypes;
                        positionnumber = 0.8;
                      } else if (unittypevalue == 'Temperature') {
                        types = temperaturetypes;
                        positionnumber = 0.8;
                      } else if (unittypevalue == 'Currency') {
                        types = currencytypes;
                        positionnumber = 0.8;
                        wifiopac = 1;
                      }
                      firsttypevalue = types[0];
                      secondtypevalue = types[0];
                    });
                  },
                ),
              ),
            ),
            (() {
              if (icontype != 'Warning') {
                return Align(
                  alignment: const Alignment(0.6, -0.2),
                  child: FractionallySizedBox(
                    widthFactor: 0.4,
                    heightFactor: 0.8,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 20,
                      child: ListView(
                        children: [
                          Center(
                            child: FractionallySizedBox(
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    var save = firsttypevalue;
                                    var savenumber = firstnumbercontroller.text;
                                    firsttypevalue = secondtypevalue;
                                    firstnumbercontroller.text =
                                        secondnumbercontroller.text;
                                    secondtypevalue = save;
                                    secondnumbercontroller.text = savenumber;
                                  });
                                },
                                icon: const Icon(Icons.compare_arrows_rounded),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.copy,
                            ),
                            onPressed: () async {
                              await Clipboard.setData(ClipboardData(
                                  text: firstnumbercontroller.text));
                              Fluttertoast.showToast(msg: 'Saved to Clipboard');
                            },
                          ),
                          FractionallySizedBox(
                            widthFactor: 0.8,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: firstnumbercontroller,
                              style: TextStyle(
                                color: (MediaQuery.of(context)
                                            .platformBrightness ==
                                        Brightness.light)
                                    ? Colors.black
                                    : Colors.white,
                              ),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (text) {
                                update('first');
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: DropdownButton(
                              value: firsttypevalue,
                              style: TextStyle(
                                color: (MediaQuery.of(context)
                                            .platformBrightness ==
                                        Brightness.light)
                                    ? Colors.black
                                    : Colors.white,
                              ),
                              items: types.map((String dropDownStringItem) {
                                return DropdownMenuItem(
                                  value: dropDownStringItem,
                                  child: Text(dropDownStringItem),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  firsttypevalue = newValue.toString();
                                });
                                update('first');
                              },
                            ),
                          ),
                          FractionallySizedBox(
                            widthFactor: 0.8,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                color: (MediaQuery.of(context)
                                            .platformBrightness ==
                                        Brightness.light)
                                    ? Colors.black
                                    : Colors.white,
                              ),
                              controller: secondnumbercontroller,
                              enabled: false,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (text) {
                                update('first');
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: DropdownButton(
                              value: secondtypevalue,
                              style: TextStyle(
                                color: (MediaQuery.of(context)
                                            .platformBrightness ==
                                        Brightness.light)
                                    ? Colors.black
                                    : Colors.white,
                              ),
                              items: types.map((String dropDownStringItem) {
                                return DropdownMenuItem(
                                  value: dropDownStringItem,
                                  child: Text(dropDownStringItem),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  secondtypevalue = newValue.toString();
                                });
                                update('first');
                              },
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.copy,
                            ),
                            onPressed: () async {
                              await Clipboard.setData(ClipboardData(
                                  text: secondnumbercontroller.text));
                              Fluttertoast.showToast(msg: 'Saved to Clipboard');
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
              return Stack();
            })()
          ],
        );
      })(),
    );
  }
}
