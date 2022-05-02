// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class AddTab extends StatefulWidget {
  @override
  State<AddTab> createState() => _AddTabState();
}

class _AddTabState extends State<AddTab> {
  String? uid;
  TextEditingController titleController = TextEditingController();

  TextEditingController descController = TextEditingController();
  bool uploaded = false;
  bool Tapped = false;

  @override
  void initState() {
    super.initState();
    uid = FirebaseAuth.instance.currentUser?.uid;
  }

  isDone() {
    setState(() {
      uploaded = true;
    });
  }

  addDescTitle(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.black,
            content: Container(
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(20)),
              alignment: Alignment.topCenter,
              height: 170,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextField(
                    controller: titleController,
                    cursorColor: Colors.white,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        hintText: "Title",
                        hintStyle: TextStyle(color: Colors.white)),
                  ),
                  TextField(
                    controller: descController,
                    cursorColor: Colors.white,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        hintText: "Description",
                        hintStyle: TextStyle(color: Colors.white)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: RaisedButton(
                      color: HexColor('#390999'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Post',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  uploadImage(BuildContext context) async {
    final _firebaseStorage = FirebaseStorage.instance;
    final _imagePicker = ImagePicker();
    XFile? image;
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      image = await _imagePicker.pickVideo(source: ImageSource.gallery);
      var file = File(image?.path ?? '');

      await addDescTitle(context);

      if (image != null) {
        var snapshot = await _firebaseStorage
            .ref()
            .child('Videos/${image.name}')
            .putFile(file);
        var downloadUrl = await snapshot.ref.getDownloadURL();
        print(downloadUrl);
        FirebaseFirestore.instance.collection('videos').add({
          'title': titleController.text,
          'desc': descController.text,
          'url': downloadUrl,
        });

        FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .collection('videos')
            .add({
          'title': titleController.text,
          'desc': descController.text,
          'url': downloadUrl,
        });
      } else {
        print('No Image Path Received');
      }
    } else {
      print('Permission not granted. Try Again with permission access');
    }

    print(uid);
    isDone();
  }

  captureImage(BuildContext context) async {
    final _firebaseStorage = FirebaseStorage.instance;
    final _imagePicker = ImagePicker();
    XFile? image;
    await Permission.camera.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      image = await _imagePicker.pickVideo(source: ImageSource.camera);
      var file = File(image?.path ?? '');

      await addDescTitle(context);

      if (image != null) {
        var snapshot = await _firebaseStorage
            .ref()
            .child('Videos/${image.name}')
            .putFile(file);
        var downloadUrl = await snapshot.ref.getDownloadURL();
        print(downloadUrl);
        FirebaseFirestore.instance.collection('videos').add({
          'title': titleController.text,
          'desc': descController.text,
          'url': downloadUrl,
        });
        FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .collection('videos')
            .add({
          'title': titleController.text,
          'desc': descController.text,
          'url': downloadUrl,
        });
      } else {
        print('No Image Path Received');
      }
    } else {
      print('Permission not granted. Try Again with permission access');
    }
    isDone();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(75),
                  onTap: () {
                    captureImage(context);
                    setState(() {
                      uploaded = false;
                      Tapped = true;
                    });
                  },
                  child: Container(
                    // margin: EdgeInsets.all(8),
                    height: 140,
                    width: 140,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      color: Colors.white.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(75),
                    ),
                    child: Icon(
                      Icons.camera_alt_rounded,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: Text(
                    "Camera",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(75),
                  onTap: () {
                    uploadImage(context);
                    setState(() {
                      uploaded = false;
                      Tapped = true;
                    });
                  },
                  child: Container(
                    // margin: EdgeInsets.all(8),
                    height: 140,
                    width: 140,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      color: Colors.white.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(75),
                    ),
                    child: Icon(
                      Icons.add_photo_alternate_sharp,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: Text(
                    "Gallery",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
        Spacer(),
        Tapped
            ? uploaded
                ? Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  )
                : CircularProgressIndicator()
            : Container(),
      ],
    );
  }
}
