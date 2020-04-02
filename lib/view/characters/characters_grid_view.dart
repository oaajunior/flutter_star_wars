import 'package:app_star_wars/view_model/characters/characters_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './characters_grid_item_view.dart';

class CharactersGridView extends StatefulWidget {
  final filter;
  CharactersGridView(this.filter);

  @override
  _CharactersGridViewState createState() => _CharactersGridViewState();
}

class _CharactersGridViewState extends State<CharactersGridView> {
  ScrollController _controller = ScrollController();

  @override
  initState() {
    super.initState();

    final viewModel = Provider.of<CharactersViewModel>(context, listen: false);
    viewModel.feedDataSource(_controller).then((_) {
      _controller.addListener(() {
        if (_controller.position.pixels ==
            _controller.position.maxScrollExtent) {
          viewModel.isNextPage = true;
          viewModel.isPreviousPage = false;
          viewModel.feedDataSource(_controller);
        } else if (_controller.position.pixels ==
            _controller.position.minScrollExtent) {
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
          vm.feedDataSource(_controller, searchCharacter:characterName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CharactersViewModel>(context);

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
  }
}
