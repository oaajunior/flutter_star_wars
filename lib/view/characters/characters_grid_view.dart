import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './characters_grid_item_view.dart';
import '../../utils/loading_status.dart';
import '../../view_model/characters/characters_view_model.dart';

class CharactersGridView extends StatefulWidget {
  final filter;
  CharactersGridView(this.filter);

  @override
  _CharactersGridViewState createState() => _CharactersGridViewState();
}

class _CharactersGridViewState extends State<CharactersGridView> {
  ScrollController _controller = ScrollController();
  bool isAllCharactersShowed = true;
  @override
  initState() {
    super.initState();

    final viewModel = Provider.of<CharactersViewModel>(context, listen: false);
    viewModel.feedDataSource(_controller).then((_) {
      _controller.addListener(() {
        if (_controller.position.pixels ==
                _controller.position.maxScrollExtent &&
            isAllCharactersShowed) {
          viewModel.isNextPage = true;
          viewModel.isPreviousPage = false;
          viewModel.feedDataSource(_controller);
        } else if (_controller.position.pixels ==
                _controller.position.minScrollExtent &&
            isAllCharactersShowed) {
          viewModel.isNextPage = false;
          viewModel.isPreviousPage = true;
          viewModel.feedDataSource(_controller);
        }
      });
      listenSearch(viewModel);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void listenSearch(CharactersViewModel vm) {
    widget.filter.addListener(() {
      if (widget.filter.text != null &&
          widget.filter.text.toString().trim().isNotEmpty) {
        var characterName = widget.filter.text.toString().toLowerCase();
        isAllCharactersShowed = false;
        vm.feedDataSource(_controller, searchCharacter: characterName);
      } else if (widget.filter.selection.baseOffset < 0 &&
          !isAllCharactersShowed) {
        isAllCharactersShowed = true;
        vm.feedDataSource(_controller);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CharactersViewModel>(context);

    switch (viewModel.loadingStatus) {
      case LoadingStatus.searching:
        return Align(
          child: CircularProgressIndicator(
            backgroundColor: Colors.red,
          ),
        );

      case LoadingStatus.empty:
        return Align(
          child: Text("No results found."),
        );

      case LoadingStatus.completed:
        return GridView.builder(
          padding: EdgeInsets.all(10),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 300,
            childAspectRatio: 1 / 1.6,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: viewModel.dataSource.length,
          controller: _controller,
          itemBuilder: (BuildContext context, int index) {
            return CharactersGridItemView(viewModel.dataSource[index]);
          },
        );
        default:
        return Text("There was an error to process the request.");
    }
  }
}
