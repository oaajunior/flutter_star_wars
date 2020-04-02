import 'package:app_star_wars/models/onboarding/onboarding_model.dart';

class OnboardingViewModel {
  OnboardingModel _onboardingModel;

  OnboardingViewModel(this._onboardingModel); 

  String get mainTitle {
    return _onboardingModel.mainTitle;
  }

  String get secondaryTitle {
    return _onboardingModel.secondaryTitle;
  }

  String get imageName {
    return _onboardingModel.imageName;
  }

  bool get shouldPresentButton {
    return _onboardingModel.shouldPresentButton;
  }

  String get buttonTitle {
    return _onboardingModel.buttonTitle;
  }

  Function get onButtonPressed {
    return _onboardingModel.onButtonPressed;
  }
}