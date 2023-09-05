'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"version.json": "2209f1ad21dfb881ac761e89e07c7469",
"index.html": "4ddc88e4d24f0028dfb3804e131249e2",
"/": "4ddc88e4d24f0028dfb3804e131249e2",
"google2106526be3dd4895.html": "d2c19b7203b2676bbea783e344a7ee84",
"ultimatecalculator.apk": "3ab735c9e2f024e0a46da0a51041c533",
"main.dart.js": "d3e31945212eae960c5b109f954c612d",
"flutter.js": "6fef97aeca90b426343ba6c5c9dc5d4a",
"favicon.png": "61a7b97fd53fb616bb43714f0a79826a",
"icons/Icon-192.png": "33cbf2d8e139b7007a20fa572e8e0aa3",
"icons/Icon-maskable-192.png": "33cbf2d8e139b7007a20fa572e8e0aa3",
"icons/Icon-maskable-512.png": "129cebd8490d8838db86f8847c697080",
"icons/Icon-512.png": "129cebd8490d8838db86f8847c697080",
"manifest.json": "1156625837c52390987645489523e5ae",
"sitemap.xml": "48970fd9681907ebd4fed3cca8490ee6",
"assets/AssetManifest.json": "6a8ecc33024eb3a324972cb500c31b11",
"assets/NOTICES": "59574fe7c2b14f00ef0352b9e90039ca",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "89ed8f4e49bcdfc0b5bfc9b24591e347",
"assets/packages/fluttertoast/assets/toastify.js": "56e2c9cedd97f10e7e5f1cebd85d53e3",
"assets/packages/fluttertoast/assets/toastify.css": "a85675050054f179444bc5ad70ffc635",
"assets/shaders/ink_sparkle.frag": "f8b80e740d33eb157090be4e995febdf",
"assets/AssetManifest.bin": "13eef60e8d90065847872fb3ba4ad8e3",
"assets/fonts/MaterialIcons-Regular.otf": "de3de1686c94f28fe9702dcc421d7a9f",
"assets/assets/PeriodicTable/Krypton.png": "3d7ec1f55e69b6c0144d6058ea248e4c",
"assets/assets/PeriodicTable/Ytterbium.png": "7657d0fca3ab09883aee5b44c9cd212d",
"assets/assets/PeriodicTable/Sodium.png": "20dd33b299ed2ab3865a281bcb92118f",
"assets/assets/PeriodicTable/Seaborgium.png": "e0c0cc78469ab5a1be97027fa3a0e25c",
"assets/assets/PeriodicTable/Titanium.png": "05e51e85a00109b81085d9ad5df14559",
"assets/assets/PeriodicTable/Terbium.png": "202df3596169c83a59d95c903849288f",
"assets/assets/PeriodicTable/Vanadium.png": "242969418c63e3a87ec92b81b1ca57fe",
"assets/assets/PeriodicTable/Promethium.png": "e5bca8361a2c6c949e9ba7463e6ce9cd",
"assets/assets/PeriodicTable/Bohrium.png": "6c032048bdc28102530696e20c45633b",
"assets/assets/PeriodicTable/Tin.png": "6b24157c73fe35192475bd06dbc57a88",
"assets/assets/PeriodicTable/Thorium.png": "1c203ad05c437fcd1079fd31fc96ad0e",
"assets/assets/PeriodicTable/Gadolinium.png": "90b0637d652cf4aea27b36275478317f",
"assets/assets/PeriodicTable/Boron.png": "eacc7c642a503663267cf497d2464c7b",
"assets/assets/PeriodicTable/Phosphorus.png": "57aab4776648a6eb4e9e1c7271eaf33d",
"assets/assets/PeriodicTable/Hydrogen.png": "52a65436981182aa17f6ec1aa6d84f73",
"assets/assets/PeriodicTable/Rhenium.png": "e63d178c36b2d23b16426218e7560d64",
"assets/assets/PeriodicTable/Oganesson.png": "8856a675f79705c5e73a3bf3b7f6cdae",
"assets/assets/PeriodicTable/Meitnerium.png": "9fdff3dceff6344a9924f50719863f66",
"assets/assets/PeriodicTable/Potassium.png": "6fced528097113e3e21fdaf3c403953f",
"assets/assets/PeriodicTable/Neptunium.png": "d83e24ba581eb4048d7fc0acb62a7aa6",
"assets/assets/PeriodicTable/Lawrencium.png": "5115ee70f01ddde2dd7d5b0559af4bb2",
"assets/assets/PeriodicTable/Beryllium.png": "b6552a2806312b4ef4ce69ccd71dfce7",
"assets/assets/PeriodicTable/Rhodium.png": "6923498a366532c31d694191ebf9bede",
"assets/assets/PeriodicTable/Yttrium.png": "006e55ac34aa600954a9c7326b671dff",
"assets/assets/PeriodicTable/Tennessine.png": "d9b9b18d09b8eb449348714f2c74e931",
"assets/assets/PeriodicTable/Carbon.png": "c1f374137afd4384c0c21805e1f92bc3",
"assets/assets/PeriodicTable/Radon.png": "422ac44db692405e1d9d0c89e830618e",
"assets/assets/PeriodicTable/Aluminium.png": "6e6cba1e112e5204af970520650a62e7",
"assets/assets/PeriodicTable/Bismuth.png": "e353f10bdc0180ae237f814dcc408497",
"assets/assets/PeriodicTable/Europium.png": "8b5441992cdb3661ae51c6074386d94b",
"assets/assets/PeriodicTable/Hafnium.png": "19540ad17da217b91ab9afc97614cac5",
"assets/assets/PeriodicTable/Oxygen.png": "168ad24c269dfe77cba6d4b3f68d7adb",
"assets/assets/PeriodicTable/Barium.png": "a86b7926e37a307d5636185d810c7d1c",
"assets/assets/PeriodicTable/Unknown.png": "e8fc4f345f11f09a7d60383983039765",
"assets/assets/PeriodicTable/Arsenic.png": "643df329696871262e4636fba1ada1ef",
"assets/assets/PeriodicTable/Einsteinium.png": "a49a833521fee927464c0058d88860ef",
"assets/assets/PeriodicTable/Nickel.png": "c985070363a4cd0abfdd8b23fac3684b",
"assets/assets/PeriodicTable/Plutonium.png": "8299e29ae2a3752827e5f22506ce2a69",
"assets/assets/PeriodicTable/Holmium.png": "2ec45c0c107731fc048e4606a16ddb5f",
"assets/assets/PeriodicTable/Uranium.png": "2b8490857ec0462c6af761af4942cc06",
"assets/assets/PeriodicTable/Astatine.png": "4be3b75837e8da50b19918e4e4e37d38",
"assets/assets/PeriodicTable/Ruthenium.png": "ac1bd9f3980e53addc61c8793b12f2af",
"assets/assets/PeriodicTable/Argon.png": "be9efc55ba6b980533368aa0412294a3",
"assets/assets/PeriodicTable/Osmium.png": "88214cd8e7f8388209c2a7f2dcd27ea9",
"assets/assets/PeriodicTable/Berkelium.png": "a0fdc10e8317bd6162fcb9b7665d367b",
"assets/assets/PeriodicTable/Francium.png": "968916b65e25540eb6e183e0e1041aa5",
"assets/assets/PeriodicTable/Chlorine.png": "0298c47518835ab92a709446fbf14109",
"assets/assets/PeriodicTable/Rutherfordium.png": "9c57613f639b237d06c44d46251318da",
"assets/assets/PeriodicTable/Polonium.png": "18002a418ef43597ad71df59623d0ebc",
"assets/assets/PeriodicTable/Curium.png": "f52c56703e1c2d25436e09712c5568e4",
"assets/assets/PeriodicTable/Strontium.png": "058949c213de9ecb0668acdf96115dfe",
"assets/assets/PeriodicTable/Livermorium.png": "be2cf55e09c187d6b3020b082f9a6f41",
"assets/assets/PeriodicTable/Dysprosium.png": "e14cb2bbf0cb83d23272c72fc444056f",
"assets/assets/PeriodicTable/Cerium.png": "839490d064b1349c3f438440756ddc2d",
"assets/assets/PeriodicTable/Actinium.png": "907ce51109c048d2d10b2f8765071349",
"assets/assets/PeriodicTable/Lutetium.png": "4b259b732f8773b84352a44d28b2029b",
"assets/assets/PeriodicTable/Nihonium.png": "6a18a02419b75c54279caf08c06b3f26",
"assets/assets/PeriodicTable/Radium.png": "c427b7a5463e42bc5274877f6b9ce290",
"assets/assets/PeriodicTable/Tellurium.png": "a5f72342a4660187712f4162405a3980",
"assets/assets/PeriodicTable/Copper.png": "3fe99dc03c6bcf99b86c4073f0f6556f",
"assets/assets/PeriodicTable/Tungsten.png": "9d58c281ff820ca057f4b3164cb987fb",
"assets/assets/PeriodicTable/Lithium.png": "5adf738327b15cd3935432a7694874d2",
"assets/assets/PeriodicTable/Thallium.png": "d12cdf8814a10ce6857bd5675e5cfecb",
"assets/assets/PeriodicTable/Rubidium.png": "f38eb1978f0d0ff55e250935d029ac38",
"assets/assets/PeriodicTable/Praseodymium.png": "ab88452516dbded8f048b378a61df01a",
"assets/assets/PeriodicTable/Cobalt.png": "66a224a51849c8da7aed2228a1783893",
"assets/assets/PeriodicTable/Technetium.png": "dd1e7caebe45dab3725a53547be16810",
"assets/assets/PeriodicTable/Chromium.png": "1fd93a5a8b20dfda46a8ca906513123c",
"assets/assets/PeriodicTable/Palladium.png": "a63dd6519d507deec2cd081d5c642cdd",
"assets/assets/PeriodicTable/Silver.png": "c5baea06c98887ca8271ec62289328db",
"assets/assets/PeriodicTable/Silicon.png": "df279dce66561335d3e9983d8a7b63b4",
"assets/assets/PeriodicTable/Copernicium.png": "d5dd31b70b8172d59ce30aa0a1667574",
"assets/assets/PeriodicTable/Samarium.png": "2d21ac01daea9fac5071e97b17b3a912",
"assets/assets/PeriodicTable/Gallium.png": "2bbbcf03a0d5462070e0138c376a1f78",
"assets/assets/PeriodicTable/Iridium.png": "d5417f245f90de102169bf464b4ce854",
"assets/assets/PeriodicTable/Sulfur.png": "bc02c199713d0939f0f66c586bb86abc",
"assets/assets/PeriodicTable/Selenium.png": "4cfed922d690112c6f6e54cd344930ea",
"assets/assets/PeriodicTable/Americium.png": "e0acff98d4b57cec7eeee07d549985dd",
"assets/assets/PeriodicTable/Calcium.png": "b51051df437569f05868ee1104a33394",
"assets/assets/PeriodicTable/Lanthanum.png": "2a9f33ee93dc721bbfa91bbae62f734e",
"assets/assets/PeriodicTable/New%2520Project.psd": "d464085c3270aab7be49f03719ee3da0",
"assets/assets/PeriodicTable/Magnesium.png": "c149843cb0e0ddab8656edfd5997dc86",
"assets/assets/PeriodicTable/Californium.png": "a7adc7a0bc1cf753f7643e4205a0e7cb",
"assets/assets/PeriodicTable/Xenon.png": "0e4b0dd2f609c451b5e26360f605029f",
"assets/assets/PeriodicTable/Hassium.png": "765f8e132fca07d5a90214d273ca1489",
"assets/assets/PeriodicTable/Protactinium.png": "e19abefc9efc5d26f6049a53b1947a8d",
"assets/assets/PeriodicTable/Cadmium.png": "72d496803ce80ef36b01ca62b9ebe38d",
"assets/assets/PeriodicTable/Fluorine.png": "50777d85ba1747ce0aae4883caefd7fb",
"assets/assets/PeriodicTable/Darmstadtium.png": "9c6d50bd76ab4bca8042cf78b7ec5d0e",
"assets/assets/PeriodicTable/Nobelium.png": "18b5f978e3d3e4ab2a56374a313bdd40",
"assets/assets/PeriodicTable/Zinc.png": "a23c8177af849498e2bfcd3db3117d3c",
"assets/assets/PeriodicTable/Moscovium.png": "c725de507b264c5c7a008839f3aba43d",
"assets/assets/PeriodicTable/Germanium.png": "e7fd7dc31910013c16d9dd6bfa5adee6",
"assets/assets/PeriodicTable/57-71.png": "02db183c467569ef1c626cd6252c2e21",
"assets/assets/PeriodicTable/Flerovium.png": "7ff6bf45e422f38fe7c38f5ce3ced6ff",
"assets/assets/PeriodicTable/Helium.png": "578f0b2e0ede28be4c0b04d1a9933f8c",
"assets/assets/PeriodicTable/Thulium.png": "5551554d4b993697db787cebd6b91fb4",
"assets/assets/PeriodicTable/Lead.png": "5107691f2e4b24fb0c3fd8c53f401ab3",
"assets/assets/PeriodicTable/Mendelevium.png": "c1d3009fe78633f2a6df372d3437fa38",
"assets/assets/PeriodicTable/Iron.png": "5c2daf50227f7c8ecb8af4013cfdeeb1",
"assets/assets/PeriodicTable/Tantalum.png": "a248648cc6a213f1e770c8b870d0e4a2",
"assets/assets/PeriodicTable/Antimony.png": "59da5b3a2a6e5b741129a1324646bbf9",
"assets/assets/PeriodicTable/Niobium.png": "c67f208e7f4bb54cb64204ba04e6af12",
"assets/assets/PeriodicTable/Roentgenium.png": "d5032b2f2b2d4789d2a07b557fbcc500",
"assets/assets/PeriodicTable/Scandium.png": "382b8fc15009a501ba3adfc18f5f662a",
"assets/assets/PeriodicTable/Mercury.png": "5b23dbc99e3a2dc53814a12c8119caba",
"assets/assets/PeriodicTable/Fermium.png": "82a64131e5a50500a52f30f2592f0659",
"assets/assets/PeriodicTable/Indium.png": "86b55cf18a7130e68291f81784cb12b3",
"assets/assets/PeriodicTable/Caesium.png": "97bfc38f670665c01f43e5a3c604d125",
"assets/assets/PeriodicTable/Bromine.png": "190d67b174c455f407dda743cbff5f0b",
"assets/assets/PeriodicTable/Nitrogen.png": "ce401ba9ed2a8ded5a2cfc7147abc86a",
"assets/assets/PeriodicTable/Erbium.png": "b97856ab7a7f7b5572fabc79c7d29959",
"assets/assets/PeriodicTable/89-103.png": "270b75a8dff2c983aa43cd3fbb41811d",
"assets/assets/PeriodicTable/Iodine.png": "ec9378946b2ea4abf693bd404b36ee37",
"assets/assets/PeriodicTable/Neon.png": "577598ad5af19202165de327725940c3",
"assets/assets/PeriodicTable/Zirconium.png": "bd78242bd13ae083292dd8963ce3b514",
"assets/assets/PeriodicTable/Molybdenum.png": "2bb1fe13b679709582382fe660544881",
"assets/assets/PeriodicTable/Manganese.png": "5e71415adb183f62cd2dcb22ee2cfa77",
"assets/assets/PeriodicTable/Dubnium.png": "80d350696d64c3477d27546c378ffbc5",
"assets/assets/PeriodicTable/Gold.png": "b715e62549e6acce2b1b88cf17952552",
"assets/assets/PeriodicTable/Neodymium.png": "93b4f9201cf5ce6751401a7bd8422cd9",
"assets/assets/PeriodicTable/Platinum.png": "ebdded1c7f801adf35cb1360e438de07",
"assets/assets/Calculator/Exponent.png": "3615e9e919374501b6a7e67be02af749",
"assets/assets/CalculatorIcon.png": "e4ed081da8887f6bcb52c557f54868c4",
"assets/assets/Elements/Krypton.png": "8c8e5df27d2888a6d45c90bed7a8d5c3",
"assets/assets/Elements/Ytterbium.png": "e2b0301dca61a198b2150dca08af80f9",
"assets/assets/Elements/Sodium.png": "e02bd2f15a532292c56dac2a26844c2f",
"assets/assets/Elements/Seaborgium.png": "5e0a19ecfedbfb7bcee72a53870ce4a0",
"assets/assets/Elements/Titanium.png": "f53b89f0913476dd06c7643f6fc36f57",
"assets/assets/Elements/Terbium.png": "a2167b983192faee734bc52ba45b85c0",
"assets/assets/Elements/Vanadium.png": "fe8fe41a126771d52268691700bcb92a",
"assets/assets/Elements/Promethium.png": "6ad8934f15777e6d4e1ff90adb46c702",
"assets/assets/Elements/Bohrium.png": "6b7c9aca695c533290b6dfb476c4a8db",
"assets/assets/Elements/Tin.png": "c9b2b44ef4ea947df01d90539384adbc",
"assets/assets/Elements/Thorium.png": "697f89a335d343f302de9a5187015b07",
"assets/assets/Elements/Gadolinium.png": "578f39ea5397a9c809ba118d06fa97a2",
"assets/assets/Elements/Boron.png": "92466c1800648ecee245e2680f9d4390",
"assets/assets/Elements/Phosphorus.png": "24e58594d585f14f5acc6f9f4a978e2d",
"assets/assets/Elements/Hydrogen.png": "45be809d31ec7daaf3033e1cdef1b886",
"assets/assets/Elements/Rhenium.png": "ef3a5fffdaca50a202ad1335e2c68bbf",
"assets/assets/Elements/Oganesson.png": "3f921000b9d4b95edeabbf0c3509b3b9",
"assets/assets/Elements/Meitnerium.png": "10970af361ab76e0bf2894f04f81546d",
"assets/assets/Elements/Potassium.png": "e98732feadb81799662c25877e4b1977",
"assets/assets/Elements/Neptunium.png": "5722610e2a46d388a9ede5f55640a31f",
"assets/assets/Elements/Lawrencium.png": "215825ba3577b796f9cf3cfdf48db561",
"assets/assets/Elements/Beryllium.png": "fcc82bbef71fb571214d91822095e11a",
"assets/assets/Elements/Rhodium.png": "d6f982b2394e1527754de422cd84593f",
"assets/assets/Elements/Yttrium.png": "b0bab8060fd6830dfda455546d4909d5",
"assets/assets/Elements/Tennessine.png": "a2c6abffa595bc0b6db1ea23aae3ad5d",
"assets/assets/Elements/Carbon.png": "1e7a3401f77117ce1080fc1eda5f7fe2",
"assets/assets/Elements/Radon.png": "cf9703dd1cf7e6502759926f4e61602e",
"assets/assets/Elements/Aluminium.png": "8b488d7fc85a72668c101132f49d932c",
"assets/assets/Elements/Bismuth.png": "b7a1169e520f38d652c57b429484d7d1",
"assets/assets/Elements/Europium.png": "0cceb1b71a85ca10f2d9c02d98fafc26",
"assets/assets/Elements/Hafnium.png": "cc1d700bf38acb7a7d1b9ee021687864",
"assets/assets/Elements/Oxygen.png": "9bdc9e062dc855edeedffdd4a8fc6796",
"assets/assets/Elements/Barium.png": "23908c05e43a4c9e30bce130e4f381df",
"assets/assets/Elements/Arsenic.png": "0dbc5a573704b718eb716689c55c3a92",
"assets/assets/Elements/Einsteinium.png": "59ad4decdb7f4a0a4efda32b4329aa89",
"assets/assets/Elements/Nickel.png": "236ec12070669794d84dfdff0c994be1",
"assets/assets/Elements/Plutonium.png": "13d63cd2fa7157ee3003397c4871799c",
"assets/assets/Elements/Holmium.png": "9dc4ac75bc960cd4b82ae3d1637a01eb",
"assets/assets/Elements/Uranium.png": "20bc1fd64f9c69384344278b10c6e743",
"assets/assets/Elements/Astatine.png": "f6c68ef2cf46f898d55d0806c482774f",
"assets/assets/Elements/Ruthenium.png": "f77d0e3c8d9aa86d972ed28e72774b45",
"assets/assets/Elements/Argon.png": "afd81a1bf6d259eb4721b6227ec73251",
"assets/assets/Elements/Osmium.png": "2fab19fd7e4415a33a93fdaae3bf33e8",
"assets/assets/Elements/Berkelium.png": "cb03bbe59b3b71878a0137d6e32feef7",
"assets/assets/Elements/Francium.png": "81e68f4267efe7d90bb42b8656c6008d",
"assets/assets/Elements/Chlorine.png": "3b4b48e9d8186f833367e9034268b79d",
"assets/assets/Elements/Rutherfordium.png": "e7f76832fd8896b9f150e30a91890470",
"assets/assets/Elements/Polonium.png": "67a16421d479bcf8e7183d2aa5f4f2bc",
"assets/assets/Elements/Curium.png": "bf124a689e5bc63ac295a0402420e81b",
"assets/assets/Elements/Strontium.png": "24cf7447ae85d955a969fad977539837",
"assets/assets/Elements/Livermorium.png": "065bb88cb87871e583af0853966fdf98",
"assets/assets/Elements/Dysprosium.png": "02a8d62b9e89f95de21b6d82ba1322b8",
"assets/assets/Elements/Cerium.png": "c2f4d08caf76e17ac885ef906a9418a1",
"assets/assets/Elements/Actinium.png": "7bfd21db711a8207698c8fe372da50f4",
"assets/assets/Elements/Lutetium.png": "d6afc082a14649c308c397e4998b7f87",
"assets/assets/Elements/Nihonium.png": "63a004cc6ed7cc0b936f3f7c5df27f71",
"assets/assets/Elements/Radium.png": "92b6bc8cb3e9de37e4f3fa0a1f1d918a",
"assets/assets/Elements/Tellurium.png": "9fadc27eb860d6416386fb36010d9700",
"assets/assets/Elements/Copper.png": "bc56fc41235608cb5bd13b52850d6252",
"assets/assets/Elements/Tungsten.png": "40d10678d4d66c6a8a89ee499fd298b4",
"assets/assets/Elements/Lithium.png": "a9b5b67392547736076badacb43e69c5",
"assets/assets/Elements/Thallium.png": "1d574885406f453481606f63f88e2180",
"assets/assets/Elements/Rubidium.png": "08f5f7ff31c0a0d4f1fa07d7234e5afe",
"assets/assets/Elements/Praseodymium.png": "883f9d63088e08e949dd48bdf928af62",
"assets/assets/Elements/Cobalt.png": "d841af837ac1fde45a0d0a811f92a68c",
"assets/assets/Elements/Technetium.png": "593f5901adf46546ee49b69924f86b59",
"assets/assets/Elements/Chromium.png": "76ca1a1cd500d2dc00a914e04d6910ca",
"assets/assets/Elements/Palladium.png": "729b17e0cfab0fbd4a50e75e5fde5222",
"assets/assets/Elements/Silver.png": "988a9a57bc89e4e39aa06cc7df5d83f1",
"assets/assets/Elements/Silicon.png": "448d36a135298779526930b85df33aaf",
"assets/assets/Elements/Copernicium.png": "e6370bd5356fcfcf21be3a884ef8e428",
"assets/assets/Elements/Samarium.png": "abda59159559b72e23e7af3fbab70b66",
"assets/assets/Elements/Gallium.png": "62f95c12263ca991d223fa797fa3ea23",
"assets/assets/Elements/Iridium.png": "39f6c2a55a442d80c3d2423e03930ee3",
"assets/assets/Elements/Sulfur.png": "f3cee2c3cf584e382bdb241396184a9b",
"assets/assets/Elements/Selenium.png": "dfe6e5556490b664ba4b1d92c0e9d17f",
"assets/assets/Elements/Americium.png": "66a98dafdc9c94dd907d35a79d0c6b51",
"assets/assets/Elements/Calcium.png": "af6700e4549d21ddab053b988fb37640",
"assets/assets/Elements/Lanthanum.png": "10652418416fc283439aca203fb846f5",
"assets/assets/Elements/Magnesium.png": "d514f02d65ac2897d72de1e5939ff24d",
"assets/assets/Elements/Californium.png": "bec2a87a2a8cf2150d3c4f126e558e4a",
"assets/assets/Elements/Xenon.png": "c4b9c8d9382d137444cffd46d4ef1381",
"assets/assets/Elements/Hassium.png": "26030b73dc0051901709f54d31628eea",
"assets/assets/Elements/Protactinium.png": "00f28d7cc159456264e240e69f15d451",
"assets/assets/Elements/Cadmium.png": "7cc5d22c690293253a62846baaebecc8",
"assets/assets/Elements/Fluorine.png": "7d248ad2080a1164aa82b419e8e97334",
"assets/assets/Elements/Darmstadtium.png": "4c3f5081ef01737eb769266889ade637",
"assets/assets/Elements/Nobelium.png": "1daef43398a3150440fdd051238dc9c9",
"assets/assets/Elements/Zinc.png": "52e62109c3ced169f24030b08c86bbab",
"assets/assets/Elements/Moscovium.png": "59d30f024c95e550d5295d6ffadfd421",
"assets/assets/Elements/Germanium.png": "b123e1b2c51e367e4c7fd2b15b5fee5c",
"assets/assets/Elements/Flerovium.png": "450bbfae8f479e7bb6521da40ddfe5d5",
"assets/assets/Elements/Helium.png": "ff41b617597f167e1676bdcafcda6b9f",
"assets/assets/Elements/Thulium.png": "e1e8f212e7d8a11eaae1faa86369e882",
"assets/assets/Elements/Lead.png": "e5729ea1482350af5f33c76f452cfe16",
"assets/assets/Elements/Mendelevium.png": "bae34f49801446e18afe8678332259f3",
"assets/assets/Elements/Iron.png": "8b8b61073bbf1dc56a2f6328a7f39dc4",
"assets/assets/Elements/Tantalum.png": "0699bbd07a191b726eda53a29b3c6cb7",
"assets/assets/Elements/Antimony.png": "a779d9af2a0e171a6e889b10f1535837",
"assets/assets/Elements/Niobium.png": "8fe02d1c8e46bd14db6555b53f206b89",
"assets/assets/Elements/Roentgenium.png": "2d20c1c052924e3e674cdb8f32c26583",
"assets/assets/Elements/Scandium.png": "8a8c6fa5efae5c37060e49ff85800bcb",
"assets/assets/Elements/Mercury.png": "a60b0bda2b488d980520446c82521515",
"assets/assets/Elements/Fermium.png": "3d3e47b3fbcb61ceda1e93ba0464abc1",
"assets/assets/Elements/Indium.png": "8f9a6f00c219835091d3cbded7cf33bb",
"assets/assets/Elements/Caesium.png": "2d5125a644658bcd6478b7be8edaefdf",
"assets/assets/Elements/Bromine.png": "d102aba13131f27ce09ec1d10ea336e7",
"assets/assets/Elements/Nitrogen.png": "738f09e53ab229a1fd5ab5f7d0ad4332",
"assets/assets/Elements/Erbium.png": "e523e63effff66e621b0135998f07f2d",
"assets/assets/Elements/Iodine.png": "4a2aa2f851f73456c83995270a19a16f",
"assets/assets/Elements/Neon.png": "c62a05433303f8035ade431fcccaa170",
"assets/assets/Elements/Zirconium.png": "32cdcbb1266a7cadc2efa8520b600356",
"assets/assets/Elements/Molybdenum.png": "fc10edb48290671c35fd6213567c91ec",
"assets/assets/Elements/Manganese.png": "2f0ffdbd64baa2e3b2490d6a3aa6b9b4",
"assets/assets/Elements/Dubnium.png": "11771fdd5d2a6473302aed9d5daac716",
"assets/assets/Elements/Gold.png": "69afcb110c342dd9a380eb34ecc25d6f",
"assets/assets/Elements/Neodymium.png": "8e6807c034061c43f0f98311017f2c70",
"assets/assets/Elements/Platinum.png": "8e1313a1edbc260734e60f00110b8e28",
"assets/assets/Calculator.png": "f614bb5eb8bf0b173369a7c4fdc6453c",
"assets/assets/foreground.png": "ad41177c04eccc1618a19e96e94536c4",
"canvaskit/skwasm.js": "95f16c6690f955a45b2317496983dbe9",
"canvaskit/skwasm.wasm": "d1fde2560be92c0b07ad9cf9acb10d05",
"canvaskit/chromium/canvaskit.js": "ffb2bb6484d5689d91f393b60664d530",
"canvaskit/chromium/canvaskit.wasm": "393ec8fb05d94036734f8104fa550a67",
"canvaskit/canvaskit.js": "5caccb235fad20e9b72ea6da5a0094e6",
"canvaskit/canvaskit.wasm": "d9f69e0f428f695dc3d66b3a83a4aa8e",
"canvaskit/skwasm.worker.js": "51253d3321b11ddb8d73fa8aa87d3b15"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
