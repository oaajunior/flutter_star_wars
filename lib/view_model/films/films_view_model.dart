import 'package:flutter/material.dart';
import '../../services/starwars_service.dart';
import '../../utils/util.dart';
import '../../models/films/films_model.dart';
import '../../utils/loading_status.dart';

/* 
** class responsible to get data from the model and deal with the view request and search to films.
*/
class FilmsViewModel extends ChangeNotifier {
  List<FilmsModel> dataSource = [];
  StarWarsService service = StarWarsServiceImpl();
  var loadingStatus = LoadingStatus.loading;

//function responsible to fetch data from the REST API and notify the view
//when have been finished.
  Future<void> feedDataSource({String searchName = ""}) async {
    try {
      loadingStatus = LoadingStatus.loading;
      final response = (searchName != null && searchName.isNotEmpty)
          ? await service.fetchFilmsBySearch(name: searchName)
          : await service.fetchAllFilms();

      List<FilmsModel> filmsList = [];
      Iterable list = response["results"];

      if (list != null && list.isNotEmpty) {
        loadingStatus = LoadingStatus.completed;

        for (var film in list) {
          var filmResponse = FilmsModel.fromMappedJsonAll(film);

          filmResponse.episodeIdRoman =
              Util.convertToRoman(filmResponse.episodeId);

          if (film["url"] != null) {
            //method to extract the ID from the url.
            var id = Util.extractID(film["url"]);

            filmResponse.imageNetwork =
                Util.networkImageID(type: "films", id: id);
          }
          filmsList.add(filmResponse);
        }
        orderListFilms(filmsList);
        dataSource = filmsList;
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

  void orderListFilms(List<FilmsModel> list) {
    if (list != null && list.isNotEmpty)
      list.sort((a, b) => a.episodeId.compareTo(b.episodeId));
  }
}
