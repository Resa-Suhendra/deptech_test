import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:deptech_test/ui/constant/constant.dart';
import 'package:deptech_test/ui/pages/admin/admin_profile_page.dart';
import 'package:deptech_test/ui/pages/notes/list_note_page.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _currentIndex = 0;
  List<Widget> menuList = [
    const ListNotesPage(),
    const AdminProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _bottomNavBar(),
      body: menuList[_currentIndex],
    );
  }

  Widget _bottomNavBar() {
    return CustomNavigationBar(
      iconSize: 25,
      selectedColor: primaryColor,
      unSelectedColor: Colors.grey,
      strokeColor: primaryColor,
      backgroundColor: Colors.white,
      borderRadius: const Radius.circular(15),
      currentIndex: _currentIndex,
      onTap: (index) {
        if (_currentIndex != index) {
          setState(() {
            _currentIndex = index;
          });
        }
      },
      items: [
        CustomNavigationBarItem(
          icon: const Icon(Icons.home),
          badgeCount: 0,
          showBadge: false,
          title: Text(
            "Home",
            style: styleSubtitle,
          ),
        ),
        CustomNavigationBarItem(
          icon: const Icon(Icons.person),
          badgeCount: 0,
          showBadge: false,
          title: Text(
            "Profile",
            style: styleSubtitle,
          ),
        ),
      ],
    );
  }
}
