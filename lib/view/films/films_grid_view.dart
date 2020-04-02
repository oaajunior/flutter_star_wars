//import 'package:app_star_wars/utils/loading_status.dart';
import 'package:app_star_wars/utils/loading_status.dart';
import 'package:app_star_wars/view_model/films/films_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './films_grid_item_view.dart';

class FilmsGridView extends StatefulWidget {
  final filter;
  FilmsGridView(this.filter);

  @override
  _FilmsGridViewState createState() => _FilmsGridViewState();
}

class _FilmsGridViewState extends State<FilmsGridView> {
  bool isAllFilmsShowed = true;

  @override
  void initState() {
    final viewModel = Provider.of<FilmsViewModel>(context, listen: false);
    viewModel.feedDataSource().then((_) {
      listenSearch(viewModel);
    });
    super.initState();
  }

  void listenSearch(FilmsViewModel vm) {
    widget.filter.addListener(() {
      if (widget.filter.text != null &&
          widget.filter.text.toString().trim().isNotEmpty) {
        var filmeName = widget.filter.text.toString().toLowerCase();
        vm.feedDataSource(searchName: filmeName);
        isAllFilmsShowed = false;
      } else if (widget.filter.selection.baseOffset < 0 && !isAllFilmsShowed) {
        vm.feedDataSource();
        isAllFilmsShowed = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<FilmsViewModel>(context);

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
        return GridView(
          padding: EdgeInsets.all(10),
          children: viewModel.dataSource
              .map(
                (filmData) => FilmsGridItemView(
                  filmData,
                ),
              )
              .toList(),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 300,
            childAspectRatio: 1 / 1.6,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
        );
      default:
        return Text("There was an error to process the request.");
    }
  }
}
