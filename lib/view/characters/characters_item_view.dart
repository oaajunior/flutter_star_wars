import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import './characters_item_detail_view.dart';
import '../../models/characters/characters_model.dart';

/* 
** auxiliary class to show each characters.
*/
class CharactersItemView extends StatelessWidget {
  final CharactersModel character;
  CharactersItemView({this.character});
  static const routeName = '/characters_item_screen';
  final key = Key(routeName);

//function to call the screen responsible to show detailed information
//about the selected character.
  void _selectedCharacter(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      CharactersItemDetailView.routeName,
      arguments: {
        character,
      },
    );
  }

//build function to show each character.
  @override
  Widget build(BuildContext context) {
    return character.name == null || character.name.isEmpty
        ? Container(
            width: 200,
            height: 250,
            color: Colors.transparent,
          )
        : InkWell(
            key: Key('${character.name}'),
            onTap: () => _selectedCharacter(context),
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
                        image: character.imageNetwork,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      alignment: Alignment.centerLeft,
                      color: Colors.white,
                      child: Text('Name: ${character.name}'),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
