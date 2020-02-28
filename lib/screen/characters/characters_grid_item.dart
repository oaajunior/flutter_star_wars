import '../../models/characters_all_response.dart';
import 'package:flutter/material.dart';
import 'characters_detailed_screen.dart';
import 'package:transparent_image/transparent_image.dart';

class CharactersGridItem extends StatelessWidget {
  final CharactersAllResponse character;

  CharactersGridItem(this.character);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selectedCharacgter(context),
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

  void _selectedCharacgter(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      CharacterDetailedScreen.routeName,
      arguments: {
        character,
      },
    );
  }
}
