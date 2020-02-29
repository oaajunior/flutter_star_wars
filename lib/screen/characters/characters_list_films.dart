import '../../models/films_response.dart';
import '../../services/starwars_service.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'dart:convert';

class CharacteresListFilms extends StatefulWidget {
  final filmID;
  CharacteresListFilms(this.filmID);
  final StarWarsService service = StarWarsServiceImpl();

  @override
  _CharacteresListFilmsState createState() => _CharacteresListFilmsState();
}

class _CharacteresListFilmsState extends State<CharacteresListFilms> {
  FilmsResponse filmResponse = FilmsResponse();

  @override
  initState() {
    super.initState();
    _feedDataSource(widget.filmID);
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
              child: filmResponse.imageNetwork == null
                  ? Text("")
                  : FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: filmResponse.imageNetwork,
                      fit: BoxFit.contain,
                    ),
            ),
            Container(
              color: Colors.white,
              child: Text(
                'Episode ${filmResponse.episodeId == null ? "" : widget.service.convertToRoman(filmResponse.episodeId)}: ${filmResponse.title == null ? "" : filmResponse.title}',
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
        var tempFilm = FilmsResponse.fromMappedJson(json);
        tempFilm.imageNetwork = widget.service
            .networkImageID(type: "films/", id: filmId.toString());
        setState(() {
          filmResponse = tempFilm;
        });
      }
    });
  }
}
