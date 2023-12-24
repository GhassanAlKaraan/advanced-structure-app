// ignore_for_file: void_checks

import 'dart:ffi';

import 'package:flutter_mvvm/domain/model/model.dart';
import 'package:flutter_mvvm/domain/usecase/store_details_usecase.dart';
import 'package:flutter_mvvm/presentation/base/baseviewmodel.dart';
import 'package:flutter_mvvm/presentation/common/state_renderer/state_render_impl.dart';
import 'package:flutter_mvvm/presentation/common/state_renderer/state_renderer.dart';
import 'package:rxdart/rxdart.dart';

class StoreDetailsViewModel extends BaseViewModel
    with StoreDetailsViewModelInput, StoreDetailsViewModelOutput {
  final _storeDetailsStreamController = BehaviorSubject<StoreDetails>();

  final StoreDetailsUseCase storeDetailsUseCase;

  StoreDetailsViewModel(this.storeDetailsUseCase);

  @override
  start() async {
    _loadData();
  }

  _loadData() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.FULL_SCREEN_LOADING_STATE));
    (await storeDetailsUseCase.execute(Void)).fold(
      (failure) {
        inputState.add(ErrorState(
            StateRendererType.FULL_SCREEN_ERROR_STATE, failure.message));
      },
      (storeDetails) async {
        inputState.add(ContentState());
        inputStoreDetails.add(storeDetails);
      },
    );
  }

  @override
  void dispose() {
    _storeDetailsStreamController.close();
  }

  @override
  Sink get inputStoreDetails => _storeDetailsStreamController.sink;

  //output
  @override
  Stream<StoreDetails> get outputStoreDetails =>
      _storeDetailsStreamController.stream.map((stores) => stores);
}

mixin StoreDetailsViewModelInput {
  Sink get inputStoreDetails;
}

mixin StoreDetailsViewModelOutput {
  Stream<StoreDetails> get outputStoreDetails;
}
