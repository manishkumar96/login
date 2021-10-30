import 'package:flutter/material.dart';

class NavSetting extends StatefulWidget {
  const NavSetting({Key? key}) : super(key: key);

  @override
  _NavSettingState createState() => _NavSettingState();
}

class _NavSettingState extends State<NavSetting> {
  @override
  Widget build(BuildContext context) {
    return  const SafeArea(child: Scaffold(
      body: Text("Setting Navigation"),
    ));
  }
}
