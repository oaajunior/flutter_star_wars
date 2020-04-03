import 'package:flutter/material.dart';
import '../../view_model/onboarding/onboarding_view_model.dart';

/* 
** auxiliary class to show initial information about the app.
*/
class OnboardingItemView extends StatelessWidget {
  final OnboardingViewModel viewModelAdapter;

  OnboardingItemView(this.viewModelAdapter);

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
                      padding: EdgeInsets.only(
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
                        ? RaisedButton(
                            padding: EdgeInsets.all(0),
                            child: Container(
                              padding: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: <Color>[
                                    Color(0xFF521203),
                                    Color(0xFF8c0606),
                                  ],
                                ),
                              ),
                              child: Text(
                                viewModelAdapter.buttonTitle,
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            textColor: Colors.white,
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
