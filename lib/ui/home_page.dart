import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/resource_helper/color.dart';
import 'package:login/resource_helper/dimens.dart';
import 'package:login/resource_helper/strings.dart';
import 'package:login/widget/bottom_navigation.dart';
import 'package:login/widget/text_btn.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appbar(),
        body: Container(
          margin: const EdgeInsets.all(DimensHelper.twenty),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const <Widget>[],
          ),
        ),
        bottomNavigationBar: const NavigationBottom(),
      ),
    );
  }

  PreferredSizeWidget appbar() {
    return AppBar(
      backgroundColor: ColorHelper.background,
      elevation: 0,
      actions:  <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 20.0,top: 20.0),
          child: ButtonText(text:StringHelper.login,
          height: DimensHelper.sixteen,
          textStyle: GoogleFonts.nunito(
            textStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: DimensHelper.seventeen,
              color: ColorHelper.login
            )
          )),
        )
      ],
    );
  }
}
