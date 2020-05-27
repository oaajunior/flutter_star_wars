import 'package:app_star_wars/view/films/films_grid_view.dart';
import 'package:app_star_wars/view/films/films_item_view.dart';
import 'package:app_star_wars/view/main_view.dart';
import 'package:app_star_wars/view_model/films/films_view_model.dart';
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

  testWidgets('Test Widgets in the Films View', (WidgetTester tester) async {
    //function to mock Network Images this function belongs to the package image_test_utils

    provideMockedNetworkImages(() async {
      
      //Initialization of the view, with mocked service, to the ongoing tests
      final viewModel = FilmsViewModel();
      viewModel.service = MockedStarWarsService();
      final filter = MainView().filter;

      final view = ListenableProvider<FilmsViewModel>(
        create: (context) {
          return viewModel;
        },
        child: FilmsGridView(filter),
      );

      await tester.pumpWidget(makeTestableWidget(child: view));
      await tester.pump(Duration(seconds: 3));

      //Check if it is the FilmsGridView
      expect(find.byKey(Key(FilmsGridView.routeName)), findsOneWidget);

      //Run the function feedDataSource and check if it was created 3 items
      viewModel.feedDataSource();
      await tester.pump(Duration(seconds: 3));
      expect(find.byType(FilmsItemView), findsNWidgets(3));

      //select one film to see the details
      await tester.tap(find.text("Episode IV: A New Hope"));
      await tester.pumpAndSettle();

      //Check if the details have been shown
      expect(find.text("Director: George Lucas"), findsOneWidget);

      //Back to the previous page
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();

      //Run the function feedDataSource, with the parameter searchName,
      //and check if it was found just one widget
      viewModel.feedDataSource(searchName: "hope");
      await tester.pumpAndSettle();
      expect(find.byType(FilmsItemView), findsOneWidget);

      //Run the function feedDataSource, with the parameter searchName,
      //and check if it found nothing
      viewModel.feedDataSource(searchName: "revenge");
      await tester.pumpAndSettle();
      expect(find.byType(FilmsItemView), findsNothing);
    });
  });
}
