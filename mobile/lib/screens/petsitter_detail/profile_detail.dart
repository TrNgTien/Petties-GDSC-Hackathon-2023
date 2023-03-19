import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile/constants/color.dart';
import 'package:mobile/constants/icons.dart';
import 'package:mobile/constants/images.dart';
import 'package:mobile/screens/chat_screen/chat_screen.dart';
import 'package:mobile/screens/petsitter_detail/widgets/about.dart';
import 'package:mobile/screens/petsitter_detail/widgets/reviews.dart';
import 'package:mobile/utils/helper.dart';
import 'package:mobile/widget/DraggableModal.dart';
import 'package:mobile/widget/pet_wrap.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';

class ProfileDetail extends StatefulWidget {
  final dynamic userData;
  const ProfileDetail({super.key, required this.userData});

  @override
  State<ProfileDetail> createState() => _ProfileDetailState();
}

class _ProfileDetailState extends State<ProfileDetail> {
  late List<String> _listTextTabToggle;
  @override
  void initState() {
    super.initState();
    _listTextTabToggle = [
      "Information",
      'Reviews (${widget.userData["reviews"]})'
    ];
  }

  var _tabTextIndexSelected = 0;
  @override
  Widget build(BuildContext context) {
    final pets = widget.userData["pets"].toString();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pet Sitter Profile"),
        elevation: 0,
        backgroundColor: backgroundAppBar,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: primaryColor,
          onPressed: () => Navigator.pop(context),
        ),
        titleTextStyle: const TextStyle(
          color: appbarColor,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
      body: SafeArea(
          child: Container(
              margin: const EdgeInsets.only(top: 10),
              child: SingleChildScrollView(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 80,
                    backgroundImage:
                        NetworkImage(widget.userData["userAvatar"]),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(eyeIcon),
                            const Text(
                              "5000",
                              style: TextStyle(
                                  color: grayColor,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        const SizedBox(width: 30),
                        Row(
                          children: [
                            SvgPicture.asset(heartIcon),
                            const Text(
                              "245",
                              style: TextStyle(
                                  color: grayColor,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    width: widthScreen(context, 0.9),
                    margin: const EdgeInsets.only(top: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Text(
                            "${widget.userData["userName"]}",
                            style: const TextStyle(
                                color: darkTextColor,
                                fontSize: 30,
                                fontWeight: FontWeight.w700),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: PetsWrap(pets: pets),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            width: widthScreen(context, 0.6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color: backgroundSocial,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: SvgPicture.asset(
                                        facebookIcon,
                                        color: Colors.black,
                                      ),
                                    )),
                                Container(
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color: backgroundSocial,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: SvgPicture.asset(
                                        igIcon,
                                        color: Colors.black,
                                      ),
                                    )),
                                Container(
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color: backgroundSocial,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: SvgPicture.asset(
                                        messengerIcon,
                                        color: Colors.black,
                                      ),
                                    )),
                                Container(
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color: backgroundSocial,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: SvgPicture.asset(
                                        linkedinIcon,
                                        color: Colors.black,
                                      ),
                                    )),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: grayBackgroundBtn,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: grayBackgroundBtn, width: 1)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 30),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Text(
                                          "Favorite",
                                          style: TextStyle(
                                              color: darkTextColor,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        SvgPicture.asset(singleHeartIcon)
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                ChatScreen(
                                                  userData: widget.userData,
                                                ),
                                            fullscreenDialog: true));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: backgroundConnect,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 40),
                                      child: Text(
                                        "Message",
                                        style: TextStyle(
                                            color: appbarColor,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 15),
                    child: FlutterToggleTab(
                      // width in percent
                      width: 90,
                      borderRadius: 30,
                      height: 35,
                      selectedIndex: _tabTextIndexSelected,
                      selectedBackgroundColors: const [
                        Colors.white,
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
                  _tabTextIndexSelected == 0
                      ? About(description: widget.userData["description"])
                      : Column(
                          children: [
                            Reviews(
                                description: widget.userData["description"]),
                            Reviews(
                                description: widget.userData["description"]),
                            Reviews(
                                description: widget.userData["description"]),
                          ],
                        ),
                  InkWell(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      width: widthScreen(context, 0.9),
                      decoration: BoxDecoration(
                        color: backgroundConnect,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 20),
                        child: Center(
                          child: InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (context) => DraggableSheet(
                                    child: Image.asset(
                                  dateImg,
                                  fit: BoxFit.fill,
                                )),
                              );
                            },
                            child: const Text(
                              "View Schedule",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )))),
    );
  }
}
