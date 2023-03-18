import 'package:mobile/screens/home_screen/home_screen.dart';
import 'package:mobile/screens/profile_screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:mobile/screens/ranking_screen/ranking_screen.dart';
import 'package:mobile/widget/bottom_nav.dart';
import 'package:mobile/widget/splash_screen.dart';
import 'package:mobile/constants/color.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: primaryBackground,
      ),
      home: const SplashScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0;
  List<Widget> widgetOptions = [
    const HomeScreen(),
    const RankingScreen(),
    const ProfileScreen()
  ];
  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 0,
        backgroundColor: primaryBackground,
        automaticallyImplyLeading: false,
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
      body: widgetOptions.elementAt(selectedIndex),
      bottomNavigationBar: BottomNav(
        colorBackground: primaryColor,
        colorSelectedItem: Colors.black,
        colorUnselectedItem: Colors.white,
        function: (int index) => _onItemTapped(index),
        selectedIndex: selectedIndex,
      ),
    );
  }
}
