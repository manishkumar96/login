import 'package:flutter/material.dart';

class NavSearch extends StatefulWidget {
  const NavSearch({Key? key}) : super(key: key);

  @override
  _NavSearchState createState() => _NavSearchState();
}

class _NavSearchState extends State<NavSearch> {
  @override
  Widget build(BuildContext context) {
    return  const SafeArea(child: Scaffold(
      body: Text("Search Navigation"),
    ));
  }
}
