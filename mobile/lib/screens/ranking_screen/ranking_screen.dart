import 'package:flutter/material.dart';
import 'package:mobile/constants/color.dart';

class RankingScreen extends StatelessWidget {
  const RankingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> listDomain = ["Trí nhớ", "Nhận thức", "Ngôn ngữ", "Toán học"];

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text("Chọn loại xếp hạng",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40,
                color: primaryColor,
                fontWeight: FontWeight.w700,
              )),
        ],
      ),
    );
  }
}
