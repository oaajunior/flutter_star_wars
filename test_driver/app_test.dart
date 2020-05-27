import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  //Declaration of some useful variables
  FlutterDriver driver;
  var onboardingPage;
  var button;
  var text;
  var widgetTest;
  var item;

  // Connect to the Flutter driver before running any tests.
  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });

  // Close the connection to the driver after the tests have completed.
  tearDownAll(() async {
    if (driver != null) {
      driver.close();
    }
  });

  test('Integration Tests of the Star Wars App', () async {
    onboardingPage = find.byValueKey("onboarding_view");

    //Go through the onboarding page to the main page
    WaitFor(onboardingPage);

    await Future.delayed(Duration(milliseconds: 500));
    await driver.scroll(onboardingPage, -300, 0, Duration(milliseconds: 500));
    await driver.scroll(onboardingPage, -300, 0, Duration(milliseconds: 500));
    await driver.scroll(onboardingPage, -300, 0, Duration(milliseconds: 500));

    button = find.byValueKey("button");
    WaitFor(button);
    await driver.tap(button);
    WaitFor(find.text("Films"));
    await Future.delayed(Duration(milliseconds: 3000));

    //Access one film in the list
    text = find.text("Episode I: The Phantom Menace");
    await driver.tap(text);
    await Future.delayed(Duration(milliseconds: 1000));
    widgetTest = find.byType('IconButton');
    await driver.tap(widgetTest);
    await Future.delayed(Duration(milliseconds: 1000));

    //Search for a specific film
    widgetTest = find.byValueKey('icon_search');
    await driver.tap(widgetTest);
    await Future.delayed(Duration(milliseconds: 500));
    widgetTest = find.byValueKey('search_text');
    await driver.tap(widgetTest);
    await driver.enterText("menace");
    await Future.delayed(Duration(milliseconds: 1000));
    widgetTest = find.byValueKey('icon_close');
    await driver.tap(widgetTest);
    await Future.delayed(Duration(milliseconds: 500));

    //Access the page Star
    widgetTest = find.byValueKey('icon_star');
    await driver.tap(widgetTest);
    await Future.delayed(Duration(milliseconds: 1000));

    //Access one character in the list
    item = find.byValueKey('Leia Organa');
    widgetTest = find.byValueKey('chars_grid_view');
    await driver.scrollUntilVisible(widgetTest, item, dyScroll: -300.0);
    await Future.delayed(Duration(milliseconds: 500));
    await driver.tap(item);
    await Future.delayed(Duration(milliseconds: 500));
    widgetTest = find.byType('IconButton');
    await driver.tap(widgetTest);
    await Future.delayed(Duration(milliseconds: 500));

    //Search for a specific character
    widgetTest = find.byValueKey('icon_search');
    await driver.tap(widgetTest);
    await Future.delayed(Duration(milliseconds: 500));
    widgetTest = find.byValueKey('search_text');
    await driver.tap(widgetTest);
    await driver.enterText("sky");
    await Future.delayed(Duration(milliseconds: 1000));
    widgetTest = find.byValueKey('icon_close');
    await driver.tap(widgetTest);
    await Future.delayed(Duration(milliseconds: 500));

    //Back to the main page
    widgetTest = find.byValueKey('icon_movie');
    await driver.tap(widgetTest);
    await Future.delayed(Duration(milliseconds: 1000));
  });
}
