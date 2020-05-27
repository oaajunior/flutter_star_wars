import 'package:app_star_wars/view/characters/characters_list_films_view.dart';
import 'package:app_star_wars/view_model/characters/characters_list_films_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_test_utils/image_test_utils.dart';
import 'package:provider/provider.dart';
import '../../../lib/router.dart' as router;
import '../../helper/services/mocked_starwars_service.dart';

void main() {
  //Function to create the main page app
  Widget makeTestableWidget({Widget child}) {
    return MaterialApp(
      onGenerateRoute: router.generateRoute,
      home: Scaffold(
        body: child,
      ),
    );
  }

  testWidgets('Test Widgets in the Characters List Films View',
      (WidgetTester tester) async {
    //function to mock Network Images this function belongs to the package image_test_utils

    provideMockedNetworkImages(() async {
      //Initialization of the view, with mocked service, to the ongoing tests
      final viewModel = CharactersListFilmsViewModel();
      viewModel.service = MockedStarWarsService();
      var filmId = 1;

      final view = ListenableProvider<CharactersListFilmsViewModel>(
        create: (context) {
          return viewModel;
        },
        child: CharacteresListFilmsView(filmId),
      );

      await tester.pumpWidget(makeTestableWidget(child: view));
      await tester.pump(Duration(seconds: 3));

      //Check if it is the CharacteresListFilmsView
      expect(find.byKey(Key(CharacteresListFilmsView.routeName)), findsOneWidget);

      //Check if the Film have been shown
      expect(find.text("Episode IV: A New Hope"), findsOneWidget);
    });
  });
}
