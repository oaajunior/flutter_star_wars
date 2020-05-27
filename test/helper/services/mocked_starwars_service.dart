import 'package:app_star_wars/services/starwars_service.dart';

enum MockedState { success, error }

class MockedStarWarsService implements StarWarsService {
  MockedState state;

  MockedStarWarsService({this.state = MockedState.success});

  @override
  Future<dynamic> fetchCharactersBySearch({String name}) {
    switch (state) {
      case MockedState.success:
        return _fetchCharactersBySearchWithSuccess(name);
        break;
      case MockedState.error:
        return _fetchCharactersBySearchWithError(name);
        break;
    }

    return null;
  }

  Future<dynamic> _fetchCharactersBySearchWithSuccess(String name) {
    Future<dynamic> future = Future<dynamic>(() {
      var response = {
        "count": 3,
        "next": "http://swapi.dev/api/people/?page=2",
        "previous": null,
        "results": [
          {
            "name": "Luke Skywalker",
            "height": "172",
            "mass": "77",
            "hair_color": "blond",
            "skin_color": "fair",
            "eye_color": "blue",
            "birth_year": "19BBY",
            "gender": "male",
            "homeworld": "http://swapi.dev/api/planets/1/",
            "url": "http://swapi.dev/api/people/1/",
            "films": [
              "http://swapi.dev/api/films/1/",
              "http://swapi.dev/api/films/2/",
              "http://swapi.dev/api/films/3/",
              "http://swapi.dev/api/films/6/"
            ],
          },
          {
            "name": "R2-D2",
            "height": "96",
            "mass": "32",
            "hair_color": "n/a",
            "skin_color": "white, blue",
            "eye_color": "red",
            "birth_year": "33BBY",
            "gender": "n/a",
            "homeworld": "http://swapi.dev/api/planets/8/",
            "url": "http://swapi.dev/api/people/2/",
            "films": [
              "http://swapi.dev/api/films/1/",
              "http://swapi.dev/api/films/2/",
              "http://swapi.dev/api/films/3/",
              "http://swapi.dev/api/films/4/",
              "http://swapi.dev/api/films/5/",
              "http://swapi.dev/api/films/6/"
            ],
          },
          {
            "name": "Darth Vader",
            "height": "202",
            "mass": "136",
            "hair_color": "none",
            "skin_color": "white",
            "eye_color": "yellow",
            "birth_year": "41.9BBY",
            "gender": "male",
            "homeworld": "http://swapi.dev/api/planets/1/",
            "url": "http://swapi.dev/api/people/3/",
            "films": [
              "http://swapi.dev/api/films/1/",
              "http://swapi.dev/api/films/2/",
              "http://swapi.dev/api/films/3/",
              "http://swapi.dev/api/films/6/"
            ],
          },
          {
            "name": "Anakin Skywalker",
            "height": "188",
            "mass": "84",
            "hair_color": "blond",
            "skin_color": "fair",
            "eye_color": "blue",
            "birth_year": "41.9BBY",
            "gender": "male",
            "homeworld": "http://swapi.dev/api/planets/1/",
            "url": "http://swapi.dev/api/people/4/",
            "films": [
              "http://swapi.dev/api/films/4/",
              "http://swapi.dev/api/films/5/",
              "http://swapi.dev/api/films/6/"
            ],
          }
        ]
      };
      var listCharacter = [];
      response.forEach((key, value) {
        if (key == "results") {
          for (var item in value) {
            item.forEach((key, value) {
              if (key == "name" &&
                  value.toString().toLowerCase().contains(name)) {
                listCharacter.add(item);
              }
            });
          }
        }
      });
      response["results"] = listCharacter;
      return response;
    });

    return future;
  }

  Future<dynamic> _fetchCharactersBySearchWithError(String name) {
    return Future.error("404");
  }

  @override
  Future<dynamic> fetchAllCharacters({String page}) {
    switch (state) {
      case MockedState.success:
        return _fetchAllCharactersWithSuccess(page);
        break;
      case MockedState.error:
        return _fetchAllCharactersWithError(page);
        break;
    }

    return null;
  }

