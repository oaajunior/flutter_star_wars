import 'package:app_star_wars/view/characters/characters_grid_view.dart';
import 'package:app_star_wars/view/characters/characters_item_view.dart';
import 'package:app_star_wars/view/main_view.dart';
import 'package:app_star_wars/view_model/characters/characters_view_model.dart';
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

  testWidgets('Test Widgets in the Characters View',
      (WidgetTester tester) async {
    //function to mock Network Images this function belongs to the package image_test_utils

    provideMockedNetworkImages(() async {
      
      //Initialization of the view, with mocked service, to the ongoing tests
      final viewModel = CharactersViewModel();
      viewModel.service = MockedStarWarsService();
      final filter = MainView().filter;

      final view = ListenableProvider<CharactersViewModel>(
        create: (context) {
          return viewModel;
        },
        child: CharactersGridView(filter),
      );

      await tester.pumpWidget(makeTestableWidget(child: view));
      await tester.pump(Duration(seconds: 3));

      //Check if it is the CharactersGridView
      expect(find.byKey(Key(CharactersGridView.routeName)), findsOneWidget);

      //Run the function feedDataSource and check if it was created 3 items
      viewModel.feedDataSource();
      await tester.pump(Duration(seconds: 3));
      expect(find.byKey(Key(CharactersItemView.routeName)), findsWidgets);

     //Check if the Characters have been shown
      expect(find.text("Name: Luke Skywalker"), findsOneWidget);

      //Run the function feedDataSource, with the parameter searchCharacter,
      //and check if it found just one widget
      viewModel.feedDataSource(searchCharacter: "darth vader");
      await tester.pumpAndSettle();
      expect(find.text("Name: Darth Vader"), findsOneWidget);

      //Run the function feedDataSource, with the parameter searchCharacter,
      //and check if it found nothing
      viewModel.feedDataSource(searchCharacter: "organa");
      await tester.pumpAndSettle();
      expect(find.byType(CharactersItemView), findsNothing);
    });
  });
}
