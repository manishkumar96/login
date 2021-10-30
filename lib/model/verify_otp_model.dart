class VerifyOtpModel {
  int? statusCode;
  String? message;
  Data? data;

  VerifyOtpModel({this.statusCode, this.message, this.data});

  VerifyOtpModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  bool? isNewUser;
  Response? response;
  int? token;
  String? type;

  Data(
      {required this.isNewUser,
      required this.response,
      required this.token,
      required this.type});

  Data.fromJson(Map<String, dynamic> json) {
    isNewUser = json['isNewUser'];
    response = json['response'] != null
        ? Response.fromJson(json['response'])
        : null;
    token = json['token'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isNewUser'] = isNewUser;
    if (response != null) {
      data['response'] = response!.toJson();
    }
    data['token'] = token;
    data['type'] = type;
    return data;
  }
}

class Response {
  String? firstName;
  String? lastName;
  String? deviceToken;
  String? mobile;
  String? email;
  String? status;
  String? referralCode;
  int? insertDate;
  String? userId;
  String? cartId;

  Response(
      {required this.firstName,
      required this.lastName,
      required this.deviceToken,
      required this.mobile,
      required this.email,
      required this.status,
      required this.referralCode,
      required this.insertDate,
      required this.userId,
      required this.cartId});

  Response.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    deviceToken = json['deviceToken'];
    mobile = json['mobile'];
    email = json['email'];
    status = json['status'];
    referralCode = json['referralCode'];
    insertDate = json['insertDate'];
    userId = json['userId'];
    cartId = json['cartId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['deviceToken'] = deviceToken;
    data['mobile'] = mobile;
    data['email'] = email;
    data['status'] = status;
    data['referralCode'] = referralCode;
    data['insertDate'] = insertDate;
    data['userId'] = userId;
    data['cartId'] = cartId;
    return data;
  }
}
