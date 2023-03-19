import 'package:mobile/screens/chat_screen/message_list.dart';
import 'package:mobile/screens/home_screen/home_screen.dart';
import 'package:mobile/screens/profile_screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:mobile/screens/petsitter_screen/petsitter_screen.dart';
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
    const PetSitterScreen(),
    const MessageList(),
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
