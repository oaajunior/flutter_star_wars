import 'package:app_star_wars/view_model/characters/characters_list_films_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import '../../utils/util.dart';

class CharacteresListFilmsView extends StatefulWidget {
  final filmID;
  CharacteresListFilmsView(this.filmID);

  @override
  _CharacteresListFilmsViewState createState() =>
      _CharacteresListFilmsViewState();
}

class _CharacteresListFilmsViewState extends State<CharacteresListFilmsView> {
  @override
  initState() {
    Future.microtask(() =>
        Provider.of<CharactersListFilmsViewModel>(context, listen: false)
            .feedDataSource(widget.filmID));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CharactersListFilmsViewModel>(context);

    return Container(
      padding: EdgeInsets.all(5),
      child: Card(
        elevation: 4,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(2),
              child: viewModel.filmResponse.imageNetwork == null
                  ? Text("")
                  : FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: viewModel.filmResponse.imageNetwork,
                      fit: BoxFit.contain,
                    ),
            ),
            Container(
              color: Colors.white,
              child: Text(
                "Episode ${viewModel.filmResponse.episodeId == null ? '' : Util.convertToRoman(viewModel.filmResponse.episodeId)}: ${viewModel.filmResponse.title == null ? "" : viewModel.filmResponse.title}",
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
}
