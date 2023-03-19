import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile/constants/color.dart';
import 'package:mobile/constants/icons.dart';
import 'package:mobile/constants/mock_data.dart';
import 'package:mobile/widget/pet_wrap.dart';

class ProfileDetail extends StatefulWidget {
  final dynamic userData;
  const ProfileDetail({super.key, required this.userData});

  @override
  State<ProfileDetail> createState() => _ProfileDetailState();
}

class _ProfileDetailState extends State<ProfileDetail> {
  @override
  Widget build(BuildContext context) {
    final pets = widget.userData["pets"].toString();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pet Sitter Profile"),
        elevation: 0,
        backgroundColor: primaryBackground,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () => Navigator.pop(context),
        ),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
      body: SafeArea(
          child: Column(
        children: [
          CircleAvatar(
            radius: 80,
            backgroundImage: NetworkImage(widget.userData["userAvatar"]),
          ),
          Text("${widget.userData["userName"]}"),
          Text("${widget.userData["description"]}"),
          PetsWrap(pets: pets),
          Row(
            children: [
              SvgPicture.asset(
                facebookIcon,
                color: Colors.black,
              ),
              SvgPicture.asset(
                igIcon,
                color: Colors.black,
              ),
              SvgPicture.asset(
                facebookIcon,
                color: Colors.black,
              ),
              SvgPicture.asset(
                facebookIcon,
                color: Colors.black,
              ),
            ],
          )
        ],
      )),
    );
  }
}
