import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile/constants/icons.dart';
import 'package:mobile/constants/mock_data.dart';

class Rating extends StatelessWidget {
  const Rating({super.key, required this.indexItem});
  final indexItem;

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '${userData[indexItem]['reviews']}',
            style: const TextStyle(
                color: Colors.black, fontSize: 12, fontWeight: FontWeight.w700),
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