  Future<dynamic> _fetchAllCharactersWithSuccess(String page) {
    Future<dynamic> future = Future<dynamic>(() {
      var response = {
        "count": 4,
        "next": "http://swapi.dev/api/people/?page=2",
        "previous": null,
        "results": [
          {
            "name": "Luke Skywalker",
            "height": "172",
            "mass": "77",
            "hair_color": "blond",
            "skin_color": "fair",
            "eye_color": "blue",
            "birth_year": "19BBY",
            "gender": "male",
            "homeworld": "http://swapi.dev/api/planets/1/",
            "url": "http://swapi.dev/api/people/1/",
            "films": [
              "http://swapi.dev/api/films/1/",
              "http://swapi.dev/api/films/2/",
              "http://swapi.dev/api/films/3/",
              "http://swapi.dev/api/films/6/"
            ],
          },
          {
            "name": "R2-D2",
            "height": "96",
            "mass": "32",
            "hair_color": "n/a",
            "skin_color": "white, blue",
            "eye_color": "red",
            "birth_year": "33BBY",
            "gender": "n/a",
            "homeworld": "http://swapi.dev/api/planets/8/",
            "url": "http://swapi.dev/api/people/2/",
            "films": [
              "http://swapi.dev/api/films/1/",
              "http://swapi.dev/api/films/2/",
              "http://swapi.dev/api/films/3/",
              "http://swapi.dev/api/films/4/",
              "http://swapi.dev/api/films/5/",
              "http://swapi.dev/api/films/6/"
            ],
          },
          {
            "name": "Darth Vader",
            "height": "202",
            "mass": "136",
            "hair_color": "none",
            "skin_color": "white",
            "eye_color": "yellow",
            "birth_year": "41.9BBY",
            "gender": "male",
            "homeworld": "http://swapi.dev/api/planets/1/",
            "url": "http://swapi.dev/api/people/3/",
            "films": [
              "http://swapi.dev/api/films/1/",
              "http://swapi.dev/api/films/2/",
              "http://swapi.dev/api/films/3/",
              "http://swapi.dev/api/films/6/"
            ],
          },
          {
            "name": "Anakin Skywalker",
            "height": "188",
            "mass": "84",
            "hair_color": "blond",
            "skin_color": "fair",
            "eye_color": "blue",
            "birth_year": "41.9BBY",
            "gender": "male",
            "homeworld": "http://swapi.dev/api/planets/1/",
            "url": "http://swapi.dev/api/people/4/",
            "films": [
              "http://swapi.dev/api/films/4/",
              "http://swapi.dev/api/films/5/",
              "http://swapi.dev/api/films/6/"
            ],
          }
        ]
      };

      return response;
    });

    return future;
  }

  Future<dynamic> _fetchAllCharactersWithError(String page) {
    return Future.error("404");
  }

  @override
  Future<dynamic> fetchAllFilms() {
    switch (state) {
      case MockedState.success:
        return _fetchAllFilmsWithSuccess();
        break;
      case MockedState.error:
        return _fetchAllFilmsWithError();
        break;
    }
    return null;
  }

  Future<dynamic> _fetchAllFilmsWithSuccess() {
    Future<dynamic> future = Future<dynamic>(() {
      var response = {
        "count": 6,
        "next": null,
        "previous": null,
        "results": [
          {
            "title": "A New Hope",
            "episode_id": 4,
            "opening_crawl":
                "It is a period of civil war.\r\nRebel spaceships, striking\r\nfrom a hidden base, have won\r\ntheir first victory against\r\nthe evil Galactic Empire.\r\n\r\nDuring the battle, Rebel\r\nspies managed to steal secret\r\nplans to the Empire's\r\nultimate weapon, the DEATH\r\nSTAR, an armored space\r\nstation with enough power\r\nto destroy an entire planet.\r\n\r\nPursued by the Empire's\r\nsinister agents, Princess\r\nLeia races home aboard her\r\nstarship, custodian of the\r\nstolen plans that can save her\r\npeople and restore\r\nfreedom to the galaxy....",
            "director": "George Lucas",
            "producer": "Gary Kurtz, Rick McCallum",
            "release_date": "1977-05-25",
            "url": "http://swapi.dev/api/films/1/",
          },
          {
            "title": "The Empire Strikes Back",
            "episode_id": 5,
            "opening_crawl":
                "It is a dark time for the\r\nRebellion. Although the Death\r\nStar has been destroyed,\r\nImperial troops have driven the\r\nRebel forces from their hidden\r\nbase and pursued them across\r\nthe galaxy.\r\n\r\nEvading the dreaded Imperial\r\nStarfleet, a group of freedom\r\nfighters led by Luke Skywalker\r\nhas established a new secret\r\nbase on the remote ice world\r\nof Hoth.\r\n\r\nThe evil lord Darth Vader,\r\nobsessed with finding young\r\nSkywalker, has dispatched\r\nthousands of remote probes into\r\nthe far reaches of space....",
            "director": "Irvin Kershner",
            "producer": "Gary Kurtz, Rick McCallum",
            "release_date": "1980-05-17",
            "url": "http://swapi.dev/api/films/2/",
          },
          {
            "title": "Return of the Jedi",
            "episode_id": 6,
            "opening_crawl":
                "Luke Skywalker has returned to\r\nhis home planet of Tatooine in\r\nan attempt to rescue his\r\nfriend Han Solo from the\r\nclutches of the vile gangster\r\nJabba the Hutt.\r\n\r\nLittle does Luke know that the\r\nGALACTIC EMPIRE has secretly\r\nbegun construction on a new\r\narmored space station even\r\nmore powerful than the first\r\ndreaded Death Star.\r\n\r\nWhen completed, this ultimate\r\nweapon will spell certain doom\r\nfor the small band of rebels\r\nstruggling to restore freedom\r\nto the galaxy...",
            "director": "Richard Marquand",
            "producer": "Howard G. Kazanjian, George Lucas, Rick McCallum",
            "release_date": "1983-05-25",
            "url": "http://swapi.dev/api/films/3/",
          }
        ]
      };
      return response;
    });

    return future;
  }

