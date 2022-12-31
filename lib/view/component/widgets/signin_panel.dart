import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rive/rive.dart';
import 'package:rivedemo/view/screens/home_screen.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final formkey = GlobalKey<FormState>();
  late SMITrigger check;
  late SMITrigger error;
  late SMITrigger reset;
  late SMITrigger confetti;

  bool isLoading = false;
  bool isconfetti = false;
  StateMachineController getRiveController(Artboard artboard) {
    StateMachineController? stateMachineController =
        StateMachineController.fromArtboard(artboard, "State Machine 1");
    artboard.addController(stateMachineController!);
    return stateMachineController;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Form(
            key: formkey,
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
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Field cannot be empty";
                    } else {
                      return null;
                    }
                  },
                  onSaved: (email) {},
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
                  obscureText: true,
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
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Field cannot be empty";
                    } else {
                      return null;
                    }
                  },
                  onSaved: (password) {},
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
                    onPressed: () {
                      setState(() {
                        isLoading = true;
                        isconfetti = true;
                      });
                      Future.delayed(const Duration(seconds: 1), () {
                        if (formkey.currentState!.validate()) {
                          check.fire();
                          Future.delayed(
                            const Duration(seconds: 2),
                            () {
                              setState(() {
                                isLoading = false;
                              });
                              confetti.fire();
                            },
                          );
                          Future.delayed(const Duration(seconds: 3), () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) =>
                                        const HomeScreen())));
                          });
                        } else {
                          error.fire();
                          Future.delayed(const Duration(seconds: 2), () {
                            setState(() {
                              isLoading = false;
                              isconfetti = false;
                            });
                          });
                        }
                      });
                    },
                    icon: const Icon(CupertinoIcons.arrow_right),
                    label: const Text("Sign In ")),
              ],
            )),
        isLoading
            ? customPosition(
                child: RiveAnimation.asset(
                  "assets/RiveAssets/check.riv",
                  onInit: (artboard) {
                    StateMachineController controller =
                        getRiveController(artboard);
                    check = controller.findSMI("Check") as SMITrigger;
                    error = controller.findSMI("Error") as SMITrigger;
                    reset = controller.findSMI("Reset") as SMITrigger;
                  },
                ),
              )
            : const SizedBox(),
        isconfetti
            ? customPosition(
                child: Transform.scale(
                scale: 6,
                child: RiveAnimation.asset(
                  "assets/RiveAssets/confetti.riv",
                  onInit: (artboard) {
                    StateMachineController controller =
                        getRiveController(artboard);
                    confetti =
                        controller.findSMI("Trigger explosion") as SMITrigger;
                  },
                ),
              ))
            : const SizedBox(),
      ],
    );
  }
}

class customPosition extends StatelessWidget {
  const customPosition({Key? key, required this.child, this.size = 100.0})
      : super(key: key);
  final Widget child;
  final double size;
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Column(
        children: [
          const Spacer(),
          SizedBox(
            height: size,
            width: size,
            child: child,
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
