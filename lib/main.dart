import './screen/characters/characters_detailed_screen.dart';
import './onboarding/onboarding_screen.dart';
import './screen/tab_screen.dart';
import './screen/films/films_detailed_screen.dart';
import 'package:flutter/material.dart';

main() => runApp(StarWarsApp());

class StarWarsApp extends StatefulWidget {
  @override
  _StarWarsAppState createState() => _StarWarsAppState();
}

class _StarWarsAppState extends State<StarWarsApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Star Wars',
      theme: ThemeData(
        primaryColor: Colors.black,
        //primarySwatch: Colors.black,
        accentColor: Colors.white,
        //canvasColor: Color.fromRGBO(51, 51, 255, 1),
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (ctx) => OnboardingScreen(),
        TabsScreen.routeName: (ctx) => TabsScreen(),
        DetailedFilmScreen.routeName: (ctx) => DetailedFilmScreen(),
        CharacterDetailedScreen.routeName: (ctx) => CharacterDetailedScreen(),
      },
    );
  }
}
