import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './characters/characters_grid_view.dart';
import './films/films_grid_view.dart';
import '../view_model/characters/characters_view_model.dart';
import '../view_model/films/films_view_model.dart';

/* 
** main view class of all app. This class show tab's options Films and Characters.
*/
class MainView extends StatefulWidget {
  static const routeName = '/main_view';
  final key = Key(routeName);
  final TextEditingController filter = TextEditingController();

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  var _selectedPageIndex = 0;
  List<Map<String, dynamic>> _pages;
  static const _title = <String>['Films', 'Characters'];

  Icon _searchIcon = Icon(
    Icons.search,
    key: Key('icon_search'),
  );
  Widget _appBarTitle = Text(_title[0]);

//initState function is responsible first initialize the tabs options Films and Characters.
  @override
  void initState() {
    super.initState();
    _pages = [
      {
        'page': ListenableProvider(
          create: (context) => FilmsViewModel(),
          child: FilmsGridView(widget.filter),
        ),
        'title': _title[0],
      },
      {
        'page': ListenableProvider(
          create: (context) => CharactersViewModel(),
          child: CharactersGridView(widget.filter),
        ),
        'title': _title[1],
      }
    ];
  }

//function to show which tab was selected.
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
      _appBarTitle = Text(
        _pages[_selectedPageIndex]['title'] as String,
        style: TextStyle(
          color: Colors.white,
        ),
      );
    });
  }

//function to make the searches.
  void _searchPressed() {
    setState(() {
      if (_searchIcon.icon == Icons.search) {
        _searchIcon = Icon(
          Icons.close,
          key: Key('icon_close'),
        );
        _appBarTitle = TextField(
          key: Key('search_text'),
          controller: widget.filter,
          autofocus: true,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        );
      } else {
        _searchIcon = Icon(
          Icons.search,
          key: Key('icon_search'),
        );
        _appBarTitle = Text(
          _pages[_selectedPageIndex]['title'] as String,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        );
        widget.filter.clear();
      }
    });
  }

  Widget _buildBottomNavigation() {
    return BottomNavigationBar(
      backgroundColor: Theme.of(context).primaryColor,
      selectedItemColor: Color.fromRGBO(255, 0, 0, 1.0),
      unselectedItemColor: Color.fromRGBO(255, 134, 51, 0.5),
      currentIndex: _selectedPageIndex,
      onTap: _selectPage,
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.movie,
            key: Key('icon_movie'),
          ),
          title: Text(_pages[0]['title']),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.star,
            key: Key('icon_star'),
          ),
          title: Text(_pages[1]['title']),
        ),
      ],
    );
  }

  ///function to eliminate the filter when it is been not used.
  @override
  void dispose() {
    widget.filter.dispose();
    super.dispose();
  }

//build function to show the main view.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _appBarTitle,
        actions: <Widget>[
          IconButton(
            icon: _searchIcon,
            color: Colors.white,
            onPressed: () => _searchPressed(),
          ),
        ],
      ),
      body: _pages[_selectedPageIndex]['page'],
      resizeToAvoidBottomPadding: false,
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }
}
