import 'package:flutter/material.dart';
import 'package:mobile/constants/color.dart';

class PetsWrap extends StatelessWidget {
  final String pets;
  final double padding;
  final double margin;

  const PetsWrap({
    Key? key,
    required this.pets,
    this.padding = 12,
    this.margin = 8,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int colorIndex = 0;
    final removedBrackets = pets.substring(1, pets.length - 1);
    final parts = removedBrackets.split(', ');
    final List<Color> colors = [
      redBackgroundPet,
      blueBackgroundPet,
      greenBackgroundPet
    ];

    final petWidgets = parts.map((part) {
      final currentColorBackground = colors[colorIndex % colors.length];
      colorIndex++;
      return Container(
        padding: EdgeInsets.symmetric(
          horizontal: padding,
          vertical: padding / 3,
        ),
        margin: EdgeInsets.only(right: margin),
        decoration: BoxDecoration(
          color: currentColorBackground,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          part,
          style: TextStyle(
            color: currentColorBackground == redBackgroundPet
                ? redTextPet
                : currentColorBackground == blueBackgroundPet
                    ? blueBorderPet
                    : greenTextPet,
            fontSize: 12,
            height: 1.6,
          ),
        ),
      );
    }).toList();
    return Wrap(children: petWidgets);
  }
}
