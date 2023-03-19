import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile/constants/icons.dart';

class Rating extends StatelessWidget {
  const Rating(
      {super.key, required this.rating, required this.fontSizeOverride});
  final int rating;
  final double fontSizeOverride;

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "$rating",
            style: TextStyle(
                color: Colors.black,
                fontSize: fontSizeOverride,
                fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            width: 2,
          ),
          SvgPicture.asset(
            starIcon,
            height: 14,
            width: 14,
          )
        ]);
  }
}
