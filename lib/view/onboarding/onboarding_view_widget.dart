import 'package:flutter/material.dart';
import '../../view_model/onboarding/onboarding_view_model.dart';

class OnboardingViewWidget extends StatelessWidget {
  final OnboardingViewModel viewModelAdapter;

  OnboardingViewWidget(this.viewModelAdapter);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(viewModelAdapter.imageName),
              fit: BoxFit.cover,
            ),
          ),
          child: null,
        ),
        Container(
          color: Colors.black.withOpacity(0.5),
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
                      viewModelAdapter.mainTitle,
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                        bottom: 80,
                      ),
                      child: Text(
                        viewModelAdapter.secondaryTitle,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    viewModelAdapter.shouldPresentButton
                        ? FlatButton(
                            child: Text(viewModelAdapter.buttonTitle),
                            color: Colors.white,
                            onPressed: () {
                              viewModelAdapter.onButtonPressed(context);
                            })
                        : Container(),
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    ));
  }
}
