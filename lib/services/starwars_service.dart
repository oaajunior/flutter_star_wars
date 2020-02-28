import 'package:http/http.dart' as http;

class BaseService {
  String baseURL = "https://swapi.co/api/";

  String formURL(String endpoint) {
    return "$baseURL$endpoint";
  }
}

abstract class StarWarsService {
  Future<http.Response> fetchAllFilms();
  Future<http.Response> fetchFilmsByID({int id});
  Future<http.Response> fetchAllCharacters(String nextPage);
  Future<http.Response> fetchCharacterID({String id});
  String imageID({String id});
  String convertToRoman(int number);
}

class StarWarsServiceImpl extends BaseService implements StarWarsService {
  @override
  Future<http.Response> fetchAllFilms() {
    return http.get(formURL("films/"));
  }

  @override
  String imageID({String id}) {
    return "$id.jpg";
  }

  @override
  Future<http.Response> fetchFilmsByID({int id}) {
    return http.get(formURL("films/${id.toString()}/"));
  }

  @override
  Future<http.Response> fetchAllCharacters(String nextPage) {
    return http.get(formURL("people/$nextPage"));
  }

  @override
  Future<http.Response> fetchCharacterID({String id}) {
    return http.get(formURL("people/$id/"));
  }

  @override
  String convertToRoman(int number) {
    switch (number) {
      case 1:
        return 'I';
        break;
      case 2:
        return 'II';
        break;
      case 3:
        return 'III';
        break;
      case 4:
        return 'IV';
        break;
      case 5:
        return 'V';
        break;
      case 6:
        return 'VI';
        break;
      case 7:
        return 'VII';
        break;
      default:
        return number.toString();
    }
  }
}
