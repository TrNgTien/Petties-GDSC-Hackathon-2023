import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import "package:mobile/constants/icons.dart";
import "package:mobile/constants/color.dart";

class BottomNav extends StatefulWidget {
  final Color? colorBackground;
  final Color? colorUnselectedItem;
  final Color? colorSelectedItem;
  final Function(int)? function;
  final int selectedIndex;
  const BottomNav(
      {super.key,
      required this.colorBackground,
      required this.colorUnselectedItem,
      required this.colorSelectedItem,
      required this.function,
      required this.selectedIndex});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      unselectedItemColor: grayColor,
      selectedItemColor: selectedNavColor,
      selectedFontSize: 14,
      unselectedFontSize: 13,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            homeIcon,
            height: 20,
            width: 20,
            color: widget.selectedIndex == 0 ? selectedNavColor : grayColor,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            petSitters,
            height: 20,
            width: 20,
            color: widget.selectedIndex == 1 ? selectedNavColor : grayColor,
          ),
          label: 'Pet Sitters',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.chat_bubble,
            color: widget.selectedIndex == 2 ? selectedNavColor : grayColor,
          ),
          label: 'Messages',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            profileIcon,
            height: 20,
            width: 20,
            color: widget.selectedIndex == 3 ? selectedNavColor : grayColor,
          ),
          label: 'Profile',
        ),
      ],
      currentIndex: widget.selectedIndex,
      onTap: (int index) => widget.function!(index),
    );
  }
}
