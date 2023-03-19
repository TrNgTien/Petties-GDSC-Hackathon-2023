import 'dart:convert' show json;
import 'package:mobile/screens/auth/register_screen.dart';
import 'package:mobile/utils/helper.dart';
import 'package:mobile/widget/logo_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/constants/color.dart';
import 'package:mobile/main.dart';
import "package:mobile/constants/icons.dart";

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
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
            const LogoApp(),
            Container(
                margin: const EdgeInsets.only(top: 65),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("Welcome back!",
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          )),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                            "Enter your information to sign in with Petties",
                            style: TextStyle(
                              fontSize: 15,
                              color: grayColor,
                              fontWeight: FontWeight.w500,
                            )),
                      )
                    ])),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  SizedBox(
                    width: widthScreen(context, 0.9),
                    child: const TextField(
                      decoration: InputDecoration(
                          fillColor: backgroundInput,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            borderSide:
                                BorderSide(width: 2, color: primaryColor),
                          ),
                          labelText: 'Email',
                          hintText: "Your email address"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
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
                            labelText: 'Password',
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
                      "Don’t have an account?",
                      style: TextStyle(
                        fontSize: 13,
                        color: darkTextColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const RegisterScreen(),
                              fullscreenDialog: true);
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Text(
                            "Sign Up?",
                            style: TextStyle(
                              fontSize: 13,
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
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => const MyHomePage(
                                  title: "Pet Sitters",
                                ),
                            fullscreenDialog: true));
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
                              "Login",
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
                                "Sign in with Google",
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
