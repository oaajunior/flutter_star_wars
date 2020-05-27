import 'package:flutter/material.dart';

import './view/onboarding/onboarding_view.dart';
import './view/main_view.dart';
import './view/films/films_item_detail_view.dart';
import './view/characters/characters_item_detail_view.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  var arguments = settings.arguments;
  var builder;
  switch (settings.name) {
    case OnboardingView.routeName:
      builder = (context) => OnboardingView();
      break;
    case MainView.routeName:
      builder = (context) => MainView();
      break;
    case FilmItemDetailView.routeName:
      builder = (context) => FilmItemDetailView(film: arguments);
      break;
    case CharactersItemDetailView.routeName:
      builder = (context) => CharactersItemDetailView(character: arguments);
      break;
    default:
      builder = (context) => MainView();
  }

  return MaterialPageRoute(builder: builder);
}
