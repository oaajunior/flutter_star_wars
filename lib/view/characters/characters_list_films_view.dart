import 'package:app_star_wars/utils/loading_status.dart';
import 'package:app_star_wars/view_model/characters/characters_list_films_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import '../../utils/util.dart';

/* 
** class responsable to show each films the selected character have been worked.
*/
class CharacteresListFilmsView extends StatefulWidget {
  static const routeName = '/characters_list_films_screen';
  final key = Key(routeName);
  final filmId;
  CharacteresListFilmsView(this.filmId);

  @override
  _CharacteresListFilmsViewState createState() =>
      _CharacteresListFilmsViewState();
}

class _CharacteresListFilmsViewState extends State<CharacteresListFilmsView> {
  @override
  initState() {
    Future.microtask(() =>
        Provider.of<CharactersListFilmsViewModel>(context, listen: false)
            .feedDataSource(filmId: widget.filmId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CharactersListFilmsViewModel>(context);

    switch (viewModel.loadingStatus) {
      case LoadingStatus.loading:
        return Align(
          child: CircularProgressIndicator(
            backgroundColor: Colors.red,
          ),
        );
      case LoadingStatus.completed:
        return Container(
          padding: EdgeInsets.all(5),
          child: Card(
            elevation: 4,
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(5),
                  child: viewModel.filmResponse.imageNetwork == null
                      ? Text("")
                      : FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image: viewModel.filmResponse.imageNetwork,
                          fit: BoxFit.contain,
                        ),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  color: Colors.white,
                  child: Text(
                    "Episode ${viewModel.filmResponse.episodeId == null ? '' : Util.convertToRoman(viewModel.filmResponse.episodeId)}: ${viewModel.filmResponse.title == null ? "" : viewModel.filmResponse.title}",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );

      case LoadingStatus.empty:
        return Align(
          child: Text("No results found."),
        );
      case LoadingStatus.error:
        return Align(
          child: Text("There was a network error."),
        );
      default:
        return Align(
          child: Text("There was an error to process the request."),
        );
    }
  }
}
