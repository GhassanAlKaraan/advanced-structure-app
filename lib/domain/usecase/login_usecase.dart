import 'package:advanced_structure_app/data/network/failure.dart';
import 'package:advanced_structure_app/data/request/request.dart';
import 'package:advanced_structure_app/domain/model/model.dart';
import 'package:advanced_structure_app/domain/repository/repository.dart';
import 'package:advanced_structure_app/domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';

class LoginUseCase implements BaseUseCase<LoginUseCaseInput, Authentication> {
  final Repository _repository;
  LoginUseCase(this._repository);

  @override
  Future<Either<Failure, Authentication>> execute(
      LoginUseCaseInput input) async {
    await _repository.login(LoginRequest(input.email, input.password, "imei", "deviceType"));
  }
}

class LoginUseCaseInput {
  String email;
  String password;
  LoginUseCaseInput(this.email, this.password);
}
