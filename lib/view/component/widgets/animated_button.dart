import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:rivedemo/view/screens/auth_screen.dart';

class Gesture {
  static bool shouldAbsorb = false;
}

class AnimatedBtn extends StatefulWidget {
  const AnimatedBtn({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final RiveAnimationController controller;

  @override
  State<AnimatedBtn> createState() => _AnimatedBtnState();
}

class _AnimatedBtnState extends State<AnimatedBtn> {
  bool btnPressed = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: btnPressed
          ? null
          : () {
              widget.controller.isActive = true;
              Future.delayed(const Duration(milliseconds: 800), () {
                Dialogpannel(context);
                setState(() {
                  isLoginBtnPressed = true;
                  btnPressed = true;
                });
              });
            },
      child: SizedBox(
        height: 60,
        width: 260,
        child: Stack(children: [
          RiveAnimation.asset(
            "assets/RiveAssets/button.riv",
            controllers: [widget.controller],
          ),
          Positioned.fill(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(CupertinoIcons.arrow_right),
              SizedBox(
                width: 20,
              ),
              Text(
                "LOG IN ",
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ))
        ]),
      ),
    );
  }
}
