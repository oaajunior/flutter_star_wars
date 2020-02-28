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

  @override
  void initState() {
    _pages = [
    {
      'page': FilmsGridScreen(),
      'title': 'Films',
    },
    {
      'page': CharactersGridScreen(),
      'title': 'Characters',
    }
  ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title'] as String),
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
    });
  }
}
