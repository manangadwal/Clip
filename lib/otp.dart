// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:easy_push/easy_push.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/home.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:pinput/pinput.dart';

class Otp extends StatefulWidget {
  String? phone;
  Otp({this.phone});

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  String? verifiationCode;

  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    verify();
  }

  verify() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: widget.phone ?? '',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              Push.offAll(Home(), context);
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {},
        codeSent: (String verificationId, int? resendToken) {
          verifiationCode = verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          verifiationCode = verificationId;
        },
        timeout: Duration(seconds: 60));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#390999'),
      body: Stack(
        children: [
          Container(
            color: HexColor('#390999'),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              'assets/2.png',
              fit: BoxFit.contain,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 60,
              ),
              Text(
                "Enter the OTP",
                style: TextStyle(
                    color: HexColor('#F8BA1C'), fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Container(
                width: MediaQuery.of(context).size.width,
                color: HexColor('#F8BA1C').withOpacity(0.9),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Pinput(
                        length: 6,
                        controller: controller,
                        onCompleted: (pin) async {
                          await FirebaseAuth.instance
                              .signInWithCredential(
                                  PhoneAuthProvider.credential(
                                      verificationId: verifiationCode ?? '',
                                      smsCode: controller.text))
                              .then((value) {
                            if (value.user != null) {
                              Push.offAll(Home(), context);
                            }
                          });
                        },
                      ),
                    ),
                    RaisedButton(
                      color: HexColor('#390999'),
                      onPressed: () async {
                        await FirebaseAuth.instance
                            .signInWithCredential(PhoneAuthProvider.credential(
                                verificationId: verifiationCode ?? '',
                                smsCode: controller.text))
                            .then((value) {
                          if (value.user != null) {
                            Push.offAll(Home(), context);
                          }
                        });
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: HexColor('#F8BA1C'),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 100,
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
