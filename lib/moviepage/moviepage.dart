import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MyAppp extends StatefulWidget {
  @override
  _MyAppp createState() => _MyAppp();
}

class _MyAppp extends State<MyAppp> {
  late YoutubePlayerController controller;
  @override

  void initState(){
    super.initState();
    //영화 예고편 유튜브 url을 불러오기 위해 선언
    const url = 'https://www.youtube.com/watch?v=aw9j_23nORs';
    //유튜브 controller 위젯 사용하여 url에서 받아온 링크 동영상 재생
    controller = YoutubePlayerController(initialVideoId: YoutubePlayer.convertUrlToId(url)!,
    );
  }
  //영화 예고편 를 실행하기 위한 코드
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

//moviepage1~10까지 동일하다.