import 'package:flutter/material.dart';
import '../../view/main_view.dart';
import '../../models/onboarding/onboarding_model.dart';
import '../../view_model/onboarding/onboarding_view_model.dart';

/* 
** class responsible to create objects with the initial data about the app.
*/
class OnboardingListViewModel {
  Iterable<OnboardingViewModel> onboardingListModel;

  OnboardingListViewModel.build(BuildContext context) {
    onboardingListModel = [
      OnboardingModel(
        mainTitle: "Star Wars App",
        secondaryTitle: "Welcome to the Star Wars App",
        imageName: "assets/images/cover/sabre_luz.png",
        shouldPresentButton: false,
      ),
      OnboardingModel(
        mainTitle: "Films and Characters",
        secondaryTitle: "In this App you can find about everything",
        imageName: "assets/images/cover/guerra.png",
        shouldPresentButton: false,
      ),
      OnboardingModel(
        mainTitle: "Detailed information",
        secondaryTitle: "You will know about every peace of information",
        imageName: "assets/images/cover/luta.png",
        shouldPresentButton: false,
      ),
      OnboardingModel(
        mainTitle: "Come to the Dark Side",
        secondaryTitle: "The best App ever",
        imageName: "assets/images/cover/dart.png",
        shouldPresentButton: true,
        buttonTitle: "Get Start Now!!!",
        onButtonPressed: (context) => _presentFilmsListPage(context),
      ),
    ].map((item) => OnboardingViewModel(item)).toList();
  }

  _presentFilmsListPage(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(MainView.routeName);
  }
}
