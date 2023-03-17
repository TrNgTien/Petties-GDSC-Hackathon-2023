import 'package:mobile/constants/color.dart';
import 'package:flutter/material.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text("Home page",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 40,
              color: primaryColor,
              fontWeight: FontWeight.w700,
            )),
        SizedBox(
          height: 40,
        ),
      ],
    ));
  }
}
