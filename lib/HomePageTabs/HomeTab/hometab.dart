import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/HomePageTabs/HomeTab/video.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  Stream<QuerySnapshot> getData() {
    return FirebaseFirestore.instance.collection("videos").snapshots();
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
                              Text(document['title'],
                                  style: TextStyle(fontSize: 24)),
                              Text(document['desc']),
                              Container(
                                color: Colors.white.withOpacity(0.4),
                                height:
                                    MediaQuery.of(context).size.height - 100,
                                width: MediaQuery.of(context).size.width,
                                child: VideoScreen(document['url']),
                              ),
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
