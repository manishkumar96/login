import 'package:flutter/material.dart';
import 'package:login/bloc/user_bloc.dart';
import 'package:login/resource_helper/color.dart';
import 'package:login/resource_helper/dimens.dart';
import 'package:login/resource_helper/strings.dart';
import 'package:login/ui/verify_otp.dart';
import 'package:login/widget/image.dart';
import 'package:login/widget/progress_bar.dart';
import 'package:login/widget/text_btn.dart';
import 'package:login/widget/text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late UserBloc userBloc;

  final phoneController = TextEditingController();

  String userRegister = 'UR', mobile = '';
  bool loading = false;
  late ProgressBar progressBar;
  FocusNode focusNode =  FocusNode();

  @override
  void initState() {
    super.initState();
    userBloc = UserBloc();
    progressBar = ProgressBar();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: DimensHelper.twenty),
              child: GestureDetector(
                onTap: () {
                  print(StringHelper.skip);
                },
                child: const Align(
                  alignment: Alignment.center,
                  child: ButtonText(
                    text: StringHelper.skip,
                    height: DimensHelper.sixteen,
                    width: DimensHelper.twentySeven,
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: DimensHelper.twelve,
                      color: ColorHelper.colorBlack,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: ColorHelper.background,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(DimensHelper.twenty),
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            child: const ImageComponent(
                                image: "assets/images/login.png",
                                imgHeight: DimensHelper.oneThirty,
                                imgWidth: DimensHelper.oneZeroSeven),
                          ),
                          Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(top: DimensHelper.fifty),
                            child: const ButtonText(
                              height: DimensHelper.thirtyEight,
                              width: DimensHelper.seventyThree,
                              text: StringHelper.login,
                              textStyle: TextStyle(
                                fontSize: DimensHelper.twentyEight,
                                fontWeight: FontWeight.w700,
                                color: ColorHelper.colorBlack,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: const ButtonText(
                              text: StringHelper.happyToHaveYou,
                              width: DimensHelper.oneNinetyTwo,
                              height: DimensHelper.twentyThree,
                              textStyle: TextStyle(
                                fontSize: DimensHelper.seventeen,
                                fontWeight: FontWeight.normal,
                                color: ColorHelper.colorGrey,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            margin:
                                const EdgeInsets.only(top: DimensHelper.thirtyThree),
                            child: const ButtonText(
                              text: StringHelper.phoneNumber,
                              textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: DimensHelper.fourteen,
                                color: ColorHelper.colorGrey,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              margin: const EdgeInsets.only(top: DimensHelper.five),
                              child: StreamBuilder(
                                  stream: userBloc.numberStream,
                                  builder: (context, snapshot) {
                                    return TextInputFields(
                                      height: DimensHelper.fourtyFour,
                                      textInputAction: TextInputAction.done,
                                      focus: focusNode,
                                      width: DimensHelper.threeThirtyFive,
                                      textInputType: TextInputType.number,
                                      onChangedValue: userBloc.numberChanged,
                                      textEditingController: phoneController,
                                      border: Border.all(
                                          width: DimensHelper.one,
                                          color: ColorHelper.colorWhitetextField,
                                          style: BorderStyle.solid),
                                    );
                                  }),
                            ),
                          ),
                          StreamBuilder(
                              stream: userBloc.submitCheck,
                              builder: (context, snapshot) {
                                return GestureDetector(
                                  onTap: () {
                                    print(StringHelper.btncontinue);
                                    showProgressBar();
                                    focusNode.unfocus();
                                    setState(() {
                                      loading = !loading;
                                    });
                                    phoneVerify();
                                  },
                                  child: Center(
                                    child: Container(
                                      alignment: Alignment.center,
                                      margin: const EdgeInsets.only(
                                          top: DimensHelper.twentySix),
                                      child: ButtonText(
                                        alignment: Alignment.center,
                                        textAlign: TextAlign.center,
                                        textStyle: const TextStyle(
                                            fontSize: DimensHelper.twelve,
                                            fontWeight: FontWeight.bold,
                                            color: ColorHelper.white),
                                        text: StringHelper.btncontinue,
                                        height: DimensHelper.fourtyFour,
                                        width: DimensHelper.threeThirtyFive,
                                        boxDecoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(DimensHelper.ten),
                                          color: ColorHelper.orange,
                                          border: Border.all(
                                            width: DimensHelper.one,
                                            color: ColorHelper.orange,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ],
                      ),
                    ),
                  ),
                  /*:  SizedBox(
                        height:  MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: const Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                      ),*/
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    userBloc.dispose();
    progressBar.hide();
  }

  void phoneVerify() {
    if (phoneController.text.toString().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Enter valid number"),
        backgroundColor: ColorHelper.orange,
      ));
    } else if (phoneController.text.toString().length < 7) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Enter Valid number"),
        backgroundColor: ColorHelper.orange,
      ));
    }  
    else {
      userBloc.verifyNumber(mobile, userRegister).then(
        (value) {
          if (value.statusCode == 200) {
            setState(() {
              loading = false;
              progressBar.hide();
            });
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => VerifyOtp(
                  phoneController.text.toString(),
                  userRegister.toString(),
                ),
              ),
            );
          }
        },
      );
    }
  }

  void showProgressBar() {
    progressBar.show(context);
  }
}
