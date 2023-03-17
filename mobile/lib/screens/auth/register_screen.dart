import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:im_stepper/stepper.dart';
import 'package:mobile/constants/color.dart';
import 'package:mobile/main.dart';
import 'package:mobile/widget/logo_app.dart';
import "package:mobile/constants/icons.dart";

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  int activeStep = 0; // Initial step set to 0.

  // OPTIONAL: can be set directly.
  int dotCount = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: primaryBackground,
          automaticallyImplyLeading: false,
        ),
        body: SafeArea(
            child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  DotStepper(
                    // direction: Axis.vertical,
                    dotCount: dotCount,
                    dotRadius: 12,

                    /// THIS MUST BE SET. SEE HOW IT IS CHANGED IN NEXT/PREVIOUS BUTTONS AND JUMP BUTTONS.
                    activeStep: activeStep,
                    shape: Shape.stadium,
                    spacing: 10,
                    indicator: Indicator.shift,

                    /// TAPPING WILL NOT FUNCTION PROPERLY WITHOUT THIS PIECE OF CODE.
                    onDotTapped: (tappedDotIndex) {
                      setState(() {
                        activeStep = tappedDotIndex;
                      });
                    },

                    // DOT-STEPPER DECORATIONS
                    fixedDotDecoration: const FixedDotDecoration(
                      color: grayColor,
                    ),

                    indicatorDecoration: const IndicatorDecoration(
                      // style: PaintingStyle.stroke,
                      // strokeWidth: 8,
                      color: primaryColor,
                    ),
                    lineConnectorDecoration: const LineConnectorDecoration(
                      color: Colors.red,
                      strokeWidth: 10,
                    ),
                  ),

                  // Next and Previous buttons.
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [previousButton(), nextButton()],
                  ),
                  const Text("What’s your email?",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      )),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                        "Enter the email address you’d like to use to sign in to Petties",
                        style: TextStyle(
                          fontSize: 15,
                          color: grayColor,
                          fontWeight: FontWeight.w500,
                        )),
                  )
                ]),
              ]),
        )));
  }

  /// Generates jump steps for dotCount number of steps, and returns them in a row.
  Row steps() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(dotCount, (index) {
        return ElevatedButton(
          child: Text('${index + 1}'),
          onPressed: () {
            setState(() {
              activeStep = index;
            });
          },
        );
      }),
    );
  }

  /// Returns the next button widget.
  Widget nextButton() {
    return ElevatedButton(
      child: Text('Next'),
      onPressed: () {
        /// ACTIVE STEP MUST BE CHECKED FOR (dotCount - 1) AND NOT FOR dotCount To PREVENT Overflow ERROR.
        if (activeStep < dotCount - 1) {
          setState(() {
            activeStep++;
          });
        }
      },
    );
  }

  /// Returns the previous button widget.
  Widget previousButton() {
    return ElevatedButton(
      child: Text('Prev'),
      onPressed: () {
        // activeStep MUST BE GREATER THAN 0 TO PREVENT OVERFLOW.
        if (activeStep > 0) {
          setState(() {
            activeStep--;
          });
        }
      },
    );
  }
}
