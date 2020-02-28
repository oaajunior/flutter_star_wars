import 'dart:convert';
import 'package:flutter/material.dart';
import '../../models/characters_all_response.dart';
import '../../services/starwars_service.dart';
import 'characters_grid_item.dart';

class CharactersGridScreen extends StatefulWidget {
  StarWarsService service = StarWarsServiceImpl();

  @override
  _CharactersGridScreenState createState() => _CharactersGridScreenState();
}

class _CharactersGridScreenState extends State<CharactersGridScreen> {
  ScrollController _controller = ScrollController();
  var _nextPage = "";
  var _previousPage = "";
  var _isLoading = false;
  List<CharactersAllResponse> _dataSource = [];

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Opacity(
            opacity: _isLoading ? 1.0 : 00,
            child: CircularProgressIndicator(
              backgroundColor: Colors.red,
            ),
          ),
        ),
      );
    } else {
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
  }

  @override
  initState() {
    this._feedDataSource(true);
    super.initState();
    _isLoading = true;
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        _feedDataSource(true);
      } else if (_controller.position.pixels ==
          _controller.position.minScrollExtent) {
        _feedDataSource(false);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _feedDataSource(bool isNextPage) async {
    setState(() {
      _isLoading = true;
    });

    if(!isNextPage && _previousPage != null) {

      _nextPage = _previousPage;
    }

    await getResourcesData();

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> getResourcesData() async {
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
          var characterResponse = CharactersAllResponse.fromMappedJson(character);

          if (character["url"] != null) {
            List<String> split;
            split = character["url"].toString().split("/");
            split.removeLast();
            characterResponse.id = split.last;
            characterResponse.imageID = split.last;
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
