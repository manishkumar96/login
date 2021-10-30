import 'package:flutter/material.dart';
import 'package:login/resource_helper/color.dart';
import 'package:login/resource_helper/strings.dart';
import 'package:login/ui/nav_cart.dart';
import 'package:login/ui/nav_home.dart';
import 'package:login/ui/nav_search.dart';
import 'package:login/ui/nav_setting.dart';

class NavigationBottom extends StatefulWidget {
  const NavigationBottom({Key? key}) : super(key: key);

  @override
  _NavigationBottomState createState() => _NavigationBottomState();
}

class _NavigationBottomState extends State<NavigationBottom> {
  List<Widget> items = [
    const NavHome(),
    const NavSearch(),
    const NavCart(),
    const NavSetting(),
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IndexedStack(
          index: selectedIndex,
          children: items,
        ),
      ),
      bottomNavigationBar: showBottomNav(),
    );
  }

  Widget showBottomNav() {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.home), label: ""),
        BottomNavigationBarItem(
            icon: Icon(Icons.search), label: ""),
        BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart), label: ""),
        BottomNavigationBarItem(
            icon: Icon(Icons.settings), label: ""),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: ColorHelper.orange,
      unselectedItemColor: ColorHelper.colorGrey,
      onTap: iconPressed,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
      type: BottomNavigationBarType.fixed,
      iconSize: 30.0,
    );
  }

  void iconPressed(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}
