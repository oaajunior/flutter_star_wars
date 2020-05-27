import 'package:app_star_wars/models/onboarding/onboarding_model.dart';
import 'package:app_star_wars/view/main_view.dart';
import 'package:flutter/material.dart';

class MockedOnboardingModel implements OnboardingModel {
  @override
  Color buttonBackgroundColor;

  @override
  Color buttonColor;

  @override
  String buttonTitle;

  @override
  String imageName;

  @override
  String mainTitle;

  @override
  Function onButtonPressed;

  @override
  String secondaryTitle;

  @override
  bool shouldPresentButton;

  MockedOnboardingModel.parcialModel() {
    mainTitle = "Star Wars App";
    secondaryTitle = "Welcome to the Star Wars App";
    imageName = "assets/images/cover/sabre_luz.png";
    shouldPresentButton = false;
  }

  MockedOnboardingModel.fullModel() {
    mainTitle = "Come to the Dark Side";
    secondaryTitle = "The best App ever";
    imageName = "assets/images/cover/dart.png";
    shouldPresentButton = true;
    buttonTitle = "Get Start Now!!!";
    onButtonPressed = (context) => _presentFilmsListPage(context);
  }

  static void _presentFilmsListPage(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(MainView.routeName);
  }
}
