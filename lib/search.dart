import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class search extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: searchApp(),
    );
  }
}

class searchApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _searchApp();
}

class _searchApp extends State<searchApp>{
  // api 데이터를 문자열로 받아오기 위해 result(영화API)를 변수 선언
  // result를 데이터 리스트로 받아오기 위한 data 변수 선언
  String result = '';
  List? data;
  TextEditingController? _editingController;
  int page = 1;

  @override
  Widget build(BuildContext context){
    // 검색 API 구현
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[800],
        title: TextField(
          controller: _editingController,
          style: TextStyle(color: Colors.white),
          keyboardType: TextInputType.text,
          decoration: InputDecoration(hintText: '검색어를 입력해주세요'),

        ),
      ),

      body: Center(
              // 검색한 영화결과를 보여주기 위해 리스트 박스 생성
              child: ListView.builder(
              itemBuilder: (context, index){
              return Card(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.red,
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),

                  child: Column(
                    children: <Widget>[
                      //영화 포스터를 가져오기 위해 image.network() 사용
                      Image.network(
                        data![index]['image'],
                        height: 350,
                        width: 350,
                        fit: BoxFit.contain,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.red,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            // 영화 제목과 영화 영어제목을 데이터를 가져온 후 출력해주기 위한 코드
                            Text(data![index]['title'].toString(), textAlign: TextAlign.center,style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                            Text(data![index]['subtitle'].toString(),textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold)),
                            const Divider( //밑에 실선
                              thickness: 1,
                              color: Colors.grey,
                            ),
                            // 영화 개봉, 감독, 배우, 평점 데이터를 가져온 후 출력해주기 위한 코드
                            Text("개봉 : "+data![index]['pubDate'].toString(),style: TextStyle(fontSize: 20,height: 2)),
                            Text("감독 : "+data![index]['director'].toString(),style: TextStyle(fontSize: 20,height: 2)),
                            Text("배우 : "+data![index]['actor'].toString(),style: TextStyle(fontSize: 20,height: 2)),
                            Text("평점 : "+data![index]['userRating'].toString(),style: TextStyle(fontSize: 20,height: 2)),
                          ],
                        ),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.start,
                  ),
                ),
              );
            },
            itemCount: data!.length,
          )
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red[800],
        onPressed: () {
          getJSONData();
        },
        child: Icon(Icons.search),
      ),
    );
  }
  //네이버 영화 검색 API 사용
  Future<String> getJSONData() async {
    var url = "https://openapi.naver.com/v1/search/movie.json?"
        "query=${_editingController!.value.text}";
    var response = await http.get(Uri.parse(url),
        headers: {
      //네이버 API Key
          "X-Naver-Client-Id": "Nz6LwhNDmqiy3BBTy9uY",
          "X-Naver-Client-Secret": "mcigJPI6rs"
        });
    setState((){
      var dataConvertedToJSON = json.decode(response.body);
      List result = dataConvertedToJSON['items'];
      data!.addAll(result);
  });
    return response.body;
  }
  @override
  void initState() {
    super.initState();
    data = new List.empty(growable: true);
    _editingController = new TextEditingController();
  }
}