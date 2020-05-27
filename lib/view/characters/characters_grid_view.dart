import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import './characters_item_view.dart';
import '../../utils/loading_status.dart';
import '../../view_model/characters/characters_view_model.dart';

/* 
** main class to show all characters.
*/

class CharactersGridView extends StatefulWidget {
  static const routeName = '/characters_grid_screen';
  final key = Key(routeName);
  final filter;
  CharactersGridView(this.filter);

  @override
  _CharactersGridViewState createState() => _CharactersGridViewState();
}

class _CharactersGridViewState extends State<CharactersGridView> {
  ScrollController _controller;
  bool isAllCharactersShowed = true;

  //initState is responsible to get the initial characters data and register the controller
  //to control previous and next pages and search.
  @override
  initState() {
    _controller = ScrollController();
    final viewModel = Provider.of<CharactersViewModel>(context, listen: false);
    viewModel.feedDataSource().then((_) {
      _controller.addListener(() {
        if (_controller.offset >= _controller.position.maxScrollExtent &&
            isAllCharactersShowed) {
          viewModel.isNextPage = true;
          viewModel.feedDataSource();
        } else if (_controller.offset <= _controller.position.minScrollExtent &&
            isAllCharactersShowed) {
          viewModel.isNextPage = false;
          viewModel.feedDataSource();
        }
      });
      listenSearch(viewModel);
    });
    super.initState();
  }

//function to eliminate the controller when it is been not used.
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

//function responsible to make searches.
  void listenSearch(CharactersViewModel vm) {
    widget.filter.addListener(() {
      var text = widget.filter.text.toString().trim();
      if (text != null && text.isNotEmpty) {
        var characterName = text.toLowerCase();
        isAllCharactersShowed = false;
        vm.feedDataSource(searchCharacter: characterName);
      } else if (widget.filter.selection.baseOffset < 0 &&
          !isAllCharactersShowed) {
        isAllCharactersShowed = true;
        vm.feedDataSource();
      }
    });
  }

  void jumpTopScreen(ScrollController controller) {
    if (controller.hasClients) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        controller.animateTo(controller.position.minScrollExtent + 1.0,
            duration: Duration(milliseconds: 350), curve: Curves.easeOut);
      });
    }
  }

//build function that show the relatively widget, according the REST API status code.
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CharactersViewModel>(context);

    switch (viewModel.loadingStatus) {
      case LoadingStatus.loading:
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
        jumpTopScreen(_controller);
        return GridView.builder(
          key: Key('chars_grid_view'),
          padding: EdgeInsets.all(10),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1 / 1.6,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: viewModel.dataSource.length,
          controller: _controller,
          itemBuilder: (BuildContext context, int index) {
            return CharactersItemView(
              character: viewModel.dataSource[index],
            );
          },
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
