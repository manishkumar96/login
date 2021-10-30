import 'package:flutter/material.dart';
import 'package:login/ui/home_page.dart';
import 'package:login/ui/mobile_verify.dart';
import 'package:login/ui/sign_up.dart';
import 'package:login/widget/pin_code_fields.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: HomePage(),
      ),
    );
  }
}
