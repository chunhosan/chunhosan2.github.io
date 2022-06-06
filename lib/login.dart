import 'package:flutter/material.dart';
import 'bottombar.dart';

class LogIn extends StatefulWidget {
  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  @override
  // 로그인 화면 UI 구성
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('로그인'),
        backgroundColor: Colors.red[800],

      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(padding: (EdgeInsets.only(top: 50)),
            ),
            Center(
              child: Image(
                image: AssetImage('image/logo.png'),
                width: 170,
                height: 190,
              ),
            ),
            Form(child: Theme(
              data: ThemeData(
                primaryColor: Colors.teal,
                inputDecorationTheme: InputDecorationTheme(
                    labelStyle: TextStyle(
                        color: Colors.teal,
                        fontSize: 15.0
                    )
                ),
              ),
              child: Container(
                padding: EdgeInsets.all(40.0),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                          labelText: '입력 "아이디"'
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    TextField(
                      decoration: InputDecoration(
                          labelText: '입력 "패스워드"'
                      ),
                      keyboardType: TextInputType.text,
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    ButtonTheme(
                        minWidth: 100.0 ,
                        height: 60.0,
                        child: RaisedButton(
                            color: Colors.red[800],
                            child: Text('로그인'),
                            // BottomNavigation화면을 구현하기 위해 버튼을 누르면 bottombar.dart로 이동
                            onPressed: (){
                              Navigator.push(
                                  context, MaterialPageRoute(builder: (_) => bottombar()));
                            })
                    ),
                  ],
                ),
              ),
             ),
            ),
          ],
        ),
      ),
    );
  }
}