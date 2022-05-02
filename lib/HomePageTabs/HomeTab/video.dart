import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  late String link;
  VideoScreen(this.link);

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late VideoPlayerController _controller;
  // late String link2;

  getData() {
    _controller = VideoPlayerController.network(widget.link)
      ..addListener(() => setState(() {}))
      ..setLooping(false)
      ..initialize().then((value) => _controller.play());
  }

  @override
  void initState() {
    super.initState();
    // widget.link =
    //     "https://firebasestorage.googleapis.com/v0/b/psychic-raceway-347405.appspot.com/o/Videos%2Fimage_picker2041906749454369898.mp4?alt=media&token=5a91a25d-480d-409b-9675-633625f57059";
    getData();
    log("*********************** ${widget.link}  ******************");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 400,
      // width: 200,
      child: _controller.value.isInitialized
          ? VideoPlayer(_controller)
          : Center(child: CircularProgressIndicator()),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();

    super.dispose();
  }
}
