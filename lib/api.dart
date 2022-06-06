import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:moviecalendar3/moviepage/moviepage.dart';
import 'package:moviecalendar3/moviepage/moviepage2.dart';
import 'package:moviecalendar3/moviepage/moviepage3.dart';
import 'package:moviecalendar3/moviepage/moviepage4.dart';
import 'package:moviecalendar3/moviepage/moviepage5.dart';
import 'package:moviecalendar3/moviepage/moviepage6.dart';
import 'package:moviecalendar3/moviepage/moviepage7.dart';
import 'package:moviecalendar3/moviepage/moviepage8.dart';
import 'package:moviecalendar3/moviepage/moviepage9.dart';
import 'package:moviecalendar3/moviepage/moviepage10.dart';


class api extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: HttpApp(),
    );
  }
}

class HttpApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _HttpApp();
}

class _HttpApp extends State<HttpApp>{
  // api 데이터를 문자열로 받아오기 위해 result(영화API)와 result2(네이버API)를 변수 선언
  // result를 데이터 리스트로 받아오기 위한 data 변수 선언
  String result = '';
  String result2 = '';
  List? data;

  var mList = ['https://ssl.pstatic.net/imgmovie/mdi/mit110/1926/192608_P62_104337.jpg','https://ssl.pstatic.net/imgmovie/mdi/mit110/1820/182016_P12_142308.jpg','https://ssl.pstatic.net/imgmovie/mdi/mit110/2161/216100_P10_180346.jpg','https://ssl.pstatic.net/imgmovie/mdi/mit110/1960/196047_P01_112227.jpg','https://ssl.pstatic.net/imgmovie/mdi/mit110/0877/87717_P15_182842.jpg',
    'https://ssl.pstatic.net/imgmovie/mdi/mit110/1838/183862_P52_134645.jpg','https://ssl.pstatic.net/imgmovie/mdi/mit110/2034/203461_P13_160105.jpg','https://ssl.pstatic.net/imgmovie/mdi/mit110/0963/96379_P32_143209.jpg',
    'https://ssl.pstatic.net/imgmovie/mdi/mit110/2146/214637_P09_164501.jpg','https://ssl.pstatic.net/imgmovie/mdi/mit110/2072/207202_P03_113503.jpg'];

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('현재영화순위'),
        backgroundColor: Colors.red[800],
      ),
      body: Container(
        child: Center(
              child: ListView.builder(
              itemBuilder: (context, index){

                return GestureDetector(
                  onTap: (){
                    // 영화를 선택했을 때 영화 예고편(moviepage1~10)으로 이동
                    switch (index){
                    case 0:
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MyAppp()));
                    break;
                    case 1:
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MyAppp2()));
                    break;
                    case 2:
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MyAppp3()));
                    break;
                    case 3:
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MyAppp4()));
                    break;
                    case 4:
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MyAppp5()));
                    break;
                    case 5:
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MyAppp6()));
                    break;
                    case 6:
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MyAppp7()));
                    break;
                    case 7:
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MyAppp8()));
                    break;
                    case 8:
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MyAppp9()));
                    break;
                    case 9:
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MyAppp10()));
                    break;
                    }},
                  // 영화 순위 UI구현
                  child: Card(
                    child: Container(
                      child: Row(//Column(
                        children: <Widget>[
                          //영화 순위를 가져오기 위한 Text
                          Text(data![index]['rank'].toString() + "위", style: TextStyle(fontWeight: FontWeight.bold)),
                          //영화 포스터를 가져오기 위해 image.network() 사용
                          Image.network(
                            mList[index],
                            height: 100,
                            width: 100,
                            fit: BoxFit.contain,
                          ),
                          Column(
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width -150,
                                child: Text(
                                  // 영화 이름을 가져온다.
                                  data![index]['movieNm'].toString(),
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              // 영화 개봉일, 누적 관객수 데이터 가져와서 텍스트로 출력한다.
                              Text("영화 개봉일 : " + data![index]['openDt'].toString()),
                              Text("누적 관객수 : " + data![index]['audiAcc'].toString()+ "명"),
                            ],
                          )
                        ],
                        mainAxisAlignment: MainAxisAlignment.start,
                      ),
                    ),
                  ),
                );
                },
              itemCount: data!.length,
            )
        ),
      ),
      //데이터 가져오는 버튼
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red[800],
        onPressed: () {
          getJSONData();
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
  //영화진흥관리위원회 API 가져오기
  Future<String> getJSONData() async {
    // API 순위를 가져오는 URL
    var url = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=722f8135c444769d9c4edfc811d59631&targetDt=20220529";
    var response = await http.get(Uri.parse(url),
        // API 키
        headers: { "key": "722f8135c444769d9c4edfc811d59631" });
    //가져오는 데이터(dailyBoxOfficeList)를 리스트(data)에 넣어준다.
    setState(() {
      Map<String,dynamic> dataConvertedToJSON = new Map<String, dynamic>.from(json.decode(response.body));
      List result = dataConvertedToJSON['boxOfficeResult']["dailyBoxOfficeList"];
      data!.addAll(result);
    });
    return response.body;
  }
  @override
  void initState() {
    super.initState();
    data = new List.empty(growable: true);
  }
}