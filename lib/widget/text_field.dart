import 'package:flutter/material.dart';
import 'package:login/resource_helper/color.dart';
import 'package:login/resource_helper/dimens.dart';


class TextInputFields extends StatelessWidget {
  final TextInputAction? textInputAction;

  final TextEditingController? textEditingController;
  final double? height;
  final double? width;
  final TextStyle? textStyle;
  final Border? border;
  final TextInputType? textInputType;
  final ValueChanged<String>? onChangedValue;
  final FocusNode? focus;


  const TextInputFields({Key? key,
     this.textInputAction,
      this.textEditingController,
    this.height,
    this.width, this.textStyle, this.border, this.textInputType,  this.onChangedValue, this.focus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(DimensHelper.ten),
          border:border),
      child: TextField(
        textInputAction: textInputAction,
        textAlign: TextAlign.start,
        controller: textEditingController,
        keyboardType: textInputType,
        onChanged: onChangedValue,
        focusNode: focus,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(DimensHelper.ten),
            isDense: true,
            hintStyle:textStyle,
            border: InputBorder.none),
      ),
    );
  }
}
