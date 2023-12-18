import 'package:advanced_structure_app/data/responses/responses.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';
import '../../app/constant.dart';
part 'app_api.g.dart';

@RestApi(baseUrl: Constant.baseUrl)
abstract class AppServiceClient {
  // Interface to interact with the API

  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

  @POST("/customers/login")
  Future<AuthenticationResponse> login(
    @Field("email") String email,
    @Field("password")  String password,
    @Field("imei")  String imei,
    @Field("deviceType")  String deviceType,

  );
}
