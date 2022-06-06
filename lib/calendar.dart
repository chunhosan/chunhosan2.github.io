import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  // 현재영화상영 포스터를 불러오는 변수 선언
  final urlImages =[
    'https://ssl.pstatic.net/imgmovie/mdi/mit110/1926/192608_P62_104337.jpg',
    'https://ssl.pstatic.net/imgmovie/mdi/mit110/1820/182016_P12_142308.jpg',
    'https://ssl.pstatic.net/imgmovie/mdi/mit110/2161/216100_P10_180346.jpg',
    'https://ssl.pstatic.net/imgmovie/mdi/mit110/1960/196047_P01_112227.jpg',
    'https://ssl.pstatic.net/imgmovie/mdi/mit110/0877/87717_P15_182842.jpg',
    'https://ssl.pstatic.net/imgmovie/mdi/mit110/1838/183862_P52_134645.jpg',
    'https://ssl.pstatic.net/imgmovie/mdi/mit110/2034/203461_P13_160105.jpg',
    'https://ssl.pstatic.net/imgmovie/mdi/mit110/0963/96379_P32_143209.jpg',
    'https://ssl.pstatic.net/imgmovie/mdi/mit110/2146/214637_P09_164501.jpg',
    'https://ssl.pstatic.net/imgmovie/mdi/mit110/2072/207202_P03_113503.jpg'
  ];

  // 선택한 날짜와 현재 날짜를 나타기 위한 변수 선언
  // 그날의 날짜로 초기화 해준다.
  late Map<DateTime, List<Event>> selectedEvents;
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  // 이벤트 텍스트를 활용하기 위한 TextEditingController 변수 선언
  TextEditingController _eventController = TextEditingController();
  @override
  //이벤트
  void initState() {
    selectedEvents = {};
    super.initState();
  }

  List<Event> _getEventsfromDay(DateTime date) {
    // 선택한 이벤트 데이터로 return
    return selectedEvents[date] ?? [];
  }

  @override
  void dispose() {
    _eventController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //달력을 구현하기 위한 코드
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child : SizedBox(
              height: 500,
              width: 500,
          child: TableCalendar(
            // 한국어 설정
            locale: 'ko-KR',
            //이벤트를 설정해준다.
            focusedDay: selectedDay,
            firstDay: DateTime(1990),
            lastDay: DateTime(2050),
            daysOfWeekHeight: 30,
            calendarFormat: format,
            onFormatChanged: (CalendarFormat _format) {
              setState(() {
                format = _format;
              });
            },
            startingDayOfWeek: StartingDayOfWeek.sunday,
            daysOfWeekVisible: true,

            //날짜를 바꾸어 준다
            onDaySelected: (DateTime selectDay, DateTime focusDay) {
              setState(() {
                selectedDay = selectDay;
                focusedDay = focusDay;
              });
              print(focusedDay);
            },
            selectedDayPredicate: (DateTime date) {
              return isSameDay(selectedDay, date);
            },
            eventLoader: _getEventsfromDay,
            //캘린더 스타일을 바꾸기 위한 코드
            calendarStyle: CalendarStyle(
              isTodayHighlighted: true,
              selectedDecoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
              selectedTextStyle: TextStyle(color: Colors.white),
              todayDecoration: BoxDecoration(
                color: Colors.purple,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
              defaultDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
              weekendDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),

            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              formatButtonShowsNext: false,
              formatButtonDecoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(5.0),
              ),
              formatButtonTextStyle: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          ),
          ),
          ..._getEventsfromDay(selectedDay).map(
                (Event event) => ListTile(
              title: Text(
                event.title,
              ),
            ),
          ),
          // 메인화면에 현재상영중인 영화포스터를 넣기위해 이미지 상자을 만드는 코드
          Container(
            alignment: Alignment(0.0, -0.5),
            padding: EdgeInsets.only(left: 30),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.35,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular((50))
                    ,topRight: Radius.circular(50)),
                color:Color(0xff30384c)
            ),
            child: Stack(
              children: [
                //현재상영중인 영화 텍스트 출력 코드
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(top: 20),
                      child: Text("현재 상영중인 영화", style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                      ),
                      ),
                    ),
                    //현재상영중인 영화포스터를 가져와 자동으로 넘기게 해주는 기능(CarouselSlider.builder)
                    Padding(padding: EdgeInsets.only(top: 20),
                      child: CarouselSlider.builder(
                          options: CarouselOptions(
                              height: 190,
                              autoPlay: true,
                              // 넘어가는 화면을 2초로 설정한다.
                              autoPlayInterval: Duration(seconds: 2)),
                          itemCount: urlImages.length,
                          itemBuilder: (context, index, realIndex) {
                            final urlImage = urlImages[index];
                            return buildImage(urlImage, index);
                          },
                    ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],

      ),
      //메인화면에 이벤트를 추가하기위한 코드
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("메모 추가"),
            content: TextFormField(
              controller: _eventController,
            ),
            actions: [
              TextButton(
                child: Text("Cancel"),
                onPressed: () => Navigator.pop(context),
              ),
              TextButton(
                child: Text("Ok"),
                onPressed: () {
                  if (_eventController.text.isEmpty) {
                  } else {
                    if (selectedEvents[selectedDay] != null) {
                      selectedEvents[selectedDay]?.add(
                        Event(title: _eventController.text),
                      );
                    } else {
                      selectedEvents[selectedDay] = [
                        Event(title: _eventController.text)
                      ];
                    }
                  }
                  Navigator.pop(context);
                  _eventController.clear();
                  setState((){});
                  return;
                },
              ),
            ],
          ),
        ),

        label: Text("메모하기"),
        icon: Icon(Icons.add),
        backgroundColor: Colors.red[800],
      ),
    );

  }

}
//현재 상영중인 영화 포스터 위젯
Widget buildImage(String urlImage, int index) => Container(
  margin: EdgeInsets.symmetric(horizontal: 1),
  color: Colors.grey,
  child: Image.network(
    urlImage,
    fit: BoxFit.cover,
  )
);

//이벤트 클래스 생성
class Event {
  final String title;
  Event({required this.title});

  String toString() => this.title;
}
