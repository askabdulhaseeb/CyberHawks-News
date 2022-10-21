// ignore_for_file: avoid_print

import 'dart:async';
import 'package:cybehawks/components/primary_button.dart';
import 'package:cybehawks/controller/auth.dart';
import 'package:cybehawks/pages/home.dart';
import 'package:cybehawks/pages/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class PinCodeVerificationScreen extends StatefulWidget {
  final String? phoneNumber;

  const PinCodeVerificationScreen(this.phoneNumber, {Key? key})
      : super(key: key);

  @override
  _PinCodeVerificationScreenState createState() =>
      _PinCodeVerificationScreenState();
}

class _PinCodeVerificationScreenState extends State<PinCodeVerificationScreen> {
  TextEditingController textEditingController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<AuthController>(context, listen: false)
          .verifyPhone(widget.phoneNumber!);
    });

    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();

    super.dispose();
  }

  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height / 5,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Phone Number Verification',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: RichText(
                text: TextSpan(
                  text: "Enter the code sent to ",
                  children: [
                    TextSpan(
                      text: "${widget.phoneNumber}",
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                  style: const TextStyle(color: Colors.black54, fontSize: 15),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Form(
              key: formKey,
              child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: PinCodeTextField(
                    appContext: context,
                    pastedTextStyle: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                    length: 6,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                      activeColor: Theme.of(context).primaryColor,
                      selectedColor: Theme.of(context).primaryColor,
                      inactiveFillColor: Colors.white,
                      inactiveColor: Theme.of(context).primaryColor,
                      errorBorderColor: Theme.of(context).primaryColor,
                      selectedFillColor: Colors.white,
                    ),
                    cursorColor: Theme.of(context).primaryColor,
                    animationDuration: const Duration(milliseconds: 300),
                    enableActiveFill: true,
                    errorAnimationController: errorController,
                    controller: textEditingController,
                    keyboardType: TextInputType.number,
                    onCompleted: (v) {
                      print("Completed");
                    },
                    onChanged: (value) {
                      print(value);
                      setState(() {
                        currentText = value;
                      });
                    },
                    beforeTextPaste: (text) {
                      print("Allowing to paste $text");
                      //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                      //but you can show anything you want here, like your pop up saying wrong paste format or etc
                      return true;
                    },
                  )),
            ),
            Text(
              hasError ? "*Incorrect code entered" : "",
              style: const TextStyle(
                  color: Colors.red, fontSize: 12, fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Didn't receive the code? ",
                  style: TextStyle(color: Colors.black54, fontSize: 15),
                ),
                TextButton(
                  onPressed: () async {
                    await Provider.of<AuthController>(context, listen: false)
                        .verifyPhone(widget.phoneNumber!);
                    snackBar("OTP resend!!");
                  },
                  child: Text(
                    "RESEND",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 14,
            ),
            Consumer<AuthController>(
              builder: (context, value, child) {
                return PrimaryButton(
                    text: 'Verify',
                    onPressed: () async {
                      formKey.currentState!.validate();
                      if (currentText.length != 6) {
                        errorController!.add(ErrorAnimationType.shake);
                        setState(() => hasError = true);
                      } else {
                        try {
                          await FirebaseAuth.instance
                              .signInWithCredential(
                            PhoneAuthProvider.credential(
                              verificationId: Provider.of<AuthController>(
                                      context,
                                      listen: false)
                                  .verificationCode,
                              smsCode: currentText,
                            ),
                          )
                              .then((value) async {
                            if (value.user != null) {
                              if (value.additionalUserInfo!.isNewUser) {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RegisterScreen()),
                                    (route) => false);
                              } else {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Home()),
                                    (route) => false);
                              }
                            }
                          });
                        } catch (e) {
                          errorController!.add(ErrorAnimationType.shake);
                          setState(() => hasError = true);
                        }
                      }
                    });
              },
            ),
          ],
        ),
      ),
    );
  }
}
