import 'package:flutter/material.dart';
import './characters/characters_grid_screen.dart';
import 'films/films_grid_screen.dart';

class TabsScreen extends StatefulWidget {
  static const routeName = '/tab_screen';
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  List<Map<String, Object>> _pages;

  final TextEditingController _filter = TextEditingController();
  Icon _searchIcon = Icon(Icons.search);
  Widget _appBarTitle = Text("Films");

  @override
  void initState() {
    super.initState();
    _pages = [
      {
        'page': FilmsGridScreen(_filter),
        'title': 'Films',
      },
      {
        'page': CharactersGridScreen(_filter),
        'title': 'Characters',
      }
    ];
  }
@override
  void dispose() {
    super.dispose();
    _filter.dispose();
  }
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
            icon: Icon(Icons.category),
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

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = Icon(Icons.close);
        this._appBarTitle = TextField(
          controller: _filter,
          autofocus: true,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search),
          ),
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        );
      } else {
        this._searchIcon = Icon(Icons.search);
        this._appBarTitle = Text(
          _pages[_selectedPageIndex]['title'] as String,
          style: TextStyle(
            color: Colors.white,
          ),
        );
        _filter.clear();
      }
    });
  }
}
