import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/bloc/user_bloc.dart';
import 'package:login/resource_helper/color.dart';
import 'package:login/resource_helper/dimens.dart';
import 'package:login/resource_helper/strings.dart';
import 'package:login/ui/mobile_verify.dart';
import 'package:login/ui/sign_up.dart';
import 'package:login/widget/pin_code_fields.dart';
import 'package:login/widget/progress_bar.dart';
import 'package:login/widget/text_btn.dart';

class VerifyOtp extends StatefulWidget {
  final String mobile;
  final String userRegister;

  const VerifyOtp(this.mobile, this.userRegister, {Key? key}) : super(key: key);

  @override
  _VerifyOtpState createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> {
  late UserBloc userBloc;

  final textOtpController = TextEditingController();
  late ProgressBar progressBar;
  String otp = "";
  bool resendVisible = false, fillOtp = true;
  final FocusNode focusNode = FocusNode();
  late Timer timer;

  final interval = const Duration(seconds: 1);
  final int timerMaxSeconds = 10;
  int currentSeconds = 0;

  String get timerText =>
      '${((timerMaxSeconds - currentSeconds) ~/ 60).toString().padLeft(2, '0')}: ${((timerMaxSeconds - currentSeconds) % 60).toString().padLeft(2, '0')}';

  startTimeout([int? milliseconds]) {
    var duration = interval;
    Timer.periodic(duration, (timer) {
      setState(() {
        currentSeconds = timer.tick;
        if (timer.tick >= timerMaxSeconds) {
          resendVisible = true;
          fillOtp = false;
          timer.cancel();
        }
      });
    });
  }

  @override
  void initState() {
    startTimeout();
    super.initState();
    progressBar = ProgressBar();
    userBloc = UserBloc();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBar(),
        body: Column(
          children: [
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      verifyOtpText(),
                      sentViaSMS(),
                      otpFields(),
                      autoFillOtp(),
                      didnotReceiveCode(),
                      continueButton(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      backgroundColor: ColorHelper.background,
      elevation: 0,
      leading: InkWell(
        onTap: () {
          print("back button pressed");
          verifyToLogin();
        },
        child: const Icon(
          Icons.arrow_back_ios,
          color: ColorHelper.colorBlack,
        ),
      ),
    );
  }

  Widget verifyOtpText() {
    return ButtonText(
      text: StringHelper.verifyWithOTP,
      height: DimensHelper.thirtyEight,
      textAlign: TextAlign.center,
      textStyle: GoogleFonts.nunito(
        textStyle: const TextStyle(
          fontSize: DimensHelper.twentyEight,
          color: ColorHelper.colorBlack,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget sentViaSMS() {
    return Container(
      margin: const EdgeInsets.only(
        top: DimensHelper.two,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ButtonText(
            text: "${StringHelper.sentViaSMS} ${widget.mobile}",
            textStyle: GoogleFonts.nunito(
              textStyle: const TextStyle(
                fontSize: DimensHelper.seventeen,
                color: ColorHelper.grey,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget otpFields() {
    return Container(
      margin: const EdgeInsets.only(top: DimensHelper.fiftyThree),
      child: StreamBuilder(
          stream: userBloc.otpStream,
          builder: (context, snapshot) {
            return OtpCode(
              onChangedValue: userBloc.otpChange,
              textEditingController: textOtpController,
              focusNode: focusNode,
            );
          }),
    );
  }

  Widget autoFillOtp() {
    return Visibility(
      maintainSize: true,
      maintainAnimation: true,
      maintainState: true,
      visible: fillOtp,
      child: Container(
        margin: const EdgeInsets.only(top: DimensHelper.fiftyTwo),
        child: RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: StringHelper.autoFillOtp,
                style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    fontSize: DimensHelper.fourteen,
                    color: ColorHelper.colorGrey,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              TextSpan(
                text: timerText,
                style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    fontSize: DimensHelper.fourteen,
                    color: ColorHelper.colorBlack,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget didnotReceiveCode() {
    return Visibility(
      child: Container(
        margin: const EdgeInsets.only(top: DimensHelper.twelve),
        height: DimensHelper.twentyThree,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: StringHelper.receiveCode,
                    style: GoogleFonts.nunito(
                      textStyle: const TextStyle(
                        fontSize: DimensHelper.seventeen,
                        color: ColorHelper.colorGrey,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            StreamBuilder(
              stream: userBloc.submitCheck,
              builder: (context, snapshot) {
                return GestureDetector(
                  onTap: (){
                    print("resend otp");
                    focusNode.unfocus();
                    startTimeout();
                    resendOtp();
                    progressBar.show(context);
                  },
                  child: Text(
                    StringHelper.resendOTP,
                    style: GoogleFonts.nunito(
                      textStyle: const TextStyle(
                        fontSize: DimensHelper.seventeen,
                        color: ColorHelper.colorBlack,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                );
              }
            ),
          ],
        ),
      ),
      maintainSize: true,
      maintainAnimation: true,
      maintainState: true,
      visible: resendVisible,
    );
    /*Container(
      margin: const EdgeInsets.only(top: DimensHelper.twelve),
      height: DimensHelper.twentyThree,
      child: RichText(
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: StringHelper.receiveCode,
              style: GoogleFonts.nunito(
                textStyle: const TextStyle(
                  fontSize: DimensHelper.seventeen,
                  color: ColorHelper.colorGrey,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            TextSpan(
              text: StringHelper.resendOTP,
              style: GoogleFonts.nunito(
                textStyle: const TextStyle(
                  fontSize: DimensHelper.seventeen,
                  color: ColorHelper.colorBlack,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );*/
  }

  Widget continueButton() {
    return Container(
      margin: const EdgeInsets.only(top: DimensHelper.sixtyFour),
      alignment: Alignment.center,
      child: StreamBuilder(
          stream: null,
          builder: (context, snapshot) {
            return GestureDetector(
              onTap: () {
                print("continue button pressed");
                verifyOtp();
                progressBar.show(context);
              },
              child: ButtonText(
                alignment: Alignment.center,
                height: DimensHelper.fourtyFour,
                width: DimensHelper.threeThirtyFive,
                text: StringHelper.btncontinue,
                textAlign: TextAlign.center,
                textStyle: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    fontSize: DimensHelper.twelve,
                    color: ColorHelper.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                boxDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(DimensHelper.ten),
                  color: ColorHelper.orange,
                ),
              ),
            );
          }),
    );
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
    userBloc.dispose();
    progressBar.hide();
  }

  void verifyOtp() {
    if (textOtpController.text.toString().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Enter OTP"),
        backgroundColor: ColorHelper.orange,
      ));
    } else if (textOtpController.text.toString().length < 4) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Enter valid OTP"),
        backgroundColor: ColorHelper.orange,
      ));
    } else {
      FocusScope.of(context).requestFocus(FocusNode());

      userBloc.verifyOtp(otp, widget.userRegister, widget.mobile).then((value) {
        print("user register" + widget.userRegister);
        print("mobile" + widget.mobile);
        print("otp" + otp);
        if (value.statusCode == 200) {
          setState(() {
            progressBar.hide();
          });
          var token = value.data!.token;
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => SignUp(widget.mobile,
                      textOtpController.text.toString(), token!)));
        }
      });
    }
  }

  void verifyToLogin() {
    Navigator.pop(
        context);
  }

  void resendOtp() {
   // startTimeout();
    resendVisible = false;
    fillOtp = true;
    print("user register" + widget.userRegister);
    print("mobile" + widget.mobile);

    userBloc.resendOtp(widget.mobile, widget.userRegister).then((value) {
      if (value.statusCode == 200) {
        setState(() {
          progressBar.hide();
        });
      }
    });
  }
}
