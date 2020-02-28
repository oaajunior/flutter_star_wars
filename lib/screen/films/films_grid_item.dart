import '../../models/films_all_response.dart';
import 'package:flutter/material.dart';
import '../../screen/films/films_detailed_screen.dart';
import 'package:transparent_image/transparent_image.dart';

class FilmsGridItem extends StatefulWidget {
  final FilmsAllResponse film;

  FilmsGridItem(this.film);

  @override
  _FilmsGridItemState createState() => _FilmsGridItemState();
}

class _FilmsGridItemState extends State<FilmsGridItem> {
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
                  image: widget.film.imageNetwork,
                  fit: BoxFit.contain,
                ),
              ),
              Container(
                  padding: EdgeInsets.all(5),
                  alignment: Alignment.centerLeft,
                  color: Colors.white,
                  child: Text('Episode ${widget.film.episodeIdRoman}: ${widget.film.title}')),
            ],
          ),
        ),
      ),
    );
  }

  void _selectedFilm(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      DetailedFilmScreen.routeName,
      arguments: {
        widget.film,
      },
    );
  }
}