  Future<dynamic> _fetchAllFilmsWithError() {
    return Future.error("404");
  }

  @override
  Future<dynamic> fetchFilmsByID({int id}) {
    switch (state) {
      case MockedState.success:
        return _fetchFilmsByIDWithSuccess(id);
        break;
      case MockedState.error:
        return _fetchFilmsByIDWithError(id);
        break;
    }
    return null;
  }

  Future<dynamic> _fetchFilmsByIDWithSuccess(int id) {
    Future<dynamic> future = Future<dynamic>(() {
      var response = [
        {
          "id": 1,
          "title": "A New Hope",
          "episode_id": 4,
          "opening_crawl":
              "It is a period of civil war.\r\nRebel spaceships, striking\r\nfrom a hidden base, have won\r\ntheir first victory against\r\nthe evil Galactic Empire.\r\n\r\nDuring the battle, Rebel\r\nspies managed to steal secret\r\nplans to the Empire's\r\nultimate weapon, the DEATH\r\nSTAR, an armored space\r\nstation with enough power\r\nto destroy an entire planet.\r\n\r\nPursued by the Empire's\r\nsinister agents, Princess\r\nLeia races home aboard her\r\nstarship, custodian of the\r\nstolen plans that can save her\r\npeople and restore\r\nfreedom to the galaxy....",
          "director": "George Lucas",
          "producer": "Gary Kurtz, Rick McCallum",
          "release_date": "1977-05-25",
          "url": "http://swapi.dev/api/films/1/",
        },
        {
          "id": 2,
          "title": "The Empire Strikes Back",
          "episode_id": 5,
          "opening_crawl":
              "It is a dark time for the\r\nRebellion. Although the Death\r\nStar has been destroyed,\r\nImperial troops have driven the\r\nRebel forces from their hidden\r\nbase and pursued them across\r\nthe galaxy.\r\n\r\nEvading the dreaded Imperial\r\nStarfleet, a group of freedom\r\nfighters led by Luke Skywalker\r\nhas established a new secret\r\nbase on the remote ice world\r\nof Hoth.\r\n\r\nThe evil lord Darth Vader,\r\nobsessed with finding young\r\nSkywalker, has dispatched\r\nthousands of remote probes into\r\nthe far reaches of space....",
          "director": "Irvin Kershner",
          "producer": "Gary Kurtz, Rick McCallum",
          "release_date": "1980-05-17",
          "url": "http://swapi.dev/api/films/2/",
        },
        {
          "id": 3,
          "title": "Return of the Jedi",
          "episode_id": 6,
          "opening_crawl":
              "Luke Skywalker has returned to\r\nhis home planet of Tatooine in\r\nan attempt to rescue his\r\nfriend Han Solo from the\r\nclutches of the vile gangster\r\nJabba the Hutt.\r\n\r\nLittle does Luke know that the\r\nGALACTIC EMPIRE has secretly\r\nbegun construction on a new\r\narmored space station even\r\nmore powerful than the first\r\ndreaded Death Star.\r\n\r\nWhen completed, this ultimate\r\nweapon will spell certain doom\r\nfor the small band of rebels\r\nstruggling to restore freedom\r\nto the galaxy...",
          "director": "Richard Marquand",
          "producer": "Howard G. Kazanjian, George Lucas, Rick McCallum",
          "release_date": "1983-05-25",
          "url": "http://swapi.dev/api/films/3/",
        }
      ];
      var finalResponse;
      response.forEach((element) {
        element.forEach((key, value) {
          if (key == "id" && value == id) finalResponse = element;
        });
      });
      return finalResponse;
    });

    return future;
  }

