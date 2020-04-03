import 'package:flutter/material.dart';
import '../../view/onboarding/onboarding_item_view.dart';
import '../../view_model/onboarding/onboarding_list_view_model.dart';

/* 
** class responsible to show initial information about the app.
*/
class OnboardingView extends StatelessWidget {

 @override
  Widget build(BuildContext context) {
  
  final viewModel = OnboardingListViewModel.build(context);
   
   return Scaffold(
        body: PageView(
      children: viewModel.onboardingListModel.map((item) => OnboardingItemView(item)).toList(),
    ));
  }
}
