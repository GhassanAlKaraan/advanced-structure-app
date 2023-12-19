import 'package:advanced_structure_app/data/data_source/remote_data_source.dart';
import 'package:advanced_structure_app/data/mapper/mapper.dart';
import 'package:advanced_structure_app/data/network/failure.dart';
import 'package:advanced_structure_app/data/network/network_info.dart';
import 'package:advanced_structure_app/data/request/request.dart';
import 'package:advanced_structure_app/domain/model.dart';
import 'package:advanced_structure_app/domain/repository.dart';
import 'package:dartz/dartz.dart';

class RepositoryImpl extends Repository {
  RemoteDataSource _remoteDataSource;
  NetworkInfo _networkInfo;

  RepositoryImpl(this._networkInfo, this._remoteDataSource);

  @override
  Future<Either<Failure, Authentication>> login(
      LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected) { //* CONNECTED
      //safe to call API
      final response = await _remoteDataSource.login(loginRequest);
      if (response.status == 0) { //* SUCCESS
        // return data
        // return right : Authentication
        return Right(response.toDomain());
      } else { //! FAILURE
        // return biz logic ERROR
        // return left : Failure
        return Left(Failure(409,
            response.message ?? "We have a biz error logic from API side"));
      }
    } else { //! NOT CONNECTED
      // return connection error
      return Left(Failure(501, "Please check your internet connection"));
    }
  }
}
