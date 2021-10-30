import 'package:flutter/material.dart';

class NavCart extends StatefulWidget {
  const NavCart({Key? key}) : super(key: key);

  @override
  _NavCartState createState() => _NavCartState();
}

class _NavCartState extends State<NavCart> {
  @override
  Widget build(BuildContext context) {
    return  const SafeArea(child: Scaffold(
      body: Text("Cart Navigation"),
    ));
  }
}
