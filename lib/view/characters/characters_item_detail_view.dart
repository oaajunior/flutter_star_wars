import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import '../../view_model/characters/characters_list_films_view_model.dart';
import './characters_list_films_view.dart';

/* 
** class responsible to show detailed information about the selected character.
*/
class CharactersItemDetailView extends StatelessWidget {
  final character;
  CharactersItemDetailView({this.character});
  static const routeName = '/characters_detailed_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(character.first.name),
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
                    image: character.first.imageNetwork,
                    fit: BoxFit.contain,
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    alignment: Alignment.centerLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        buildText('Name: ${character.first.name}', 16, true),
                        SizedBox(
                          height: 5,
                        ),
                        buildText(
                            'Gender: ${character.first.gender}', 16, false),
                        SizedBox(
                          height: 5,
                        ),
                        buildText('Eye Color: ${character.first.eyeColor}', 16,
                            false),
                        SizedBox(
                          height: 5,
                        ),
                        buildText('Hair Color: ${character.first.hairColor}',
                            16, false),
                        SizedBox(
                          height: 5,
                        ),
                        buildText(
                            'Height: ${character.first.height} cm', 16, false),
                        SizedBox(
                          height: 5,
                        ),
                        buildText(
                            'Mass: ${character.first.mass} kg', 16, false),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            SingleChildScrollView(
              child: Container(
                alignment: Alignment.topCenter,
                margin: EdgeInsets.all(5),
                width: double.infinity,
                //color: Colors.black54,
                height: 380,
                child: Column(
                  children: [
                    Text(
                      'Films: ',
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.5,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    Container(
                      height: 300,
                      padding: EdgeInsets.all(5),
                      child: GridView.count(
                          crossAxisCount: 3,
                          crossAxisSpacing: 2,
                          mainAxisSpacing: 2,
                          childAspectRatio: 1 / 1.8,
                          padding: EdgeInsets.all(5),
                          children: character.first.films.map<Widget>((filmID) {
                            return ListenableProvider(
                                create: (context) =>
                                    CharactersListFilmsViewModel(),
                                child: CharacteresListFilmsView(filmID));
                          }).toList()),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

//auxiliary function to show some information about the characters.
  Text buildText(String text, double fontSize, bool bold) {
    return Text(
      '$text',
      style: TextStyle(
          fontSize: fontSize,
          fontWeight: bold ? FontWeight.bold : FontWeight.normal),
    );
  }
}
