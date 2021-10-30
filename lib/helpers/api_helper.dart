import 'package:login/helpers/api_constants.dart';
import 'package:login/helpers/http_helper.dart';
import 'package:login/model/create_otp_model.dart';
import 'package:login/model/user_register_model.dart';
import 'package:login/model/verify_otp_model.dart';

class ApiHelper {
  static final ApiHelper _getInstance = ApiHelper._internal();

  ApiHelper._internal();

  factory ApiHelper() {
    return _getInstance;
  }

  final HttpHelper httpHelper = HttpHelper();

  Future<CreateOtpModel> addUser(String reqBody) async {
    var result =
        await httpHelper.post(url: ApiConstants.createOtp, body: reqBody);
    return CreateOtpModel.fromJson(result as Map<String, dynamic>);
  }

  Future<VerifyOtpModel> verifyOtp(String reqBody) async {
    var result =
        await httpHelper.post(url: ApiConstants.verifyOtp, body: reqBody);
    return VerifyOtpModel.fromJson(result as Map<String, dynamic>);
  }
  
  Future<UserRegisterModel> register(String reqBody) async{
    var result = await httpHelper.post(url: ApiConstants.register, body: reqBody);
    return UserRegisterModel.fromJson(result as Map<String,dynamic>);
  }
}
