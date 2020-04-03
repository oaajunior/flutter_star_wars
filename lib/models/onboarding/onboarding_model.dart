import "package:flutter/cupertino.dart";
import 'package:flutter/material.dart';

/* 
** class to represent the initial informations about the app.
*/
class OnboardingModel {
  String mainTitle;
  String secondaryTitle;
  String imageName;
  String buttonTitle;
  Color buttonColor;
  Color buttonBackgroundColor;
  bool shouldPresentButton;
  Function onButtonPressed;

  OnboardingModel({
    this.mainTitle,
    this.secondaryTitle,
    this.imageName,
    this.buttonTitle = "",
    this.buttonColor = Colors.white,
    this.buttonBackgroundColor = Colors.black,
    this.shouldPresentButton = false,
    this.onButtonPressed,
  });
}
