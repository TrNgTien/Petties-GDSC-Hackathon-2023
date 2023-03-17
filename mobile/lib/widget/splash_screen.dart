import 'package:mobile/screens/auth/login_screen.dart';
import 'package:mobile/widget/logo_app.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/constants/color.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(
      seconds: 2,
    )).then((value) {
      Navigator.of(context).pushReplacement(
          CupertinoPageRoute(builder: (ctx) => const LoginScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBackground,
      body: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // LogoApp(),
            Container(
              margin: const EdgeInsets.only(
                top: 0,
              ),
              child: const Text(
                "Petties",
                style: TextStyle(
                  fontSize: 40,
                  color: darkTextColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            const SpinKitFadingCube(
              color: primaryColor,
              size: 50.0,
            ),
          ],
        ),
      ),
    );
  }
}
