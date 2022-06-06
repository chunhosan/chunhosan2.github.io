import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MyAppp2 extends StatefulWidget {
  @override
  _MyAppp2 createState() => _MyAppp2();
}

class _MyAppp2 extends State<MyAppp2> {
  late YoutubePlayerController controller;
  @override
  void initState(){
    super.initState();

    const url = 'https://www.youtube.com/watch?v=mI9oyFMUlfg';

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