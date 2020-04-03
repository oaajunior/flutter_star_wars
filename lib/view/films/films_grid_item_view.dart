import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import '../../models/films/films_model.dart';
import './film_detail_view.dart';

/* 
** auxiliary class to show each film.
*/
class FilmsGridItemView extends StatelessWidget {
  final FilmsModel film;
  FilmsGridItemView(this.film);

//function to call the screen responsible to show detailed information
//about the selected film.
  void _selectedFilm(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      FilmDetailView.routeName,
      arguments: {
        film,
      },
    );
  }

//build function to show each film.
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
                child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: film.imageNetwork,
                  fit: BoxFit.contain,
                ),
              ),
              Container(
                  padding: EdgeInsets.all(5),
                  alignment: Alignment.centerLeft,
                  color: Colors.white,
                  child: Text('Episode ${film.episodeIdRoman}: ${film.title}')),
            ],
          ),
        ),
      ),
    );
  }
}
