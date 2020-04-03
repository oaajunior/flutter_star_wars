import 'package:flutter/material.dart';
import './view/onboarding/onboarding_view.dart';
import './view/characters/characters_detail_view.dart';
import './view/main_view.dart';
import 'view/films/film_detail_view.dart';

/* 
** main class of all app.
*/
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
        accentColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (ctx) => OnboardingView(),
        MainView.routeName: (ctx) => MainView(),
        FilmDetailView.routeName: (ctx) => FilmDetailView(),
        CharacterDetailView.routeName: (ctx) => CharacterDetailView(),
      },
    );
  }
}
