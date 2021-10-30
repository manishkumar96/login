import 'package:flutter/material.dart';
import 'package:login/resource_helper/color.dart';
import 'package:login/resource_helper/dimens.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

class OtpCode extends StatelessWidget {
  final TextEditingController? textEditingController;
  final ValueChanged<String>? onChangedValue;
  final FocusNode? focusNode;

  const OtpCode({Key? key, this.textEditingController, this.onChangedValue, this.focusNode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      focusNode: focusNode,
      autofocus: true,
      controller: textEditingController,
      maxLength: 4,
      highlight: false,
      hasUnderline: false,
      pinBoxHeight: DimensHelper.fourtyFour,
      pinBoxWidth: DimensHelper.thirtySix,
      onTextChanged: onChangedValue,
      defaultBorderColor: ColorHelper.otpBorderColor,
      pinBoxRadius: DimensHelper.ten,
      hasTextBorderColor: ColorHelper.otpBorderColor,
    );
  }
}
