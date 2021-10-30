class ErrorResponse{
  late String? mobile;
  late String? type;

  ErrorResponse({ this.mobile,  this.type});

  ErrorResponse.fromJson(Map<String, dynamic> json) {
    mobile = json['mobile'];
    type = json['type'];
  }
}