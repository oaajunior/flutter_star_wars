import 'package:flutter/material.dart';
import '../../utils/loading_status.dart';
import '../../utils/util.dart';
import '../../models/films/films_model.dart';
import '../../services/starwars_service.dart';

/* 
** class responsible to get films data related with selected character.
*/
class CharactersListFilmsViewModel extends ChangeNotifier {
  StarWarsService service = StarWarsServiceImpl();
  FilmsModel filmResponse = FilmsModel();
  var loadingStatus = LoadingStatus.loading;

//function responsible to get films data related with selected character.
  Future<void> feedDataSource({int filmId}) async {
    try {
      loadingStatus = LoadingStatus.loading;
      final response = filmId == null ? null  : await service.fetchFilmsByID(id: filmId);

      if (response != null) {
        final tempFilm = FilmsModel.fromMappedJson(response);
        tempFilm.imageNetwork =
            Util.networkImageID(type: "films/", id: filmId.toString());
        filmResponse = tempFilm;
        loadingStatus = LoadingStatus.completed;
      } else {
        loadingStatus = LoadingStatus.empty;
      }
    } catch (error) {
      filmResponse = null;
      loadingStatus = LoadingStatus.error;
      print(error);
    }
    notifyListeners();
  }
}
