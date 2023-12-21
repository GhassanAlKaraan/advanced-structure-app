import 'package:advanced_structure_app/data/data_source/remote_data_source.dart';
import 'package:advanced_structure_app/data/mapper/mapper.dart';
import 'package:advanced_structure_app/data/network/error_handler.dart';
import 'package:advanced_structure_app/data/network/failure.dart';
import 'package:advanced_structure_app/data/network/network_info.dart';
import 'package:advanced_structure_app/data/request/request.dart';
import 'package:advanced_structure_app/domain/model/model.dart';
import 'package:advanced_structure_app/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

class RepositoryImpl extends Repository {
  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  RepositoryImpl(this._networkInfo, this._remoteDataSource);

  @override
  Future<Either<Failure, Authentication>> login(
      LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected) {
      //* CONNECTED
      try {
        //safe to call API
        final response = await _remoteDataSource.login(loginRequest);
        if (response.status == 0) {
          //* SUCCESS
          // return data
          // return right : Authentication
          return Right(response.toDomain());
        } else {
          //! FAILURE
          // return biz logic ERROR
          // return left : Failure
          return Left(Failure(response.status ?? ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (exception) {
        return (Left(ErrorHandler.handle(exception).failure));
      }
    } else {
      //! NOT CONNECTED
      // return connection error
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
