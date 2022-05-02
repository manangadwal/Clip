// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, avoid_single_cascade_in_expression_statements, unused_field, prefer_final_fields

import 'dart:ui';

import 'package:easy_push/easy_push.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/HomePageTabs/AddTab/addTab.dart';
import 'package:flutter_application_3/HomePageTabs/HomeTab/hometab.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'login.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    HomeTab(),
    AddTab(),
    Column(
      children: [
        Container(height: 200, width: 200, child: Image.asset('assets/8.jpg')),
        Text(
          'Bad Bitxh',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
          ),
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: HexColor('#390999'),
          appBar: AppBar(
            centerTitle: false,
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            title: Text(
              "Clip",
              style: GoogleFonts.domine(
                  textStyle: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: GestureDetector(
                  onTap: () {
                    AwesomeDialog(
                      btnCancelColor: HexColor('#390999'),
                      btnOkColor: HexColor('#F8BA1C'),
                      context: context,
                      dialogType: DialogType.INFO,
                      animType: AnimType.BOTTOMSLIDE,
                      desc: 'Are you sure you want to Logout?',
                      btnCancelOnPress: () {},
                      btnOkOnPress: () async {
                        await FirebaseAuth.instance.signOut();
                        Push.offAll(Login(), context);
                      },
                    )..show();
                  },
                  child: Icon(
                    Icons.account_circle,
                    size: 29,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
          bottomNavigationBar: GNav(
            backgroundColor: Colors.black,
            onTabChange: (idx) {
              _selectedIndex = idx;
              setState(() {});
            },
            selectedIndex: _selectedIndex,
            activeColor: HexColor('#F8BA1C'),
            color: Colors.white,
            style: GnavStyle.google,
            iconSize: 19,
            textSize: 15,
            tabs: [
              GButton(
                icon: Icons.home,
                text: '  Home',
              ),
              GButton(icon: Icons.add_a_photo),
              GButton(
                icon: Icons.account_box_sharp,
                text: '  My videos',
              ),
            ],
          ),
          body: Container(
            alignment: Alignment.center,
            child: _widgetOptions.elementAt(_selectedIndex),
          )),
    );
  }
}
