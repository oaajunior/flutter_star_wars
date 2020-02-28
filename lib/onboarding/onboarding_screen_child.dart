import 'package:flutter/material.dart';
import './onboarding_model.dart';

class OnboardingScreenChild extends StatelessWidget {
  final OnboardingModel model;

  OnboardingScreenChild({this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(model.imageName), fit: BoxFit.cover)),
          child: null,
        ),
        Container(
          color: Colors.black.withOpacity(0.7),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Container(
                  padding: EdgeInsets.only(top: 150),
                  child: Column(children: <Widget>[])),
            )
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Center(
              child: Container(
                  padding: EdgeInsets.only(bottom: 70),
                  child: Column(
                    children: <Widget>[
                      Text(
                        model.mainTitle,
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 80),
                        child: Text(
                          model.secondaryTitle,
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ),
                      model.shouldPresentButton
                          ? FlatButton(
                              child: Text(model.buttonTitle),
                              color: Colors.white,
                              onPressed: () {
                                model.onButtonPressed(context);
                              })
                          : Container(),
                    ],
                  )),
            )
          ],
        )
      ],
    ));
  }
}
