import 'dart:convert' show json;
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:mobile/screens/auth/login_screen.dart';
import 'package:mobile/screens/auth/register_finish.dart';
import 'package:mobile/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/constants/color.dart';
import 'package:mobile/main.dart';
import "package:mobile/constants/icons.dart";

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _obscureText = true;
  final List<String> _listTextTabToggle = ["", ""];
  var _tabTextIndexSelected = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: primaryBackground,
        ),
        body: SafeArea(
            child: Center(
          child: Column(children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: FlutterToggleTab(
                // width in percent
                width: 90,
                borderRadius: 30,
                height: 10,
                selectedIndex: _tabTextIndexSelected,
                selectedBackgroundColors: const [
                  appbarColor,
                ],
                selectedTextStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
                unSelectedTextStyle: const TextStyle(
                    color: grayColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
                labels: _listTextTabToggle,
                selectedLabelIndex: (index) {
                  setState(() {
                    _tabTextIndexSelected = index;
                  });
                },
                isScroll: false,
              ),
            ),
            Container(
                margin: const EdgeInsets.only(top: 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: _tabTextIndexSelected == 0
                            ? const EdgeInsets.only(left: 10)
                            : const EdgeInsets.only(left: 0),
                        child: Text(
                            _tabTextIndexSelected == 0
                                ? "What’s your email?"
                                : "Set up your password",
                            style: const TextStyle(
                              fontSize: 30,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Container(
                          margin: _tabTextIndexSelected == 0
                              ? const EdgeInsets.only(left: 10)
                              : const EdgeInsets.only(left: 0),
                          child: Text(
                              _tabTextIndexSelected == 0
                                  ? "Enter the email address you’d like to use to sign in to Petties"
                                  : "Set a strong password for your account.",
                              style: const TextStyle(
                                fontSize: 13,
                                color: grayColor,
                                fontWeight: FontWeight.w500,
                              )),
                        ),
                      )
                    ])),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  if (_tabTextIndexSelected == 0)
                    SizedBox(
                      width: widthScreen(context, 0.9),
                      child: const TextField(
                        decoration: InputDecoration(
                            fillColor: backgroundInput,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              borderSide:
                                  BorderSide(width: 2, color: primaryColor),
                            ),
                            labelText: 'Email',
                            hintText: "Your email address"),
                      ),
                    ),
                  if (_tabTextIndexSelected == 1)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: SizedBox(
                          width: widthScreen(context, 0.9),
                          child: TextField(
                            obscureText: _obscureText,
                            decoration: InputDecoration(
                              fillColor: backgroundInput,
                              filled: true,
                              enabledBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                borderSide:
                                    BorderSide(width: 2, color: primaryColor),
                              ),
                              labelText: 'New password',
                              hintText: "Your password",
                              suffixIcon: IconButton(
                                icon: _obscureText
                                    ? const Icon(Icons.visibility)
                                    : const Icon(Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                              ),
                            ),
                          )),
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: SizedBox(
                        width: widthScreen(context, 0.9),
                        child: TextField(
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            fillColor: backgroundInput,
                            filled: true,
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              borderSide:
                                  BorderSide(width: 2, color: primaryColor),
                            ),
                            labelText: 'Re-enter your password',
                            hintText: "Re-enter Your password",
                            suffixIcon: IconButton(
                              icon: _obscureText
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                            ),
                          ),
                        )),
                  )
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Have an account?",
                      style: TextStyle(
                        fontSize: 13,
                        color: darkTextColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const LoginScreen(),
                              fullscreenDialog: true));
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Text(
                            "Sign in here",
                            style: TextStyle(
                              fontSize: 15,
                              color: primaryColor40,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ))
                  ],
                )),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: GestureDetector(
                      onTap: () {
                        if (_tabTextIndexSelected == 0) {
                          setState(() {
                            _tabTextIndexSelected = 1;
                          });
                        } else {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const RegisterFinish(),
                              fullscreenDialog: true));
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(color: cyanColorBtn, spreadRadius: 10),
                          ],
                        ),
                        height: 40,
                        width: widthScreen(context, 0.85),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "Continue",
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => const MyHomePage(
                                  title: "Petties",
                                ),
                            fullscreenDialog: true));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.transparent,
                          boxShadow: const [
                            BoxShadow(color: grayColor50, spreadRadius: 10),
                          ],
                        ),
                        height: 40,
                        width: widthScreen(context, 0.85),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                googleIcon,
                                height: 30,
                                width: 30,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                "Sign up with Google",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ]),
                      )),
                )
              ],
            ),
          ]),
        )));
  }
}
