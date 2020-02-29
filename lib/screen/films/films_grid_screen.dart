import 'dart:convert';
import 'package:flutter/material.dart';
import '../../services/starwars_service.dart';
import '../../models/films_all_response.dart';
import './films_grid_item.dart';

class FilmsGridScreen extends StatefulWidget {
  final StarWarsService service = StarWarsServiceImpl();
  final TextEditingController filter;

  FilmsGridScreen(this.filter);

  @override
  _FilmsGridScreenState createState() => _FilmsGridScreenState();
}

class _FilmsGridScreenState extends State<FilmsGridScreen> {
  List<FilmsAllResponse> dataSource = [];

  String searchName = "";
  bool searchFilm = false;

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
  initState() {
    super.initState();
    _feedDataSource();
    listenSearch();
  }

  _feedDataSource() {
    if (searchFilm) {
      widget.service.fetchFilmsBySearch(name: searchName).then((response) {
        var json = jsonDecode(response.body);
        List<FilmsAllResponse> filmsList = [];
        var list = json["results"];

        if (list != null) {
          for (var film in list) {
            var filmResponse = FilmsAllResponse.fromMappedJson(film);

            filmResponse.episodeIdRoman =
                widget.service.convertToRoman(filmResponse.episodeId);

            if (film["url"] != null) {
              List<String> split;
              split = film["url"].toString().split("/");
              split.removeLast();
              filmResponse.id = split.last;
              filmResponse.imageNetwork =
                  widget.service.networkImageID(type: "films/", id: split.last);
            }
            filmsList.add(filmResponse);
          }

          filmsList.sort((a, b) => a.episodeId.compareTo(b.episodeId));
          if (mounted) {
            setState(() {
              dataSource = filmsList;
            });
          }
        }
      });
    } else {
      widget.service.fetchAllFilms().then((response) {
        var json = jsonDecode(response.body);
        List<FilmsAllResponse> filmsList = [];
        var list = json["results"];

        if (list != null) {
          for (var film in list) {
            var filmResponse = FilmsAllResponse.fromMappedJson(film);

            filmResponse.episodeIdRoman =
                widget.service.convertToRoman(filmResponse.episodeId);

            if (film["url"] != null) {
              List<String> split;
              split = film["url"].toString().split("/");
              split.removeLast();
              filmResponse.id = split.last;
              filmResponse.imageNetwork =
                  widget.service.networkImageID(type: "films/", id: split.last);
            }
            filmsList.add(filmResponse);
          }

          filmsList.sort((a, b) => a.episodeId.compareTo(b.episodeId));
          if (mounted) {
            setState(() {
              dataSource = filmsList;
            });
          }
        }
      });
    }
  }

  void listenSearch() {
    widget.filter.addListener(() {
      if (widget.filter.text.isNotEmpty) {
        searchName = widget.filter.text.toLowerCase();
        searchFilm = true;
        _feedDataSource();
      } else {
        searchName = "";
        searchFilm = false;
        _feedDataSource();
      }
    });
  }
}
