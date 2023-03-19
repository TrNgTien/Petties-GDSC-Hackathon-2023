import 'package:flutter/material.dart';
import 'package:mobile/constants/color.dart';
import 'package:mobile/utils/helper.dart';
import 'package:mobile/widget/rating.dart';

class Reviews extends StatelessWidget {
  final String description;
  const Reviews({super.key, required this.description});

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
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text(
                        "Tien Tran",
                        style: TextStyle(
                            color: darkTextColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      ),
                      Rating(rating: 5, fontSizeOverride: 15)
                    ],
                  ),
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
