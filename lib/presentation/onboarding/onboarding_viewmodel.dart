import 'dart:async';

import 'package:advanced_structure_app/presentation/base/baseviewmodel.dart';
import 'package:advanced_structure_app/presentation/onboarding/onboarding.dart';

import '../../domain/model.dart';

class OnBoardingViewModel extends BaseViewModel
    with OnBoardingViewModelInputs, OnBoardingViewModelOutputs {
  //! stream controllers
  final StreamController _streamController =
      StreamController<SliderViewObject>();

  @override
  void start() {
    // TODO: implement start
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  void goNext() {
    // TODO: implement goNext
  }

  @override
  void goPrevious() {
    // TODO: implement goPrevious
  }

  @override
  void onPageChanged(int index) {
    // TODO: implement onPageChanged
  }

  @override
  void testing() {
    // TODO: implement testing
  }

  //! Input Section
  @override
  Sink get inputSliderViewObject => _streamController.sink;

  //! Output Section
  @override
  Stream<SliderViewObject> get outputSliderViewObject =>
      _streamController.stream.map((sliderViewObject) => sliderViewObject);
}

// Inputs received by the view model
mixin OnBoardingViewModelInputs {
  void goNext(); // right arrow / swipe left
  void goPrevious(); // left arrow / swipe right
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
