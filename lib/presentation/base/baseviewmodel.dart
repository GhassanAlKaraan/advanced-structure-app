abstract class BaseViewModel extends BaseViewModelInputs with BaseViewModelOutputs {
  // Shared variables and methods that will be used through any view model
}

abstract class BaseViewModelInputs {
  void start(); // Called while initilization of the view model
  void dispose(); // Called when view model dies
}

mixin BaseViewModelOutputs {
  void testing(); // Not used ?
}