  Future<dynamic> _fetchFilmsByIDWithError(int id) {
    return Future.error("404");
  }

  @override
  Future<dynamic> fetchFilmsBySearch({String name}) {
    switch (state) {
      case MockedState.success:
        return _fetchAllFilmsBySearchWithSuccess(name);
        break;
      case MockedState.error:
        return _fetchAllFilmsBySearchWithError(name);
        break;
    }

    return null;
  }

  Future<dynamic> _fetchAllFilmsBySearchWithSuccess(String name) {
    Future<dynamic> future = Future<dynamic>(() {
      var response = {
        "count": 6,
        "next": null,
        "previous": null,
        "results": [
          {
            "title": "A New Hope",
            "episode_id": 4,
            "opening_crawl":
                "It is a period of civil war.\r\nRebel spaceships, striking\r\nfrom a hidden base, have won\r\ntheir first victory against\r\nthe evil Galactic Empire.\r\n\r\nDuring the battle, Rebel\r\nspies managed to steal secret\r\nplans to the Empire's\r\nultimate weapon, the DEATH\r\nSTAR, an armored space\r\nstation with enough power\r\nto destroy an entire planet.\r\n\r\nPursued by the Empire's\r\nsinister agents, Princess\r\nLeia races home aboard her\r\nstarship, custodian of the\r\nstolen plans that can save her\r\npeople and restore\r\nfreedom to the galaxy....",
            "director": "George Lucas",
            "producer": "Gary Kurtz, Rick McCallum",
            "release_date": "1977-05-25",
            "url": "http://swapi.dev/api/films/1/",
          },
          {
            "title": "The Empire Strikes Back",
            "episode_id": 5,
            "opening_crawl":
                "It is a dark time for the\r\nRebellion. Although the Death\r\nStar has been destroyed,\r\nImperial troops have driven the\r\nRebel forces from their hidden\r\nbase and pursued them across\r\nthe galaxy.\r\n\r\nEvading the dreaded Imperial\r\nStarfleet, a group of freedom\r\nfighters led by Luke Skywalker\r\nhas established a new secret\r\nbase on the remote ice world\r\nof Hoth.\r\n\r\nThe evil lord Darth Vader,\r\nobsessed with finding young\r\nSkywalker, has dispatched\r\nthousands of remote probes into\r\nthe far reaches of space....",
            "director": "Irvin Kershner",
            "producer": "Gary Kurtz, Rick McCallum",
            "release_date": "1980-05-17",
            "url": "http://swapi.dev/api/films/2/",
          },
          {
            "title": "Return of the Jedi",
            "episode_id": 6,
            "opening_crawl":
                "Luke Skywalker has returned to\r\nhis home planet of Tatooine in\r\nan attempt to rescue his\r\nfriend Han Solo from the\r\nclutches of the vile gangster\r\nJabba the Hutt.\r\n\r\nLittle does Luke know that the\r\nGALACTIC EMPIRE has secretly\r\nbegun construction on a new\r\narmored space station even\r\nmore powerful than the first\r\ndreaded Death Star.\r\n\r\nWhen completed, this ultimate\r\nweapon will spell certain doom\r\nfor the small band of rebels\r\nstruggling to restore freedom\r\nto the galaxy...",
            "director": "Richard Marquand",
            "producer": "Howard G. Kazanjian, George Lucas, Rick McCallum",
            "release_date": "1983-05-25",
            "url": "http://swapi.dev/api/films/3/",
          }
        ]
      };

      var listCharacter = [];
      response.forEach((key, value) {
        if (key == "results") {
          for (var item in value) {
            item.forEach((key, value) {
              if (key == "title" &&
                  value.toString().toLowerCase().contains(name)) {
                listCharacter.add(item);
              }
            });
          }
        }
      });
      response["results"] = listCharacter;
      return response;
    });

    return future;
  }

  Future<dynamic> _fetchAllFilmsBySearchWithError(String name) {
    return Future.error("404");
  }
}
