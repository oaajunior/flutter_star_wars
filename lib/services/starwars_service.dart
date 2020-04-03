import 'package:http/http.dart' as http;
import '../utils/url_helper.dart';

/* 
** class responsible to access the REST API to get all data's app.
*/
abstract class StarWarsService {
  Future<http.Response> fetchAllFilms();
  Future<http.Response> fetchFilmsByID({int id});
  Future<http.Response> fetchFilmsBySearch({String name});
  Future<http.Response> fetchCharactersBySearch({String name});
  Future<http.Response> fetchAllCharacters({String page});
  Future<http.Response> fetchCharacterID({String id});
}

class StarWarsServiceImpl implements StarWarsService {
  @override
  Future<http.Response> fetchAllFilms() {
    return http.get(UrlHelper.formURL("films/"));
  }
  @override
  Future<http.Response> fetchFilmsByID({int id}) {
    return http.get(UrlHelper.formURL("films/${id.toString()}/"));
  }

  @override
  Future<http.Response> fetchAllCharacters({String page}) {
    return http.get(UrlHelper.formURL("people/$page"));
  }

  @override
  Future<http.Response> fetchCharacterID({String id}) {
    return http.get(UrlHelper.formURL("people/$id/"));
  }

  @override
  Future<http.Response> fetchFilmsBySearch({String name}) {
    return http.get(UrlHelper.formURL("films/?search=$name"));
  }

  @override
  Future<http.Response> fetchCharactersBySearch({String name}) {
    return http.get(UrlHelper.formURL("people/?search=$name"));
  }

}
