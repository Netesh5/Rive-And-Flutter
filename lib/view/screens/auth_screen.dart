import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rive/rive.dart';

bool isLoginBtnPressed = false;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late RiveAnimationController controller;

  @override
  void initState() {
    controller = OneShotAnimation("active", autoplay: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            width: MediaQuery.of(context).size.width * 1.7,
            left: 30,
            bottom: 50,
            child: Image.asset("assets/Backgrounds/Spline.png"),
          ),
          const RiveAnimation.asset("assets/RiveAssets/shapes.riv"),
          Positioned.fill(
            child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 35, sigmaY: 35),
                child: const SizedBox()),
          ),
          SafeArea(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: Column(
              children: [
                const Text(
                  "Rive\nDemo App",
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      height: 1.2),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "This is the demo app to implement Rive animation in flutter. This is the demo app to implement Rive animation in flutter",
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.2,
                  ),
                ),
                const Spacer(),
                AnimatedBtn(controller: controller),
              ],
            ),
          )),
        ],
      ),
    );
  }
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
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.controller.isActive = true;
        Future.delayed(const Duration(milliseconds: 800), () {
          Dialogpannel(context);
          setState(() {
            isLoginBtnPressed = true;
          });
        });
      },
      child: AnimatedPositioned(
        duration: const Duration(milliseconds: 400),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        top: isLoginBtnPressed ? -50 : 0,
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
      ),
    );
  }

  Future<Object?> Dialogpannel(BuildContext context) {
    return showGeneralDialog(
        barrierDismissible: true,
        barrierLabel: "Sign In",
        context: context,
        transitionDuration: const Duration(milliseconds: 400),
        transitionBuilder: (context, animation, secondaryAnimation, child) {
          Tween<Offset> tween;
          tween = Tween(begin: const Offset(0, -1), end: Offset.zero);
          return SlideTransition(
            position: tween.animate(
                CurvedAnimation(parent: animation, curve: Curves.easeInOut)),
            child: child,
          );
        },
        pageBuilder: ((context, animation, secondaryAnimation) {
          return Center(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.height * 0.42,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(235, 255, 255, 255),
                  borderRadius: BorderRadius.circular(30)),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Column(
                        children: [
                          const Text(
                            "Sign In ",
                            style:
                                TextStyle(fontFamily: "Poppins", fontSize: 30),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                              "Sign in to Explorer the world of Animation with Rive. ",
                              style: TextStyle(fontSize: 16)),
                          const SignInForm(),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: const [
                              Expanded(child: Divider()),
                              Text(" OR "),
                              Expanded(child: Divider())
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Sign in with Apple or Google",
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: SvgPicture.asset(
                                  "assets/icons/apple_box.svg",
                                  height: 64,
                                  width: 64,
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: SvgPicture.asset(
                                  "assets/icons/google_box.svg",
                                  height: 64,
                                  width: 64,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      const Positioned(
                        left: 0,
                        right: 0,
                        bottom: -50,
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.close,
                            color: Colors.black,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        })).then((value) {
      setState(() {
        isLoginBtnPressed = false;
      });
    });
  }
}

class SignInForm extends StatelessWidget {
  const SignInForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        const Text(
          "Email",
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          decoration: InputDecoration(
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SvgPicture.asset("assets/icons/email.svg"),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(12),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(12),
              )),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          "Password",
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          decoration: InputDecoration(
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SvgPicture.asset("assets/icons/password.svg"),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(12),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(12),
              )),
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 56),
                backgroundColor: const Color(0xFFF77D8E),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(25),
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25)))),
            onPressed: () {},
            icon: const Icon(CupertinoIcons.arrow_right),
            label: const Text("Sign In "))
      ],
    ));
  }
}
