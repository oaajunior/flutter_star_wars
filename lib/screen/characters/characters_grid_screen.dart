import 'dart:convert';
import 'package:flutter/material.dart';
import '../../models/characters_all_response.dart';
import '../../services/starwars_service.dart';
import 'characters_grid_item.dart';

class CharactersGridScreen extends StatefulWidget {
  final StarWarsService service = StarWarsServiceImpl();
  final TextEditingController filter;

  CharactersGridScreen(this.filter);
  @override
  _CharactersGridScreenState createState() => _CharactersGridScreenState();
}

class _CharactersGridScreenState extends State<CharactersGridScreen> {
  ScrollController _controller = ScrollController();
  var _nextPage = "";
  var _previousPage = "";
  var _isNextPage = true;
  var _isPreviousPage = false;
  List<CharactersAllResponse> _dataSource = [];
  String searchName = "";
  bool searchCharacter = false;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 300,
        childAspectRatio: 1 / 1.6,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: _dataSource.length,
      controller: _controller,
      itemBuilder: (BuildContext context, int index) {
        return CharactersGridItem(_dataSource[index]);
      },
    );
  }

  @override
  initState() {
    super.initState();
    this._feedDataSource();
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        _isNextPage = true;
        _isPreviousPage = false;
        _feedDataSource();
      } else if (_controller.position.pixels ==
          _controller.position.minScrollExtent) {
        _isNextPage = false;
        _isPreviousPage = true;
        _feedDataSource();
      }
    });
    listenSearch();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Future<void> _feedDataSource() async {
    if (_isPreviousPage && _previousPage != null) {
      _nextPage = _previousPage;
    }
    if (searchCharacter) {
      widget.service.fetchCharactersBySearch(name: searchName).then((response) {
        var json = jsonDecode(response.body);

        List<CharactersAllResponse> charactersList = [];
        var list = json["results"];

        if (list != null) {
          for (var character in list) {
            var characterResponse =
                CharactersAllResponse.fromMappedJson(character);

            if (character["url"] != null) {
              List<String> split;
              split = character["url"].toString().split("/");
              split.removeLast();
              characterResponse.id = split.last;
              characterResponse.imageNetwork = widget.service
                  .networkImageID(type: "characters/", id: split.last);
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
          setState(() {
            _dataSource = charactersList;
            _controller.jumpTo(0.5);
          });
        }
      });
    } else if (_isNextPage || _isPreviousPage) {
      widget.service.fetchAllCharacters(_nextPage).then((response) {
        var json = jsonDecode(response.body);

        if (json["next"] != null) {
          var pageAdress = json["next"];
          var split = pageAdress.toString().split("/");
          _nextPage = split.last;
        }

        if (json["previous"] != null) {
          var pageAdress = json["previous"];
          var split = pageAdress.toString().split("/");
          _previousPage = split.last;
        }

        List<CharactersAllResponse> charactersList = [];
        var list = json["results"];

        if (list != null) {
          for (var character in list) {
            var characterResponse =
                CharactersAllResponse.fromMappedJson(character);

            if (character["url"] != null) {
              List<String> split;
              split = character["url"].toString().split("/");
              split.removeLast();
              characterResponse.id = split.last;
              characterResponse.imageNetwork = widget.service
                  .networkImageID(type: "characters/", id: split.last);
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
          setState(() {
            _dataSource = charactersList;
            _controller.jumpTo(0.5);
          });
        }
      });
    }
  }

  void listenSearch() {
    widget.filter.addListener(() {
      if (widget.filter.text.isNotEmpty) {
        searchName = widget.filter.text.toLowerCase();
        searchCharacter = true;
        _isNextPage = false;
        _isPreviousPage = false;

        _feedDataSource();
      } else {
        searchName = "";
        searchCharacter = false;
        _isNextPage = false;
        _isPreviousPage = false;

        _feedDataSource();
      }
    });
  }
}
