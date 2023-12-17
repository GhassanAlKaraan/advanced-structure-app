import 'package:json_annotation/json_annotation.dart';
part 'responses.g.dart';
//* Example Json Response:
// {
//     "status": 0,
//     "message": "Success",
//     "customer": {
//         "id": "123456789",
//         "name": " DevGass",
//         "numOfNotifications": 12
//     },
//     "contacts":{
//         "phone": "0123456789",
//         "link" : "twitter.com/DevGass"
//         "email" : "ghassankaraan14@gmail.com",

//     }
// }

@JsonSerializable()
class BaseResponse {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;
}

@JsonSerializable()
class CustomerResponse {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "numOfNotifications")
  int? numOfNotifications;
  CustomerResponse(this.id, this.name, this.numOfNotifications);

    // From JSON
  factory CustomerResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomerResponseFromJson(json);
  // To JSON
  Map<String, dynamic> toJson() => _$CustomerResponseToJson(this);
}

@JsonSerializable()
class ContactsResponse {
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "phone")
  String? phone;
  @JsonKey(name: "link")
  String? link;

  ContactsResponse(this.email, this.link, this.phone);

    // From JSON
  factory ContactsResponse.fromJson(Map<String, dynamic> json) =>
      _$ContactsResponseFromJson(json);
  // To JSON
  Map<String, dynamic> toJson() => _$ContactsResponseToJson(this);
}

// Login Response Template
@JsonSerializable()
class AuthenticationResponse extends BaseResponse {
  @JsonKey(name: "customer")
  CustomerResponse? customer;

  @JsonKey(name: "contacts")
  ContactsResponse? contacts;

  AuthenticationResponse(this.customer, this.contacts);

  // From JSON
  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationResponseFromJson(json);
  // To JSON
  Map<String, dynamic> toJson() => _$AuthenticationResponseToJson(this);
}
