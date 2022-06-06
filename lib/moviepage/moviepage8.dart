import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MyAppp8 extends StatefulWidget {
  @override
  _MyAppp8 createState() => _MyAppp8();
}


class _MyAppp8 extends State<MyAppp8> {
  late YoutubePlayerController controller;
  @override
  void initState(){
    super.initState();


    const url = 'https://www.youtube.com/watch?v=A6Evbwm07QE';

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