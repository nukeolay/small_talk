import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';
import './screens/on_boarding_screen.dart';
import './screens/persons_screen.dart';
import './screens/accepted_screen.dart';
import './screens/get_contact_screen.dart';
import './screens/introduce_screen.dart';
import './models/person.dart';
import './CONSTS.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) => runApp(
      EasyLocalization(
        supportedLocales: [Locale('en'), Locale('ru')],
        path: 'assets/translations',
        fallbackLocale: Locale('en'),
        child: MyApp(prefs),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  final SharedPreferences prefs;
  MyApp(this.prefs);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late List<Person> _persons;
  late List<String> _introduceTexts;
  late List<String> _offerTexts;
  bool isFirstTimeLoaded = false;

  @override
  void initState() {
    _persons = loadPersons(widget.prefs);
    _introduceTexts = loadIntroduceTexts(widget.prefs);
    _offerTexts = loadOfferTexts(widget.prefs);
    super.initState();
  }

  void setIsFirstTime(bool value) async {
    this.isFirstTimeLoaded = value;
    await setIntroduceTexts(_introduceTexts);
    await setOfferTexts(_offerTexts);
  }

  Future<void> setPersons({
    required List<Person> persons,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('persons', jsonEncode(persons));
  }

  Future<void> setIntroduceTexts(List<String> newIntroduceTexts) async {
    setState(() {
      this._introduceTexts = newIntroduceTexts;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('introduceTexts', newIntroduceTexts);
  }

  Future<void> setOfferTexts(List<String> newOfferTexts) async {
    setState(() {
      this._offerTexts = newOfferTexts;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('offerTexts', newOfferTexts);
  }

  List<Person> loadPersons(SharedPreferences prefs) {
    try {
      List<Person> result = [
        for (var json in jsonDecode(prefs.getString('persons')!))
          Person.fromJson(json),
      ];
      return result;
    } catch (e) {
      return <Person>[];
    }
  }

  List<String> loadIntroduceTexts(SharedPreferences prefs) {
    try {
      return prefs.getStringList('introduceTexts')!;
    } catch (e) {
      isFirstTimeLoaded = true;
      return [];
    }
  }

  List<String> loadOfferTexts(SharedPreferences prefs) {
    try {
      return prefs.getStringList('offerTexts')!;
    } catch (e) {
      return [];
    }
  }

  Future<void> addPerson(Person newPerson) async {
    int personIndex =
        _persons.indexWhere((person) => person.id == newPerson.id);
    if (personIndex == -1) {
      //to create new person (add person without name)
      _persons.insert(0, newPerson);
    } else {
      //to replace old person with new (update person with name)
      _persons[personIndex] = newPerson;
    }
    await setPersons(persons: _persons);
  }

  @override
  Widget build(BuildContext context) {
    if (isFirstTimeLoaded) {
      if (context.locale.languageCode.contains('ru')) {
        _introduceTexts = INTRODUCE_TEXTS_RU;
        _offerTexts = OFFER_TEXTS_RU;
      } else {
        _introduceTexts = INTRODUCE_TEXTS_EN;
        _offerTexts = OFFER_TEXTS_EN;
      }
    }

    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'Small Talk',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.dark(secondary: Colors.blue.shade50),
        primaryColor: Colors.blue,
        hintColor: Colors.white,
        scaffoldBackgroundColor: Colors.black,
        cardColor: Colors.grey.withAlpha(50),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.blue,
          selectionHandleColor: Colors.blue,
        ),
      ),
      routes: {
        '/': (BuildContext ctx) => isFirstTimeLoaded
            ? OnBoardingScreen(setIsFirstTime)
            : IntroduceScreen(
                _introduceTexts,
                _offerTexts,
                setIntroduceTexts,
                setOfferTexts,
              ),
        '/get-contact-screen': (BuildContext ctx) =>
            GetContactScreen(addPerson),
        '/accepted-screen': (BuildContext ctx) => AcceptedScreen(),
        '/persons-screen': (BuildContext ctx) => PersonsScreen(_persons),
        '/on-boarding-screen': (BuildContext ctx) =>
            OnBoardingScreen(setIsFirstTime),
      },
      onUnknownRoute: (settings) => MaterialPageRoute<dynamic>(
          builder: (BuildContext ctx) => IntroduceScreen(
                _introduceTexts,
                _offerTexts,
                setIntroduceTexts,
                setOfferTexts,
              )),
    );
  }
}
