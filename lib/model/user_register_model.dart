class UserRegisterModel {
  int? statusCode;
  String? message;
  Data? data;

  UserRegisterModel({this.statusCode, this.message, this.data});

  UserRegisterModel.fromJson(Map<String, dynamic> json) {
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
  Response? response;
  String? message;

  Data({this.response, this.message});

  Data.fromJson(Map<String, dynamic> json) {
    response = json['response'] != null
        ? Response.fromJson(json['response'])
        : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (response != null) {
      data['response'] = response!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class Response {
  String? userId;
  String? firstName;
  String? lastName;
  String? referralCode;
  String? role;
  String? mobile;
  String? email;
  String? status;
  int? insertDate;
  String? deviceToken;
  String? defaultStore;
  String? cartId;

  Response(
      {this.userId,
        this.firstName,
        this.lastName,
        this.referralCode,
        this.role,
        this.mobile,
        this.email,
        this.status,
        this.insertDate,
        this.deviceToken,
        this.defaultStore,
        this.cartId});

  Response.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    referralCode = json['referralCode'];
    role = json['role'];
    mobile = json['mobile'];
    email = json['email'];
    status = json['status'];
    insertDate = json['insertDate'];
    deviceToken = json['deviceToken'];
    defaultStore = json['defaultStore'];
    cartId = json['cartId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['referralCode'] = referralCode;
    data['role'] = role;
    data['mobile'] = mobile;
    data['email'] = email;
    data['status'] = status;
    data['insertDate'] = insertDate;
    data['deviceToken'] = deviceToken;
    data['defaultStore'] = defaultStore;
    data['cartId'] = cartId;
    return data;
  }
}
