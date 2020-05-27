import 'package:app_star_wars/view/characters/characters_grid_view.dart';
import 'package:app_star_wars/view/films/films_grid_view.dart';
import 'package:app_star_wars/view/main_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../lib/router.dart' as router;

void main() {
  Widget makeTestableWidget({Widget child}) {
    return MaterialApp(
      onGenerateRoute: router.generateRoute,
      home: Scaffold(
        body: child,
      ),
    );
  }

  testWidgets('Test Widgets on the Main View', (WidgetTester tester) async {
    //Initialization of the view to the ongoing tests
    var view = MainView();
    var widgetToTest;
    await tester.pumpWidget(makeTestableWidget(child: view));
    await tester.pump(Duration(seconds: 3));

    //Verify if it is in the Main page
    expect(find.byKey(Key(MainView.routeName)), findsOneWidget);

    //Check if the tab bar Films is selected, in this way, the title Films 
    //must be shown twice
    expect(find.text("Films"), findsNWidgets(2));
    expect(find.text("Characters"), findsNWidgets(1));

    //Check if the page FilmsGridViews was instantiated
    widgetToTest = find.byType(FilmsGridView);
    expect(widgetToTest, findsOneWidget);

    //Check if the page CharactersGridView was NOT instantiated
    widgetToTest = find.byType(CharactersGridView);
    expect(widgetToTest, findsNothing);

    //Tap in the icon Characters to change de view
    await tester.tap(find.text('Characters'));
    await tester.pumpAndSettle();

    //Check if the icon Characters is selected, in this way, the title Characters
    //must be shown twice
    expect(find.text("Films"), findsNWidgets(1));
    expect(find.text("Characters"), findsNWidgets(2));

    //Check if the page CharactersGridView was instantiated
    widgetToTest = find.byType(CharactersGridView);
    expect(widgetToTest, findsOneWidget);

    //Check if the page FilmsGridView was NOT instantiated
    widgetToTest = find.byType(FilmsGridView);
    expect(widgetToTest, findsNothing);

    //Enabling the search bar
    widgetToTest = find.byIcon(Icons.search);
    await tester.tap(widgetToTest);
    await tester.pumpAndSettle();

    //Searching for the text 'sky'
    await tester.enterText(find.byType(TextField), 'sky');
    await tester.pump();
    expect(find.text("sky"), findsOneWidget);

    //Disabling the search bar
    widgetToTest = find.byIcon(Icons.close);
    await tester.tap(widgetToTest);
    await tester.pumpAndSettle();

    //Searching for the text 'sky', must have NOT shown anything
    expect(find.text("sky"), findsNothing);
  });
}
