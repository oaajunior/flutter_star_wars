import 'package:app_star_wars/screen/tab_screen.dart';
import 'package:flutter/material.dart';
import './onboarding_model.dart';
import 'onboarding_screen_child.dart';

class OnboardingScreen extends StatelessWidget {
  final PageController controller = PageController();
  List<Widget> dataSource;

  OnboardingScreen() {
    dataSource = [
      OnboardingScreenChild(
          model: OnboardingModel(
        mainTitle: "Star Wars App",
        secondaryTitle: "Welcome to the Star Wars App",
        imageName: "assets/images/cover/sabre_luz.png",
        shouldPresentButton: false,
      )),
      OnboardingScreenChild(
          model: OnboardingModel(
        mainTitle: "All Films",
        secondaryTitle: "In this App you can find about all films",
        imageName: "assets/images/cover/guerra.png",
        shouldPresentButton: false,
      )),
      OnboardingScreenChild(
          model: OnboardingModel(
        mainTitle: "Detailed information",
        secondaryTitle: "You will know about every peace of information",
        imageName: "assets/images/cover/luta.png",
        shouldPresentButton: false,
      )),
      OnboardingScreenChild(
        model: OnboardingModel(
            mainTitle: "Come to the Dark Side",
            secondaryTitle: "The best App ever",
            imageName: "assets/images/cover/dart.png",
            shouldPresentButton: true,
            buttonTitle: "Get Start Now!!!",
            onButtonPressed: (context) {
              _presentFilmsListPage(context: context);
            }),
      ),
    ];
  }

  _presentFilmsListPage({BuildContext context}) {
   Navigator.of(context).pushReplacementNamed(TabsScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
      children: dataSource,
    ));
  }
}
