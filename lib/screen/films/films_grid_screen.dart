import 'dart:convert';
import 'package:flutter/material.dart';
import '../../services/starwars_service.dart';
import '../../models/films_all_response.dart';
import './films_grid_item.dart';

class FilmsGridScreen extends StatefulWidget {
  
  StarWarsService service = StarWarsServiceImpl();
  @override
  _FilmsGridScreenState createState() => _FilmsGridScreenState();
  
}

class _FilmsGridScreenState extends State<FilmsGridScreen> {
  List<FilmsAllResponse> dataSource = [];
  
  @override
  Widget build(BuildContext context) {
    return GridView(
        padding: EdgeInsets.all(10),
      children: dataSource
          .map(
            (filmData) => FilmsGridItem(
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
  }

@override
initState(){
  super.initState();
  _feedDataSource();
}


  _feedDataSource() {
    widget.service.fetchAllFilms().then((response) {
      var json = jsonDecode(response.body);
      List<FilmsAllResponse> filmsList = [];
      var list = json["results"];
      
      if (list != null) {
        for (var film in list) {
          var filmResponse = FilmsAllResponse.fromMappedJson(film);
          
          filmResponse.episodeIdRoman = widget.service.convertToRoman(filmResponse.episodeId);
           
           if (film["url"] != null) {
            List<String> split;
            split = film["url"].toString().split("/");
            split.removeLast();

            filmResponse.id = split.last;
            filmResponse.imageID = split.last;
           }
          filmsList.add(filmResponse);
        }
        
        filmsList.sort((a, b) => a.episodeId.compareTo( b.episodeId));
        print(filmsList);
        
        setState(() {
          dataSource = filmsList;
        });
      }
    });
  }
}