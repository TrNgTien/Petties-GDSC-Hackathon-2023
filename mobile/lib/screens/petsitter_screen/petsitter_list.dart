import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mobile/constants/color.dart';
import "package:mobile/constants/mock_data.dart";
import 'package:mobile/screens/petsitter_detail/profile_detail.dart';
import 'package:mobile/utils/helper.dart';
import 'package:mobile/widget/pet_wrap.dart';
import 'package:mobile/widget/rating.dart';

class ListBuilder extends StatefulWidget {
  const ListBuilder({
    super.key,
  });

  @override
  State<ListBuilder> createState() => _ListBuilderState();
}

class _ListBuilderState extends State<ListBuilder> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: userData.length,
        itemBuilder: (_, int index) {
          return InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => ProfileDetail(
                          userData: userData[index],
                        ),
                    fullscreenDialog: true));
              },
              child: ListTile(title: petSitterItems(userData, index, context)));
        });
  }
}

Widget petSitterItems(dynamic userData, int indexItem, BuildContext context) {
  final pets = userData[indexItem]['pets'].toString();

  return Center(
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        border: Border.all(width: 1, color: grayColor70),
      ),
      child: Row(
        children: [
          Container(
              margin: const EdgeInsets.all(10),
              width: widthScreen(context, 0.2),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  userData[indexItem]['userAvatar'],
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              )),
          Column(
            children: [
              SizedBox(
                width: widthScreen(context, 0.6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Rating(
                      rating: userData[indexItem]['rating'],
                      fontSizeOverride: 12,
                    ),
                    const Text(
                      "1.5km",
                      style: TextStyle(
                          color: grayColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w700),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: widthScreen(context, 0.6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${userData[indexItem]['userName']}',
                      style: const TextStyle(
                        fontSize: 13,
                        color: darkTextColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Text(
                        '${userData[indexItem]['description']}',
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        style: const TextStyle(
                          fontSize: 12,
                          color: grayColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    PetsWrap(pets: pets)
                  ],
                ),
              )
            ],
          )
        ],
      ),
    ),
  );
}
