import 'package:app_star_wars/view/onboarding/onboarding_view.dart';
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

  testWidgets('Test dragging page on the Onboarding View',
      (WidgetTester tester) async {
    //Initialization of the view to the ongoing tests
    var view = OnboardingView();
    await tester.pumpWidget(makeTestableWidget(child: view));
    var page = find.byKey(Key("onboarding_view"));

    //Verify if it is in the first page
    expect(find.text("Star Wars App"), findsOneWidget);

    //Drag to the next page and test if the second page is corret
    await tester.drag(page, Offset(-500, 0));
    await tester.pumpAndSettle();
    expect(find.text("Films and Characters"), findsOneWidget);

    //Drag to the previous page and test if it is corret
    await tester.drag(page, Offset(500, 0));
    await tester.pumpAndSettle();
    expect(find.text("Star Wars App"), findsOneWidget);
  });

  testWidgets('Test moving from Onboarding View to the Main App View',
      (WidgetTester tester) async {
    //Initialization of the view to the ongoing tests
    var view = OnboardingView();
    await tester.pumpWidget(makeTestableWidget(child: view));
    var page = find.byKey(Key("onboarding_view"));

    //Navigate through Onboarding pages
    await tester.drag(page, Offset(-500, 0));
    await tester.pumpAndSettle();
    await tester.drag(page, Offset(-500, 0));
    await tester.pumpAndSettle();
    await tester.drag(page, Offset(-500, 0));
    await tester.pumpAndSettle();

    //Tap the button to access the main app page
    var button = find.byKey(Key("button"));
    await tester.tap(button);
    await tester.pumpAndSettle();

    //Verify it is in the main app page
    expect(find.byKey(Key("/main_view")), findsOneWidget);
  });
}
