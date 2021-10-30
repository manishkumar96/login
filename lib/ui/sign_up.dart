import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/bloc/user_bloc.dart';
import 'package:login/resource_helper/color.dart';
import 'package:login/resource_helper/dimens.dart';
import 'package:login/resource_helper/strings.dart';
import 'package:login/ui/home_page.dart';
import 'package:login/widget/image.dart';
import 'package:login/widget/text_btn.dart';
import 'package:login/widget/text_field.dart';

class SignUp extends StatefulWidget {
  final String mobile;
  final String otp;
  final int token;

  const SignUp(this.mobile, this.otp, this.token, {Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool valueCheck = false;

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final referralController = TextEditingController();

  late UserBloc userBloc;

  String firstName = '', lastName = '', email = '', referral = '';

  @override
  void initState() {
    super.initState();
    userBloc = UserBloc();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: ColorHelper.background,
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              print("signup back button");
              personalToOtp();
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: ColorHelper.colorBlack,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
              color: ColorHelper.background,
            ),
            child: Padding(
              padding: const EdgeInsets.all(DimensHelper.twenty),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: DimensHelper.thirtyFive),
                    child: const ImageComponent(
                      image: "assets/images/login.png",
                      imgWidth: DimensHelper.oneThirty,
                      imgHeight: DimensHelper.oneZeroSeven,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: DimensHelper.fifty),
                    child: ButtonText(
                        height: DimensHelper.thirtyEight,
                        width: DimensHelper.twoOneFive,
                        text: StringHelper.personalDetails,
                        textAlign: TextAlign.center,
                        textStyle: GoogleFonts.nunito(
                          textStyle: const TextStyle(
                            fontSize: DimensHelper.twentyEight,
                            fontWeight: FontWeight.w700,
                            color: ColorHelper.colorBlack,
                          ),
                        )),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: ButtonText(
                      textAlign: TextAlign.center,
                      height: DimensHelper.twentyThree,
                      width: DimensHelper.oneNinetyTwo,
                      text: StringHelper.happyToHaveYou,
                      textStyle: GoogleFonts.nunito(
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.w400,
                            color: ColorHelper.colorGrey),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin:
                        const EdgeInsets.only(top: DimensHelper.fourtyThree),
                    child: ButtonText(
                        textAlign: TextAlign.start,
                        text: StringHelper.firstName,
                        height: DimensHelper.nineteen,
                        // width: DimensHelper.seventyOne,
                        textStyle: GoogleFonts.nunito(
                          textStyle: const TextStyle(
                              fontSize: DimensHelper.fourteen,
                              fontWeight: FontWeight.w700,
                              color: ColorHelper.colorGrey),
                        )),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: DimensHelper.five),
                    child: StreamBuilder(
                        stream: userBloc.firstnameStream,
                        builder: (context, snapshot) {
                          return TextInputFields(
                            height: DimensHelper.fourtyFour,
                            width: DimensHelper.threeThirtyFive,
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.name,
                            onChangedValue: userBloc.firstnameChange,
                            textEditingController: firstNameController,
                            border: Border.all(
                              width: DimensHelper.one,
                              color: ColorHelper.colorWhitetextField,
                              style: BorderStyle.solid,
                            ),
                          );
                        }),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(top: DimensHelper.seventeen),
                    child: ButtonText(
                      textAlign: TextAlign.start,
                      text: StringHelper.lastName,
                      height: DimensHelper.nineteen,
                      width: DimensHelper.seventyOne,
                      textStyle: GoogleFonts.nunito(
                        textStyle: const TextStyle(
                            fontSize: DimensHelper.fourteen,
                            fontWeight: FontWeight.w700,
                            color: ColorHelper.colorGrey),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: DimensHelper.five),
                    child: StreamBuilder(
                        stream: userBloc.lastNameStream,
                        builder: (context, snapshot) {
                          return TextInputFields(
                            height: DimensHelper.fourtyFour,
                            width: DimensHelper.threeThirtyFive,
                            textInputType: TextInputType.name,
                            onChangedValue: userBloc.lastNameChanged,
                            textInputAction: TextInputAction.next,
                            textEditingController: lastNameController,
                            border: Border.all(
                              width: DimensHelper.one,
                              color: ColorHelper.colorWhitetextField,
                              style: BorderStyle.solid,
                            ),
                          );
                        }),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(top: DimensHelper.seventeen),
                    child: ButtonText(
                      textAlign: TextAlign.start,
                      text: StringHelper.emailOptional,
                      height: DimensHelper.nineteen,
                      width: DimensHelper.oneZeroOne,
                      textStyle: GoogleFonts.nunito(
                        textStyle: const TextStyle(
                            fontSize: DimensHelper.fourteen,
                            fontWeight: FontWeight.w700,
                            color: ColorHelper.colorGrey),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: DimensHelper.five),
                    child: StreamBuilder(
                        stream: userBloc.emailStream,
                        builder: (context, snapshot) {
                          return TextInputFields(
                            height: DimensHelper.fourtyFour,
                            width: DimensHelper.threeThirtyFive,
                            onChangedValue: userBloc.emailChanged,
                            textInputType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            textEditingController: emailController,
                            border: Border.all(
                              width: DimensHelper.one,
                              color: ColorHelper.colorWhitetextField,
                              style: BorderStyle.solid,
                            ),
                          );
                        }),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(top: DimensHelper.seventeen),
                    child: ButtonText(
                      textAlign: TextAlign.start,
                      text: StringHelper.referalOptional,
                      height: DimensHelper.nineteen,
                      width: DimensHelper.oneFourNine,
                      textStyle: GoogleFonts.nunito(
                        textStyle: const TextStyle(
                            fontSize: DimensHelper.fourteen,
                            fontWeight: FontWeight.w700,
                            color: ColorHelper.colorGrey),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: DimensHelper.five),
                    child: StreamBuilder(
                        stream: userBloc.referralStream,
                        builder: (context, snapshot) {
                          return TextInputFields(
                            height: DimensHelper.fourtyFour,
                            width: DimensHelper.threeThirtyFive,
                            onChangedValue: userBloc.referralChanged,
                            textInputAction: TextInputAction.next,
                            textEditingController: referralController,
                            border: Border.all(
                              width: DimensHelper.one,
                              color: ColorHelper.colorWhitetextField,
                              style: BorderStyle.solid,
                            ),
                          );
                        }),
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            valueCheck = !valueCheck;
                          });
                        },
                        child: Container(
                          height: 22,
                          width: 22,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(DimensHelper.five),
                            border: Border.all(
                                width: DimensHelper.one,
                                color: ColorHelper.grey,
                                style: BorderStyle.solid),
                          ),
                          child: valueCheck
                              ? const Icon(
                                  Icons.check,
                                  size: 15,
                                  color: ColorHelper.orange,
                                )
                              : Container(),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            top: DimensHelper.twentyNine,
                            left: DimensHelper.ten),
                        height: DimensHelper.fiftyNine,
                        child: RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: StringHelper.byContinuing,
                                style: GoogleFonts.nunito(
                                  textStyle: const TextStyle(
                                      fontSize: DimensHelper.fourteen,
                                      color: ColorHelper.colorGrey,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              TextSpan(
                                text: StringHelper.termsAndCondition,
                                style: GoogleFonts.nunito(
                                  textStyle: const TextStyle(
                                    fontSize: DimensHelper.fourteen,
                                    color: ColorHelper.colorBlack,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              TextSpan(
                                text: StringHelper.and,
                                style: GoogleFonts.nunito(
                                  textStyle: const TextStyle(
                                      fontSize: DimensHelper.fourteen,
                                      fontWeight: FontWeight.w400,
                                      color: ColorHelper.colorGrey),
                                ),
                              ),
                              TextSpan(
                                  text: StringHelper.privacyPolicy,
                                  style: GoogleFonts.nunito(
                                    textStyle: const TextStyle(
                                      fontSize: DimensHelper.fourteen,
                                      color: ColorHelper.colorBlack,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(
                        top: DimensHelper.two, bottom: DimensHelper.nine),
                    child: StreamBuilder(
                        stream: userBloc.userDetailsCheck,
                        builder: (context, snapshot) {
                          return GestureDetector(
                            onTap: () {
                              print("signup pressed");
                              signUp();
                            },
                            child: ButtonText(
                              alignment: Alignment.center,
                              textAlign: TextAlign.center,
                              text: StringHelper.save,
                              height: DimensHelper.forty,
                              width: DimensHelper.threeThirtyFive,
                              textStyle: GoogleFonts.nunito(
                                textStyle: const TextStyle(
                                    fontSize: DimensHelper.twelve,
                                    color: ColorHelper.white,
                                    fontWeight: FontWeight.w700),
                              ),
                              boxDecoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(DimensHelper.ten),
                                color: ColorHelper.orange,
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signUp() {
    if (firstNameController.text.toString().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Enter First Name"),
        backgroundColor: ColorHelper.orange,
      ));
    } else if (lastNameController.text.toString().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Enter Last Name"),
        backgroundColor: ColorHelper.orange,
      ));
    } else if (emailController.text.toString().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("please agree terms and conditions"),
        backgroundColor: ColorHelper.orange,
      ));
    } else if (valueCheck == false) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("please agree terms and conditions"),
        backgroundColor: ColorHelper.orange,
      ));
    } else {
      userBloc
          .registerUser(firstName, lastName, email, referral, widget.otp,
              widget.mobile, widget.token)
          .then((value) {
        if (value.statusCode == 200) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => const HomePage()));
        }
      });
    }
  }

  void personalToOtp() {
    Navigator.pop(context);
  }
}
