import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:login/bloc/bloc.dart';
import 'package:login/helpers/api_helper.dart';
import 'package:login/model/create_otp_model.dart';
import 'package:login/model/user_register_model.dart';
import 'package:login/model/verify_otp_model.dart';
import 'package:login/resource_helper/strings.dart';
import 'package:rxdart/rxdart.dart';

class UserBloc extends Object implements Bloc {
  final apiHelper = ApiHelper();

  final textOtpController = BehaviorSubject<String>();

  Function(String) get otpChange => textOtpController.sink.add;

  Stream<String> get otpStream =>
      textOtpController.stream.transform(otpValidate);

  final firstNameController = BehaviorSubject<String>();

  Function(String) get firstnameChange => firstNameController.sink.add;

  Stream<String> get firstnameStream =>
      firstNameController.stream.transform(firstNameValidate);

  final lastNameController = BehaviorSubject<String>();

  Function(String) get lastNameChanged => lastNameController.sink.add;

  Stream<String> get lastNameStream =>
      lastNameController.stream.transform(lastNameValidate);

  final emailControler = BehaviorSubject<String>();

  Function(String) get emailChanged => emailControler.sink.add;

  Stream<String> get emailStream =>
      emailControler.stream.transform(emailValidate);

  final BehaviorSubject createOtpController = BehaviorSubject<CreateOtpModel>();

  StreamSink get createOtpSink => createOtpController.sink;

  Stream get createOtpStream => createOtpController.stream;

  final phoneNumber = BehaviorSubject<String>();

  Function(String) get numberChanged => phoneNumber.sink.add;

  Stream<String> get numberStream =>
      phoneNumber.stream.transform(numberValidate);

  final referralController = BehaviorSubject<String>();

  Function(String) get referralChanged => referralController.sink.add;

  Stream<String> get referralStream =>
      referralController.stream.transform(referralValidate);

  Stream<bool> get verifyOtpCheck =>
      Rx.combineLatest(otpStream as Iterable<Stream<String>>, (otp) => true);

  List<Stream<String>> streamList = [];

  Stream<bool> get submitCheck => Rx.combineLatest(streamList, (phone) => true);

  Stream<bool> get userDetailsCheck => Rx.combineLatest4(
      firstnameStream,
      lastNameStream,
      emailStream,
      referralStream,
      (firstName, lastName, email, referral) => true);

  UserBloc() {
    streamList.add(numberStream);
  }

  Future<UserRegisterModel> registerUser(
      String firstName,
      String lastName,
      String email,
      String referral,
      String otp,
      String mobile,
      int? token) async {
    try {
      var response = await apiHelper.register(userDetails(token!, mobile));
      return response;
    } on Exception {
      return "error" as UserRegisterModel;
    }
  }

  Future<CreateOtpModel> verifyNumber(String number, String user) async {
    try {
      var response = await apiHelper.addUser(addUserNumber(user));
      //createOtpSink.add(response);
      return response;
    } on Exception {
      //  var response = json.decode(exception.toString());
      // var errorMessage = ErrorResponse.fromJson(response);
      // createOtpSink.addError(errorMessage.type!);
      return "error" as CreateOtpModel;
    }
  }

  Future<CreateOtpModel> resendOtp(String number, String user) async {
    try {
      var response = await apiHelper.addUser(otpResend(number,user));
      //createOtpSink.add(response);
      return response;
    } on Exception {
      //  var response = json.decode(exception.toString());
      // var errorMessage = ErrorResponse.fromJson(response);
      // createOtpSink.addError(errorMessage.type!);
      return "error" as CreateOtpModel;
    }
  }

  Future<VerifyOtpModel> verifyOtp(
      String otp, String userRegister, String mobile) async {
    try {
      var response = await apiHelper.verifyOtp(otpVerify(userRegister, mobile));
      print("verifyOtpModel $response");
      response.data!.token;
      return response;
    } on Exception {
      return "error" as VerifyOtpModel;
    }
  }

  final otpValidate =
      StreamTransformer<String, String>.fromHandlers(handleData: (otp, sink) {
    if (otp.toString().isEmpty) {
      sink.addError("enter otp");
    } else if (otp.toString().length < 4) {
      sink.addError("enter valid otp");
    } else {
      sink.add(otp);
    }
  });

  final firstNameValidate = StreamTransformer<String, String>.fromHandlers(
      handleData: (firstName, sink) {
    if (firstName.toString().isNotEmpty) {
      sink.add(firstName);
    } else {
      sink.addError("Enter First Name");
    }
  });

  final lastNameValidate = StreamTransformer<String, String>.fromHandlers(
      handleData: (lastName, sink) {
    if (lastName.isNotEmpty) {
      sink.add(lastName);
    } else {
      sink.addError("Enter Last Name");
    }
  });

  final numberValidate = StreamTransformer<String, String>.fromHandlers(
      handleData: (number, sink) {
    if (number.toString().isNotEmpty) {
      sink.add(number);
    } else {
      sink.addError("Enter phone number");
    }
  });

  final emailValidate =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
            .hasMatch(email) &&
        email.isNotEmpty) {
      sink.add(email);
    } else {
      sink.add(email);
    }
  });

  final referralValidate = StreamTransformer<String, String>.fromHandlers(
      handleData: (referral, sink) {
    if (referral.isEmpty) {
      sink.add(referral);
    } else {
      sink.add(referral);
    }
  });

  @override
  void dispose() {
    lastNameController.close();
    firstNameController.close();
    phoneNumber.close();
    textOtpController.close();
    emailControler.close();
    referralController.close();
  }

  String addUserNumber(String user) {
    var jsonRequest =
        json.encode({"mobile": phoneNumber.value.toString(), "type": user});
    return jsonRequest;
  }

  String otpResend(String number,String user) {
    var jsonRequest =
    json.encode({"mobile": number, "type": user});
    return jsonRequest;
  }

  String userDetails(int token, String mobile) {
    var jsonRequest = json.encode({
      "firstName": firstNameController.value.toString(),
      "lastName": lastNameController.value.toString(),
      "email": emailControler.value.toString(),
      "deviceToken": "1234345",
      "otpToken": token,
      "mobile": mobile,
      "authType": "app"
    });
    return jsonRequest;
  }

  String otpVerify(String userRegister, String mobile) {
    var jsonRequest = json.encode({
      "otp": int.parse(textOtpController.value),
      "type": userRegister,
      "mobile": mobile,
    });
    return jsonRequest;
  }
}
