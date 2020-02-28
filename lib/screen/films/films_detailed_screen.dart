import 'package:flutter/rendering.dart';
import '../../models/films_all_response.dart';
import 'package:flutter/material.dart';

class DetailedFilmScreen extends StatelessWidget {
  static const routeName = '/detailed_film_screen';
  @override
  Widget build(BuildContext context) {
    final Set<FilmsAllResponse> film = ModalRoute.of(context).settings.arguments;

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
                  child: Image.asset('assets/images/films/${film.first.imageID}.jpg',
                      fit: BoxFit.contain,),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    alignment: Alignment.centerLeft,
                    height: 250,
                    //color: Colors.black12,
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
                        buildText('Release Date: ${_treatDate(film.first.releaseDate)}', 16,
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

  Text buildText(String text, double fontSize, bool bold) {
    return Text(
      '$text',
      style: TextStyle(
          fontSize: fontSize,
          fontWeight: bold ? FontWeight.bold : FontWeight.normal),
      // overflow: TextOverflow.fade,
    );
  }

  String _treatDate(String date){

    var arrayDate = date.split('-');
    return arrayDate[1] + '-' +arrayDate[2] + '-' + arrayDate[0];
  }
}
