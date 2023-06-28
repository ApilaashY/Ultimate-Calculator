// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:app/Modules/periodtabledata.dart' as periodictable;

String element = '';

class PeriodicTable extends StatefulWidget {
  const PeriodicTable({super.key});

  @override
  _PeriodicTableState createState() => _PeriodicTableState();
}

class _PeriodicTableState extends State<PeriodicTable> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          tag: "Periodic Table",
          child: Container(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).scaffoldBackgroundColor),
            child: const Text(
              'Periodic Table',
            ),
          ),
        ),
        foregroundColor:
            (MediaQuery.of(context).platformBrightness == Brightness.light)
                ? Colors.black
                : Colors.white,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: InteractiveViewer(
        maxScale: 6,
        clipBehavior: Clip.none,
        child: Center(
          child: FractionallySizedBox(
            widthFactor: 0.95,
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: GridView.count(
                crossAxisCount: 18,
                shrinkWrap: true,
                primary: false,
                children: [
                  PeriodicButton('Hydrogen'),
                  const SizedBox(),
                  const SizedBox(),
                  const SizedBox(),
                  const SizedBox(),
                  const SizedBox(),
                  const SizedBox(),
                  const SizedBox(),
                  const SizedBox(),
                  const SizedBox(),
                  const SizedBox(),
                  const SizedBox(),
                  const SizedBox(),
                  const SizedBox(),
                  const SizedBox(),
                  const SizedBox(),
                  const SizedBox(),
                  PeriodicButton('Helium'),
                  PeriodicButton('Lithium'),
                  PeriodicButton('Beryllium'),
                  const SizedBox(),
                  const SizedBox(),
                  const SizedBox(),
                  const SizedBox(),
                  const SizedBox(),
                  const SizedBox(),
                  const SizedBox(),
                  const SizedBox(),
                  const SizedBox(),
                  const SizedBox(),
                  PeriodicButton('Boron'),
                  PeriodicButton('Carbon'),
                  PeriodicButton('Nitrogen'),
                  PeriodicButton('Oxygen'),
                  PeriodicButton('Fluorine'),
                  PeriodicButton('Neon'),
                  PeriodicButton('Sodium'),
                  PeriodicButton('Magnesium'),
                  const SizedBox(),
                  const SizedBox(),
                  const SizedBox(),
                  const SizedBox(),
                  const SizedBox(),
                  const SizedBox(),
                  const SizedBox(),
                  const SizedBox(),
                  const SizedBox(),
                  const SizedBox(),
                  PeriodicButton('Aluminium'),
                  PeriodicButton('Silicon'),
                  PeriodicButton('Phosphorus'),
                  PeriodicButton('Sulfur'),
                  PeriodicButton('Chlorine'),
                  PeriodicButton('Argon'),
                  PeriodicButton('Potassium'),
                  PeriodicButton('Calcium'),
                  PeriodicButton('Scandium'),
                  PeriodicButton('Titanium'),
                  PeriodicButton('Vanadium'),
                  PeriodicButton('Chromium'),
                  PeriodicButton('Manganese'),
                  PeriodicButton('Iron'),
                  PeriodicButton('Cobalt'),
                  PeriodicButton('Nickel'),
                  PeriodicButton('Copper'),
                  PeriodicButton('Zinc'),
                  PeriodicButton('Gallium'),
                  PeriodicButton('Germanium'),
                  PeriodicButton('Arsenic'),
                  PeriodicButton('Selenium'),
                  PeriodicButton('Bromine'),
                  PeriodicButton('Krypton'),
                  PeriodicButton('Rubidium'),
                  PeriodicButton('Strontium'),
                  PeriodicButton('Yttrium'),
                  PeriodicButton('Zirconium'),
                  PeriodicButton('Niobium'),
                  PeriodicButton('Molybdenum'),
                  PeriodicButton('Technetium'),
                  PeriodicButton('Ruthenium'),
                  PeriodicButton('Rhodium'),
                  PeriodicButton('Palladium'),
                  PeriodicButton('Silver'),
                  PeriodicButton('Cadmium'),
                  PeriodicButton('Indium'),
                  PeriodicButton('Tin'),
                  PeriodicButton('Antimony'),
                  PeriodicButton('Tellurium'),
                  PeriodicButton('Iodine'),
                  PeriodicButton('Xenon'),
                  PeriodicButton('Caesium'),
                  PeriodicButton('Barium'),
                  PeriodicButton('57-71'),
                  PeriodicButton('Hafnium'),
                  PeriodicButton('Tantalum'),
                  PeriodicButton('Tungsten'),
                  PeriodicButton('Rhenium'),
                  PeriodicButton('Osmium'),
                  PeriodicButton('Iridium'),
                  PeriodicButton('Platinum'),
                  PeriodicButton('Gold'),
                  PeriodicButton('Mercury'),
                  PeriodicButton('Thallium'),
                  PeriodicButton('Lead'),
                  PeriodicButton('Bismuth'),
                  PeriodicButton('Polonium'),
                  PeriodicButton('Astatine'),
                  PeriodicButton('Radon'),
                  PeriodicButton('Francium'),
                  PeriodicButton('Radium'),
                  PeriodicButton('89-103'),
                  PeriodicButton('Rutherfordium'),
                  PeriodicButton('Dubnium'),
                  PeriodicButton('Seaborgium'),
                  PeriodicButton('Bohrium'),
                  PeriodicButton('Hassium'),
                  PeriodicButton('Meitnerium'),
                  PeriodicButton('Darmstadtium'),
                  PeriodicButton('Roentgenium'),
                  PeriodicButton('Copernicium'),
                  PeriodicButton('Nihonium'),
                  PeriodicButton('Flerovium'),
                  PeriodicButton('Moscovium'),
                  PeriodicButton('Livermorium'),
                  PeriodicButton('Tennessine'),
                  PeriodicButton('Oganesson'),
                  const SizedBox(),
                  const SizedBox(),
                  const SizedBox(),
                  const SizedBox(),
                  const SizedBox(),
                  const SizedBox(),
                  const SizedBox(),
                  const SizedBox(),
                  const SizedBox(),
                  const SizedBox(),
                  const SizedBox(),
                  const SizedBox(),
                  const SizedBox(),
                  const SizedBox(),
                  const SizedBox(),
                  const SizedBox(),
                  const SizedBox(),
                  const SizedBox(),
                  const SizedBox(),
                  const SizedBox(),
                  const SizedBox(),
                  PeriodicButton('Lanthanum'),
                  PeriodicButton('Cerium'),
                  PeriodicButton('Praseodymium'),
                  PeriodicButton('Neodymium'),
                  PeriodicButton('Promethium'),
                  PeriodicButton('Samarium'),
                  PeriodicButton('Europium'),
                  PeriodicButton('Gadolinium'),
                  PeriodicButton('Terbium'),
                  PeriodicButton('Dysprosium'),
                  PeriodicButton('Holmium'),
                  PeriodicButton('Erbium'),
                  PeriodicButton('Thulium'),
                  PeriodicButton('Ytterbium'),
                  PeriodicButton('Lutetium'),
                  const SizedBox(),
                  const SizedBox(),
                  const SizedBox(),
                  PeriodicButton('Actinium'),
                  PeriodicButton('Thorium'),
                  PeriodicButton('Protactinium'),
                  PeriodicButton('Uranium'),
                  PeriodicButton('Neptunium'),
                  PeriodicButton('Plutonium'),
                  PeriodicButton('Americium'),
                  PeriodicButton('Curium'),
                  PeriodicButton('Berkelium'),
                  PeriodicButton('Californium'),
                  PeriodicButton('Einsteinium'),
                  PeriodicButton('Fermium'),
                  PeriodicButton('Mendelevium'),
                  PeriodicButton('Nobelium'),
                  PeriodicButton('Lawrencium'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PeriodicButton extends StatelessWidget {
  PeriodicButton(img) {
    imagepath = img;
  }

  String imagepath = '';

  @override
  Widget build(BuildContext context) {
    if (imagepath != 'NONE') {
      return Hero(
        tag: imagepath,
        child: Scaffold(
          body: InkWell(
            onTap: () {
              if (!imagepath.contains('1')) {
                element = imagepath;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => const PeriodicDetails())));
              }
            },
            child: Ink.image(
              image: (() {
                try {
                  return AssetImage('assets/PeriodicTable/$imagepath.png');
                } catch (e) {
                  return const AssetImage('assets/PeriodicTable/Unknown.png');
                }
              })(),
            ),
          ),
        ),
      );
    } else {
      return const Visibility(
        visible: false,
        child: Text(''),
      );
    }
  }
}

class PeriodicDetails extends StatefulWidget {
  const PeriodicDetails({super.key});

  @override
  State<PeriodicDetails> createState() => _PeriodicDetailsState();
}

class _PeriodicDetailsState extends State<PeriodicDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(element),
        foregroundColor:
            (MediaQuery.of(context).platformBrightness == Brightness.light)
                ? Colors.black
                : Colors.white,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(15),
        crossAxisCount: 2,
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
        scrollDirection: (() {
          if (MediaQuery.of(context).size.height >
              MediaQuery.of(context).size.width) {
            return Axis.vertical;
          }
          return Axis.horizontal;
        })(),
        children: [
          Hero(
            tag: element,
            child: DetailButton(text: 'Name:\n$element'),
          ),
          DetailButton(
              text:
                  'Atomic\nNumber:\n${periodictable.data[element]['number']}'),
          DetailButton(
              text: 'Symbol:\n' + periodictable.data[element]['symbol']),
          DetailButton(
              text: 'Weight:\n${periodictable.data[element]['weight']}'),
          DetailButton(
              text: 'Catagory:\n' + periodictable.data[element]['group']),
          DetailButton(
              text: 'Period:\n' + periodictable.data[element]['period']),
          DetailButton(
              text:
                  'Melting\nPoint:\n${periodictable.data[element]['Melting Point']}'),
          DetailButton(
              text: 'Boiling\nPoint:\n' +
                  periodictable.data[element]['Boiling Point']),
          DetailButton(text: 'Type:\n' + periodictable.data[element]['type']),
          Image.asset('assets/Elements/$element.png')
        ],
      ),
    );
  }
}

class DetailButton extends StatelessWidget {
  DetailButton({super.key, this.text});
  var text;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 15,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
      color: (MediaQuery.of(context).platformBrightness == Brightness.light)
          ? Colors.white
          : Colors.grey[400],
      child: Center(
          child: FractionallySizedBox(
              widthFactor: 0.8,
              heightFactor: 0.8,
              child: FittedBox(
                  child: Text(
                text,
                textAlign: TextAlign.center,
              )))),
    );
  }
}
