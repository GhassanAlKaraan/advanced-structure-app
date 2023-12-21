import 'dart:async';

import 'package:advanced_structure_app/presentation/base/baseviewmodel.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInputs, LoginViewModelOutputs {
  //Stream controllers
  final StreamController _userNameStreamController =
      StreamController<String>.broadcast();
  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();

  //var loginObject = LoginObject("", "");

  @override
  void dispose() {
    _userNameStreamController.close();
    _passwordStreamController.close();
  }

  @override
  void start() {
    // TODO: implement start
  }

  @override
  void testing() {}

  @override
  Sink get inputPassword => _passwordStreamController;

  @override
  Sink get inputUserName => _userNameStreamController;

  @override
  login() {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
  }

  @override
  setUserName(String userName) {
    // TODO: implement setUserName
    throw UnimplementedError();
  }

  @override
  Stream<bool> get outputIsPasswordValid => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  Stream<bool> get outputIsUserNameValid => _userNameStreamController.stream
      .map((userName) => _isUserNameValid(userName));

  //private functions
  bool _isPasswordValid(String password) {
    return password.isNotEmpty;
  }

  bool _isUserNameValid(String userName) {
    return userName.isNotEmpty;
  }
}

mixin LoginViewModelInputs {
  // Tree functions
  setUserName(String userName);
  setPassword(String password);
  login();

  // Two sinks for streams
  Sink get inputUserName;
  Sink get inputPassword;
}

mixin LoginViewModelOutputs {
  Stream<bool> get outputIsUserNameValid;
  Stream<bool> get outputIsPasswordValid;
}
