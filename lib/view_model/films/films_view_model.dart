import 'dart:convert';
import 'package:flutter/material.dart';
import '../../services/starwars_service.dart';
import '../../utils/util.dart';
import '../../models/films/films_model.dart';
import '../../utils/loading_status.dart';

class FilmsViewModel extends ChangeNotifier {
  List<FilmsModel> dataSource = [];
  String searchName = "";
  bool searchFilm = false;
  final StarWarsService service = StarWarsServiceImpl();
  var loadingStatus = LoadingStatus.searching;

  Future<void> feedDataSource({String searchName = ""}) async {
    final response = (searchName != null && searchName.isNotEmpty)
        ? await service.fetchFilmsBySearch(name: searchName)
        : await service.fetchAllFilms();
    var json = jsonDecode(response.body);
    List<FilmsModel> filmsList = [];
    Iterable list = json["results"];

    if (list != null && list.isNotEmpty) {
      loadingStatus = LoadingStatus.completed;

      for (var film in list) {
        var filmResponse = FilmsModel.fromMappedJsonAll(film);

        filmResponse.episodeIdRoman =
            Util.convertToRoman(filmResponse.episodeId);

        if (film["url"] != null) {
          List<String> split;
          split = film["url"].toString().split("/");
          split.removeLast();
          filmResponse.id = split.last;
          filmResponse.imageNetwork =
              Util.networkImageID(type: "films/", id: split.last);
        }
        filmsList.add(filmResponse);
      }
      filmsList.sort((a, b) => a.episodeId.compareTo(b.episodeId));
      dataSource = filmsList;
    } else {
      dataSource = [];
      loadingStatus = LoadingStatus.empty;
    }

    notifyListeners();
  }
}
