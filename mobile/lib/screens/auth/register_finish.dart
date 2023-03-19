import 'package:flutter_svg/svg.dart';
import 'package:mobile/constants/images.dart';
import 'package:mobile/main.dart';
import 'package:mobile/screens/auth/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/constants/color.dart';
import 'package:mobile/screens/home_screen/home_screen.dart';
import 'package:mobile/utils/helper.dart';

class RegisterFinish extends StatefulWidget {
  const RegisterFinish({Key? key}) : super(key: key);

  @override
  State<RegisterFinish> createState() => _RegisterFinishState();
}

class _RegisterFinishState extends State<RegisterFinish> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBackground,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(registerImg),
            Container(
              margin: const EdgeInsets.only(top: 40, bottom: 15),
              child: const Text(
                "Register successfully!",
                style: TextStyle(
                  fontSize: 30,
                  color: darkTextColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Text(
              "Welcome, our new bestie!",
              style: TextStyle(
                color: grayColor,
                fontSize: 15,
                fontStyle: FontStyle.italic,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => const MyHomePage(
                              title: "Pet Sitters",
                            ),
                        fullscreenDialog: true));
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(color: cyanColorBtn, spreadRadius: 10),
                      ],
                    ),
                    height: 30,
                    width: widthScreen(context, 0.85),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Let's Go!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
