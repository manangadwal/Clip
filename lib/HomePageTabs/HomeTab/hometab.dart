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

  // String link =
  //     "https://firebasestorage.googleapis.com/v0/b/psychic-raceway-347405.appspot.com/o/Videos%2Fimage_picker2041906749454369898.mp4?alt=media&token=5a91a25d-480d-409b-9675-633625f57059";
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        // child: VideoScreen(link),
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
                              Text(document['title']),
                              Text(document['desc']),
                              // Text(document['url']),
                              Container(
                                height: MediaQuery.of(context).size.height,
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
