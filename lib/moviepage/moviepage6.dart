import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MyAppp6 extends StatefulWidget {
  @override
  _MyAppp6 createState() => _MyAppp6();
}


class _MyAppp6 extends State<MyAppp6> {
  late YoutubePlayerController controller;
  @override
  void initState(){
    super.initState();


    const url = 'https://www.youtube.com/watch?v=0jOJ-K-rnE4';

    controller = YoutubePlayerController(initialVideoId: YoutubePlayer.convertUrlToId(url)!,
    );
  }
  Widget build(BuildContext context) =>
      YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: controller,
        ),
        builder: (context, player) =>
            Scaffold(
              appBar: AppBar(
                title: const Text('영화 예고편'),
                backgroundColor: Colors.red[800],),

              body: ListView(
                children: [
                  player,
                ],

              ),
            ),
      );
}