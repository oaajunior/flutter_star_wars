import 'package:flutter/material.dart';
import '../../services/starwars_service.dart';
import '../../models/characters/characters_model.dart';
import '../../utils/loading_status.dart';
import '../../utils/util.dart';

/* 
** class responsible to get data from the model and deal with the view request and search to characters.
*/
class CharactersViewModel extends ChangeNotifier {
  StarWarsService service = StarWarsServiceImpl();
  var nextPage = "";
  var previousPage = "";
  var isNextPage = true;
  List<CharactersModel> dataSource = [];
  var loadingStatus = LoadingStatus.loading;

//function responsible to fetch data from the REST API and notify the view
//when it have been finished.
  Future<void> feedDataSource({String searchCharacter = ""}) async {
    try {
      loadingStatus = LoadingStatus.loading;
      if (!isNextPage && previousPage != null) {
        nextPage = previousPage;
      }

      final response = (searchCharacter != null && searchCharacter.isNotEmpty)
          ? await service.fetchCharactersBySearch(name: searchCharacter)
          : await service.fetchAllCharacters(page: nextPage);

      nextPage = checkPreviousOrNextPage(response, "next", nextPage);
      previousPage =
          checkPreviousOrNextPage(response, "previous", previousPage);

      List<CharactersModel> charactersList = [];
      Iterable list = response["results"];

      if (list != null && list.isNotEmpty) {
        for (var character in list) {
          var characterResponse = CharactersModel.fromMappedJson(character);

          if (character["url"] != null) {
            var id = Util.extractID(character["url"]);

            if (id != null) {
              characterResponse.id = id;
              characterResponse.imageNetwork =
                  Util.networkImageID(type: "characters/", id: id);
            }
          }

          characterResponse.films = [];
          if (character["films"] != null) {
            for (var film in character["films"]) {
              var id = Util.extractID(film);

              if (id != null) characterResponse.films.add(int.parse(id));
            }
            characterResponse.films.sort();
          }
          charactersList.add(characterResponse);
        }
        //The next if statement is a workaround because in the last page there are
        //just 2 characters and the scroll in that screen does not work. So, it was added
        //more 2 items to allow the screen scrolling.
        if (charactersList.length <= 2) {
          charactersList.add(CharactersModel());
          charactersList.add(CharactersModel());
        }
        loadingStatus = LoadingStatus.completed;
        dataSource = charactersList;
      } else {
        dataSource = [];
        loadingStatus = LoadingStatus.empty;
      }
    } catch (error) {
      dataSource = [];
      loadingStatus = LoadingStatus.error;
      print(error);
    }
    notifyListeners();
  }

  //Function to check if there are next or previous page in the Characters list.
  String checkPreviousOrNextPage(
      dynamic response, String checkPage, String actualPage) {
    var page = actualPage;

    if (response[checkPage] != null &&
        !response[checkPage].toString().contains("search")) {
      var pageAdress = response[checkPage];
      var split = pageAdress.toString().split("/");
      page = split.last;
    }
    return page;
  }
}
