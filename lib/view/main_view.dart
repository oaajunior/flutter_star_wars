import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './characters/characters_grid_view.dart';
import 'films/films_grid_view.dart';
import '../view_model/characters/characters_view_model.dart';
import '../view_model/films/films_view_model.dart';

/* 
** main view class of all app. This class show tab's options Films and Characters.
*/
class MainView extends StatefulWidget {
  static const routeName = '/tab_screen';

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _selectedPageIndex = 0;
  List<Map<String, dynamic>> _pages;

  final TextEditingController _filter = TextEditingController();
  Icon _searchIcon = Icon(Icons.search);
  Widget _appBarTitle = Text("Films");

//initState function is responsible first initialize the tabs options Films and Characters.
  @override
  void initState() {
    super.initState();
    _pages = [
      {
        'page': ListenableProvider(
          create: (context) => FilmsViewModel(),
          child: FilmsGridView(_filter),
        ),
        'title': 'Films',
      },
      {
        'page': ListenableProvider(
          create: (context) => CharactersViewModel(),
          child: CharactersGridView(_filter),
        ),
        'title': 'Characters',
      }
    ];
  }

//function to show how tab was selected.
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
        _searchIcon = Icon(Icons.close);
        _appBarTitle = TextField(
          controller: _filter,
          autofocus: true,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        );
      } else {
        _searchIcon = Icon(Icons.search);
        _appBarTitle = Text(
          _pages[_selectedPageIndex]['title'] as String,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        );
        _filter.clear();
      }
    });
  }
  
  ///function to eliminate the filter when it is been not used.
  @override
  void dispose() {
    _filter.dispose();
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
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Colors.red,
        unselectedItemColor: Color.fromRGBO(255, 134, 51, 0.5),
        currentIndex: _selectedPageIndex,
        onTap: _selectPage,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            title: Text('Films'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            title: Text('Characters'),
          ),
        ],
      ),
    );
  }
}
