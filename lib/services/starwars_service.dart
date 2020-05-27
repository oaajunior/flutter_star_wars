import 'dart:convert';

import 'package:http/http.dart' as http;
import '../utils/url_helper.dart';

/* 
** class responsible to access the REST API to get all data's app.
*/
abstract class StarWarsService {
  Future<dynamic> fetchAllFilms();
  Future<dynamic> fetchFilmsByID({int id});
  Future<dynamic> fetchFilmsBySearch({String name});
  Future<dynamic> fetchCharactersBySearch({String name});
  Future<dynamic> fetchAllCharacters({String page});
}

class StarWarsServiceImpl implements StarWarsService {
  @override
  Future<dynamic> fetchAllFilms() async {
    var json;
    final response = await http.get(UrlHelper.fromURL("films/"));
    if (response != null && response.statusCode == 200) {
      json = jsonDecode(response.body);
    } else {
      throw Exception('There was an error in the server response.');
    }

    return json;
  }

  @override
  Future<dynamic> fetchFilmsByID({int id}) async {
    var json;
    final response =
        await http.get(UrlHelper.fromURL("films/${id.toString()}/"));
    if (response != null && response.statusCode == 200) {
      json = jsonDecode(response.body);
    } else {
      throw Exception('There was an error in the server response.');
    }
    return json;
  }

  @override
  Future<dynamic> fetchAllCharacters({String page}) async {
    var json;
    final response = await http.get(UrlHelper.fromURL("people/$page"));
    if (response != null && response.statusCode == 200) {
      json = jsonDecode(response.body);
    } else {
      throw Exception('There was an error in the server response.');
    }
    return json;
  }

  @override
  Future<dynamic> fetchFilmsBySearch({String name}) async {
    var json;
    final response = await http.get(UrlHelper.fromURL("films/?search=$name"));
    if (response != null && response.statusCode == 200) {
      json = jsonDecode(response.body);
    } else {
      throw Exception('There was an error in the server response.');
    }
    return json;
  }

  @override
  Future<dynamic> fetchCharactersBySearch({String name}) async {
    var json;
    final response = await http.get(UrlHelper.fromURL("people/?search=$name"));
    if (response != null && response.statusCode == 200) {
      json = jsonDecode(response.body);
    } else {
      throw Exception('There was an error in the server response.');
    }
    return json;
  }
}
