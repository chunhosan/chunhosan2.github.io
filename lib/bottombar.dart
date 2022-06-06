import 'package:flutter/material.dart';
import 'calendar.dart';
import 'search.dart';
import 'api.dart';


class bottombar extends StatefulWidget {
  @override
  _bottombar createState() => _bottombar();
}

class _bottombar extends State<bottombar> {
  // bottom네이게이션 바를 사용하기 위해 현재 홈화면을 index 1번으로 설정
  int currentIndex = 1;
  // 검색(search.dart) 0번 홈화면(calendar.dart) 1번 api(api.dart) 2번으로 설정
  final screens =[
    search(),
    Calendar(),
    api(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      // BottomNavigationBar 구현코드
      home: Scaffold(

        body: screens[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.red,
          selectedItemColor: Colors.white,
          currentIndex: currentIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: '검색',
              backgroundColor: Colors.red,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '홈',
              backgroundColor: Colors.red,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: '현재영화순위',
              backgroundColor: Colors.red,
            ),
          ],
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}