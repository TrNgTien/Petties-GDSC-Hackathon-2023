import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile/constants/color.dart';
import 'package:mobile/constants/icons.dart';
import 'package:mobile/constants/images.dart';
import 'package:mobile/screens/petsitter_screen/petsitter_list.dart';
import 'package:mobile/widget/DraggableModal.dart';

class PetSitterScreen extends StatefulWidget {
  const PetSitterScreen({super.key});

  @override
  State<PetSitterScreen> createState() => _PetSitterScreenState();
}

class _PetSitterScreenState extends State<PetSitterScreen> {
  bool isSelectionMode = false;
  String selectedFilter = "Near Me";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Pet Sitters"),
          elevation: 0,
          backgroundColor: backgroundAppBar,
          automaticallyImplyLeading: false,
          titleTextStyle: const TextStyle(
            color: appbarColor,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10, left: 15, top: 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) => DraggableSheet(
                                child: Image.asset(
                              filterImg,
                              fit: BoxFit.fill,
                            )),
                          );
                        },
                        child: SvgPicture.asset(filterIcon)),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          selectedFilter = "Near Me";
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        margin: const EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                            color: selectedFilter == "Near Me"
                                ? blueBackgroundPet
                                : grayFilterColor,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: selectedFilter == "Near Me"
                                  ? blueBorderPet
                                  : grayFilterColor,
                            )),
                        child: Text(
                          "Near Me",
                          style: TextStyle(
                            color: selectedFilter == "Near Me"
                                ? blueBorderPet
                                : darkGrayColor,
                            fontSize: 12,
                            height: 1.6,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          selectedFilter = "Popular";
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        margin: const EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                            color: selectedFilter == "Popular"
                                ? blueBackgroundPet
                                : grayFilterColor,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: selectedFilter == "Popular"
                                  ? blueBorderPet
                                  : grayFilterColor,
                            )),
                        child: Text(
                          "Popular",
                          style: TextStyle(
                            color: selectedFilter == "Popular"
                                ? blueBorderPet
                                : darkGrayColor,
                            fontSize: 12,
                            height: 1.6,
                          ),
                        ),
                      ),
                    )
                  ]),
            ),
            const Expanded(child: ListBuilder())
          ],
        ));
  }
}
