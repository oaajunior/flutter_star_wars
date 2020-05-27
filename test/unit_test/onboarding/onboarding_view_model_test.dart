import 'package:app_star_wars/models/onboarding/onboarding_model.dart';
import 'package:app_star_wars/view_model/onboarding/onboarding_view_model.dart';
import 'package:test/test.dart';
import '../../helper/services/mocked_onboarding.dart';

main() {
  OnboardingModel model;
  OnboardingViewModel onboardingViewModel;
  List<OnboardingViewModel> onboardingListModel;

  group('Test OnboardingModel', () {
    test('test empty variables class ', () {
      expect(model, null);
      expect(onboardingViewModel, null);
      expect(onboardingListModel, null);
    });

    test('test OnboardingModel class with partial variables', () {
      model = MockedOnboardingModel.parcialModel();
      expect(model, isNotNull);
      expect(model.mainTitle, "Star Wars App");
      expect(model.secondaryTitle, "Welcome to the Star Wars App");
      expect(model.imageName, "assets/images/cover/sabre_luz.png");
      expect(model.shouldPresentButton, isFalse);
    });

    test('test OnboardingViewModel class', () {
      onboardingViewModel = OnboardingViewModel(model);

      expect(onboardingViewModel.mainTitle, "Star Wars App");
      expect(
          onboardingViewModel.secondaryTitle, "Welcome to the Star Wars App");
      expect(
          onboardingViewModel.imageName, "assets/images/cover/sabre_luz.png");
      expect(onboardingViewModel.shouldPresentButton, isFalse);
    });

    test('test List<OnboardingViewModel>', () {
      onboardingListModel = List<OnboardingViewModel>();

      expect(onboardingListModel.length, 0);

      onboardingListModel.add(onboardingViewModel);

      expect(onboardingListModel.length, 1);
    });

    test('test OnboardingModel class with all variables', () {
      model = MockedOnboardingModel.fullModel();

      expect(model, isNotNull);
      expect(model.mainTitle, "Come to the Dark Side");
      expect(model.secondaryTitle, "The best App ever");
      expect(model.imageName, "assets/images/cover/dart.png");
      expect(model.shouldPresentButton, isTrue);
      expect(model.buttonTitle, "Get Start Now!!!");
      expect(model.onButtonPressed, isA<Function>());
    });
  });
}
