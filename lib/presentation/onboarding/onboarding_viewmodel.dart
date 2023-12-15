import 'dart:async';

import 'package:advanced_structure_app/presentation/base/baseviewmodel.dart';

import '../../domain/model.dart';
import '../resources/assets_manager.dart';
import '../resources/strings_manager.dart';

class OnBoardingViewModel extends BaseViewModel
    with OnBoardingViewModelInputs, OnBoardingViewModelOutputs {
  //* stream controllers
  final StreamController _streamController =
      StreamController<SliderViewObject>();
  // moved these here from the view
  late final List<SliderObject> _list;
  int _currentIndex = 0;

  @override
  void start() {
    _list = _getSliderData();
    // Send this slider data to our view
    _postDataToView();
  }

  @override
  void dispose() {
    _streamController.close();
  }

  @override
  int goNext() {
    int nextIndex = _currentIndex++;
    if (nextIndex >= _list.length) {
      _currentIndex = 0;
    }
    return _currentIndex;
  }

  @override
  int goPrevious() {
    int previousIndex = _currentIndex--;
    if (previousIndex == -1) {
      _currentIndex = _list.length - 1;
    }
    return _currentIndex;
  }

  @override
  void onPageChanged(int index) {
    _currentIndex = index;
    // Because currentindex has changed, we have to send a new data to the view.
    _postDataToView();
  }

  // @override
  // void goPrevious() {
  //   int previousIndex = _currentIndex--;
  //   if (previousIndex == -1) {
  //     _currentIndex = _list.length - 1;
  //   }
  //   _postDataToView();
  // }

  @override
  void testing() {
    // TODO: implement testing
  }

  //* Input Section Getter
  @override
  Sink get inputSliderViewObject => _streamController.sink;

  //* Output Section Getter
  @override
  Stream<SliderViewObject> get outputSliderViewObject =>
      _streamController.stream.map((sliderViewObject) => sliderViewObject);

  //* Private functions
  List<SliderObject> _getSliderData() => [
        SliderObject(AppStrings.onBoardingTitle1,
            AppStrings.onBoardingSubTitle1, ImageAssets.onboardingLogo1),
        SliderObject(AppStrings.onBoardingTitle2,
            AppStrings.onBoardingSubTitle2, ImageAssets.onboardingLogo2),
        SliderObject(AppStrings.onBoardingTitle3,
            AppStrings.onBoardingSubTitle3, ImageAssets.onboardingLogo3),
        SliderObject(AppStrings.onBoardingTitle4,
            AppStrings.onBoardingSubTitle4, ImageAssets.onboardingLogo4),
      ];

  _postDataToView() {
    // Add data to sink
    inputSliderViewObject.add(
        SliderViewObject(_currentIndex, _list.length, _list[_currentIndex]));
  }
}

// Inputs received by the view model
mixin OnBoardingViewModelInputs {
  int goNext(); // right arrow / swipe left
  int goPrevious(); // left arrow / swipe right
  void onPageChanged(int index);

  // Stream input: add data to stream
  Sink get inputSliderViewObject;
}
// Results will be sent from this view model to the view
mixin OnBoardingViewModelOutputs {
  // Later
  Stream<SliderViewObject> get outputSliderViewObject;
}

class SliderViewObject {
  SliderObject sliderObject;
  int numOfSlides;
  int currentIndex;

  SliderViewObject(this.currentIndex, this.numOfSlides, this.sliderObject);
}
