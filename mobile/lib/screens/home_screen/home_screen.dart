import 'package:mobile/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:mobile/constants/images.dart';
import 'package:mobile/utils/helper.dart';
import 'package:mobile/widget/DraggableModal.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Image.asset(
          homeImg,
          fit: BoxFit.fitWidth,
        ),
      ),
    ));
  }
}
