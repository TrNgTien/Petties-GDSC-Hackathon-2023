import 'package:mobile/constants/color.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
