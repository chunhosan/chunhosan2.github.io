import 'package:flutter/material.dart';
import 'login.dart';
import 'dart:async';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      // 달력을 한글로 변경시켜주기 위한 위젯
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('ko', 'KR'),
      ],
      title: 'Calendar',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    //splash 로고 화면을 구현한 후 3초정도 대기하기 위한 위젯 사용
    Timer(Duration(seconds: 3),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                LogIn()
            )
        )
    );
  }

  @override
  // 로고 이미지 위젯 생성
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child:Image.asset('image/logo.png'),
    );
  }
}