import 'dart:convert';
import 'package:app_star_wars/utils/util.dart';
import 'package:flutter/material.dart';
import '../../models/films/films_model.dart';
import '../../services/starwars_service.dart';

class CharactersListFilmsViewModel extends ChangeNotifier {
  final StarWarsService service = StarWarsServiceImpl();
  FilmsModel filmResponse = FilmsModel();

  Future<void> feedDataSource(int filmId) async {
    final response = await service.fetchFilmsByID(id: filmId);
    var json = jsonDecode(response.body);

    if (json != null) {
      final tempFilm = FilmsModel.fromMappedJson(json);
      tempFilm.imageNetwork =
          Util.networkImageID(type: "films/", id: filmId.toString());
      filmResponse = tempFilm;
    }
    notifyListeners();
  }
}
