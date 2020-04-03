import 'package:flutter/material.dart';
import 'dart:convert';
import '../../services/starwars_service.dart';
import '../../models/characters/characters_model.dart';
import '../../utils/loading_status.dart';
import '../../utils/util.dart';

/* 
** class responsible to get data from the model and deal with the view request and search to characters.
*/
class CharactersViewModel extends ChangeNotifier {
  final StarWarsService service = StarWarsServiceImpl();
  var nextPage = "";
  var previousPage = "";
  var isNextPage = true;
  var isPreviousPage = false;
  List<CharactersModel> dataSource = [];
  var loadingStatus = LoadingStatus.searching;

//function responsible to fetch data from the REST API and notify the view 
//when have been finished.
  Future<void> feedDataSource(ScrollController controller,
      {String searchCharacter = ""}) async {
    loadingStatus = LoadingStatus.searching;
    if (isPreviousPage && previousPage != null) {
      nextPage = previousPage;
    }

    final response = (searchCharacter != null && searchCharacter.isNotEmpty)
        ? await service.fetchCharactersBySearch(name: searchCharacter)
        : await service.fetchAllCharacters(page: nextPage);

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);

      if (json["next"] != null && !json["next"].toString().contains("search")) {
        var pageAdress = json["next"];
        var split = pageAdress.toString().split("/");
        nextPage = split.last;
      }

      if (json["previous"] != null &&
          !json["previous"].toString().contains("search")) {
        var pageAdress = json["previous"];
        var split = pageAdress.toString().split("/");
        previousPage = split.last;
      }

      List<CharactersModel> charactersList = [];
      Iterable list = json["results"];

      if (list != null && list.isNotEmpty) {
        loadingStatus = LoadingStatus.completed;
        for (var character in list) {
          var characterResponse = CharactersModel.fromMappedJson(character);

          if (character["url"] != null) {
            List<String> split;
            split = character["url"].toString().split("/");
            split.removeLast();
            characterResponse.id = split.last;
            characterResponse.imageNetwork =
                Util.networkImageID(type: "characters/", id: split.last);
          }

          characterResponse.films = [];
          if (character["films"] != null) {
            for (var film in character["films"]) {
              List<String> split;
              split = film.toString().split("/");
              split.removeLast();

              characterResponse.films.add(int.parse(split.last));
            }
          }
          charactersList.add(characterResponse);
        }
        dataSource = charactersList;
        if (controller.hasClients) controller.jumpTo(0.5);
      } else {
        dataSource = [];
        loadingStatus = LoadingStatus.empty;
      }
    } else {
      dataSource = [];
      loadingStatus = LoadingStatus.error;
    }
    notifyListeners();
  }
}
