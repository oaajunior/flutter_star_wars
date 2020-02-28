import '../../models/films_response.dart';
import '../../services/starwars_service.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class CharacteresListFilms extends StatefulWidget {
  final filmID;
  CharacteresListFilms(this.filmID);
  StarWarsService service = StarWarsServiceImpl();

  @override
  _CharacteresListFilmsState createState() => _CharacteresListFilmsState();
}

class _CharacteresListFilmsState extends State<CharacteresListFilms> {
  FilmsResponse filmResponse = FilmsResponse();

  @override
  initState() {
    _feedDataSource(widget.filmID);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Card(
        elevation: 4,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(2),
              child: Image.asset(
                "assets/images/films/${widget.filmID.toString()}.jpg",
                fit: BoxFit.contain,
              ),
            ),
            Container(
              //padding: EdgeInsets.all(5),
              color: Colors.white,
              child: Text(
                'Episode ${filmResponse.episodeId == null? "" : widget.service.convertToRoman(filmResponse.episodeId)}: ${filmResponse.title == null? "" : filmResponse.title}',
                style: TextStyle(
                  fontSize: 11,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _feedDataSource(int filmId) async {
    await widget.service.fetchFilmsByID(id: filmId).then((response) {
      var json = jsonDecode(response.body);
      if (json != null) {
        setState(() {
          filmResponse = FilmsResponse.fromMappedJson(json);
        });
      }
    });
  }
}
