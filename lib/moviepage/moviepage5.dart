import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MyAppp5 extends StatefulWidget {
  @override
  _MyAppp5 createState() => _MyAppp5();
}


class _MyAppp5 extends State<MyAppp5> {
  late YoutubePlayerController controller;
  @override
  void initState(){
    super.initState();


    const url = 'https://www.youtube.com/watch?v=OTiqmI6Ooqs';

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