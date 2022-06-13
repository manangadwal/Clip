import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/HomePageTabs/HomeTab/video.dart';

class MyVideos extends StatefulWidget {
  String? uid;

  @override
  State<MyVideos> createState() => _MyVideosState();
}

class _MyVideosState extends State<MyVideos> {
  Stream<QuerySnapshot> getData() {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(widget.uid)
        .collection("videos")
        .snapshots();
  }

  @override
  void initState() {
    super.initState();
    widget.uid = FirebaseAuth.instance.currentUser?.uid;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            StreamBuilder(
                stream: getData(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  return ListView(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: snapshot.data?.docs.map((document) {
                          return Column(
                            children: [
                              // Text(document['title']),
                              // Text(document['desc']),
                              Container(
                                color: Colors.white.withOpacity(0.4),
                                height: 70,
                                width: 70,
                                child: VideoScreen(document['url']),
                              ),
                              SizedBox(
                                height: 5,
                              )
                            ],
                          );
                        }).toList() ??
                        [],
                  );
                })
          ],
        ),
      ),
    );
  }
}
