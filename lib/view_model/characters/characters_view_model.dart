import 'package:flutter/material.dart';
import 'dart:convert';
import '../../services/starwars_service.dart';
import '../../models/characters/characters_model.dart';
import '../../utils/util.dart';

class CharactersViewModel extends ChangeNotifier {
  final StarWarsService service = StarWarsServiceImpl();
  var nextPage = "";
  var previousPage = "";
  var isNextPage = true;
  var isPreviousPage = false;
  List<CharactersModel> dataSource = [];

  Future<void> feedDataSource(ScrollController controller, {String searchCharacter = ""}) async {
    
    if (isPreviousPage && previousPage != null) {
      nextPage = previousPage;
    }

    final response = (searchCharacter != null && searchCharacter.isNotEmpty)  
        ? await service.fetchCharactersBySearch(name: searchCharacter)
        : await service.fetchAllCharacters(page: nextPage);
    var json = jsonDecode(response.body);

    if (json["next"] != null) {
      var pageAdress = json["next"];
      var split = pageAdress.toString().split("/");
      nextPage = split.last;
    }

    if (json["previous"] != null) {
      var pageAdress = json["previous"];
      var split = pageAdress.toString().split("/");
      previousPage = split.last;
    }

    List<CharactersModel> charactersList = [];
    var list = json["results"];

    if (list != null) {
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
      controller.jumpTo(0.5);
      notifyListeners();
    }
  }
}
