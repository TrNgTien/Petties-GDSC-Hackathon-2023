import 'package:flutter/material.dart';
import 'package:mobile/constants/color.dart';
import 'package:mobile/utils/helper.dart';

class About extends StatelessWidget {
  final String description;
  const About({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        width: widthScreen(context, 0.9),
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "About Me",
                  style: TextStyle(
                      color: darkTextColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
                Text(description,
                    style: const TextStyle(
                        color: grayColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500)),
              ],
            )));
  }
}
