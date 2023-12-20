import 'package:advanced_structure_app/presentation/onboarding/onboarding_viewmodel.dart';
import 'package:advanced_structure_app/presentation/resources/assets_manager.dart';
import 'package:advanced_structure_app/presentation/resources/color_manager.dart';
import 'package:advanced_structure_app/presentation/resources/routes_manager.dart';
import 'package:advanced_structure_app/presentation/resources/strings_manager.dart';
import 'package:advanced_structure_app/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../domain/model/model.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final PageController _pageController = PageController(initialPage: 0);

  final OnBoardingViewModel _viewModel = OnBoardingViewModel();

  _bind() {
    _viewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  // Build a Stream of SliderViewObject
  @override
  Widget build(BuildContext context) {
    // return _getContentWidget();
    return StreamBuilder<SliderViewObject>(
      stream: _viewModel.outputSliderViewObject,
      builder: (context, snapshot) {
        return _getContentWidget(snapshot.data);
      },
    );
  }

  // Scaffold
  Widget _getContentWidget(SliderViewObject? sliderViewObject) {
    if (sliderViewObject == null) {
      return Container();
    } else {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorManager.white,
          elevation: AppSize.s0,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: ColorManager.white,
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark,
          ),
        ),
        backgroundColor: ColorManager.white,
        body: PageView.builder(
          controller: _pageController,
          itemCount: sliderViewObject.numOfSlides, //
          onPageChanged: (index) {
            _viewModel.onPageChanged(index); //
          },
          itemBuilder: (context, index) {
            return OnBoardingPage(sliderViewObject.sliderObject); //
          },
        ),
        bottomSheet: Container(
          color: ColorManager.white,
          height: AppSize.s100,
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.loginRoute);
                  },
                  child: Text(
                    AppStrings.skip,
                    textAlign: TextAlign.end,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ),

              // Indicator circles and arrows
              _getBottomSheetWidget(sliderViewObject) //
            ],
          ),
        ),
      );
    }
  }

// Circles design and display functions
  Widget _getBottomSheetWidget(SliderViewObject sliderViewObject) {
    return Container(
      color: ColorManager.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppPadding.p8),
            child: GestureDetector(
              onTap: () {
                _pageController.animateToPage(_viewModel.goPrevious(), //
                    duration:
                        const Duration(milliseconds: DurationConstant.d300),
                    curve: Curves.bounceInOut);
              },
              child: SvgPicture.asset(
                ImageAssets.leftArrowIc,
                width: AppSize.s20,
                height: AppSize.s20,
              ),
            ),
          ),

          //* Circle Indicators
          Row(
            children: [
              for (int i = 0; i < sliderViewObject.numOfSlides; i++) //
                Padding(
                  padding: const EdgeInsets.all(AppPadding.p8),
                  child: _getProperCircle(i, sliderViewObject.currentIndex),
                ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.all(AppPadding.p8),
            child: GestureDetector(
              onTap: () {
                _pageController.animateToPage(_viewModel.goNext(),
                    duration:
                        const Duration(milliseconds: DurationConstant.d300),
                    curve: Curves.bounceInOut);
              },
              child: SvgPicture.asset(
                ImageAssets.rightArrowIc,
                width: AppSize.s20,
                height: AppSize.s20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getProperCircle(int index, int currentIndex) {
    if (index == currentIndex) {
      return SvgPicture.asset(ImageAssets.hollowCircleIc);
    } else {
      return SvgPicture.asset(ImageAssets.solidCircleIc);
    }
  }
}

// Prepared the page design for every SlideObject, 1-2-3
class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage(this._sliderObject, {super.key});

  final SliderObject _sliderObject;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: AppSize.s40),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            _sliderObject.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            _sliderObject.subTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        const SizedBox(height: AppSize.s60),
        SvgPicture.asset(
          _sliderObject.image,
          width: AppSize.s200,
          height: AppSize.s200,
        ),
      ],
    );
  }
}
