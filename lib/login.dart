// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:easy_push/easy_push.dart';
import 'package:flutter_application_3/otp.dart';
import 'package:hexcolor/hexcolor.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);
  TextEditingController controller = TextEditingController();

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
              'assets/1.png',
              fit: BoxFit.contain,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      color: HexColor('#F8BA1C'),
                      borderRadius: BorderRadius.circular(25)),
                  child: TextField(
                    showCursor: false,
                    decoration: InputDecoration(
                        hintStyle: TextStyle(fontSize: 12),
                        hintText: "Enter Mobile Number with Country Code",
                        border: InputBorder.none),
                    controller: controller,
                  ),
                ),
              ),
              RaisedButton(
                color: HexColor('#F8BA1C'),
                onPressed: () {
                  Push.to(
                      Otp(
                        phone: controller.text,
                      ),
                      context);
                },
                child: Text(
                  "Next",
                  style: TextStyle(
                    color: HexColor('#390999'),
                  ),
                ),
              ),
              SizedBox(
                height: 70,
              )
            ],
          ),
        ],
      ),
    );
  }
}
