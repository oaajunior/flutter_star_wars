import '../../models/films_all_response.dart';
import 'package:flutter/material.dart';
import '../../screen/films/films_detailed_screen.dart';

class FilmsGridItem extends StatelessWidget {
  final FilmsAllResponse film;

  FilmsGridItem(this.film);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selectedFilm(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: EdgeInsets.all(5),
        child: Card(
          elevation: 4,
          margin: EdgeInsets.all(5),
          child: Column(
            children: <Widget>[
              Container(
                width: 200,
                padding: EdgeInsets.all(5),
                child: Image.asset(
                  "assets/images/films/${film.imageID}.jpg",
                  fit: BoxFit.contain,
                ),
              ),
              Container(
                  padding: EdgeInsets.all(5),
                  alignment: Alignment.centerLeft,
                  color: Colors.white,
                  child: Text(
                      'Episode ${film.episodeIdRoman}: ${film.title}')),
            ],
          ),
        ),
      ),
    );
  }

  

  void _selectedFilm(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      DetailedFilmScreen.routeName,
      arguments: {film,
      },
    );
  }
}
