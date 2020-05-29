import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import '../../utils/util.dart';

/* 
** class responsible to show detailed information about the selected film.
*/
class FilmItemDetailView extends StatelessWidget {
  static const routeName = '/detailed_film_screen';
  final key = Key(routeName);
  final film;

  FilmItemDetailView({this.film});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(film.first.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  width: 200,
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: film.first.imageNetwork,
                    fit: BoxFit.contain,
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    alignment: Alignment.centerLeft,
                    height: 250,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        buildText('Title: ${film.first.title}', 16, true),
                        SizedBox(
                          height: 5,
                        ),
                        buildText(
                            'Episode: ${film.first.episodeIdRoman}', 16, false),
                        SizedBox(
                          height: 5,
                        ),
                        buildText(
                            'Director: ${film.first.director}', 16, false),
                        SizedBox(
                          height: 5,
                        ),
                        buildText(
                            'Release Date: ${Util.treatDate(film.first.releaseDate)}',
                            16,
                            false),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Container(
              //color: Colors.black45,
              alignment: Alignment.topCenter,
              margin: EdgeInsets.all(20),
              width: double.infinity,
              child: Text(
                'Description: ${film.first.openingCrawl}'.replaceAll('\n', ''),
                style: TextStyle(
                  fontSize: 16,
                  height: 1.5,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ),
    );
  }

//auxiliary function to show some information about the film.
  Text buildText(String text, double fontSize, bool bold) {
    return Text(
      '$text',
      style: TextStyle(
          fontSize: fontSize,
          fontWeight: bold ? FontWeight.bold : FontWeight.normal),
    );
  }
}
