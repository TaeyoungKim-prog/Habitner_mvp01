import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habitner_mvp_2000817/constants/constants.dart';
import 'package:habitner_mvp_2000817/debug/debug_message.dart';
import 'file:///C:/Users/asdf/AndroidStudioProjects/habitner_mvp_2000817/lib/screens/main/main_page.dart';

Widget MenuScreen() {
  double menuWidth = size.width / 1.5;

  String userName = '김강현';

  return SizedBox(
    width: menuWidth,
    height: size.height,
    child: Stack(children: [
      Container(
        color: Colors.white,
      ),
      Column(children: [
        Stack(children: [
          Container(height: 150, color:Colors.orangeAccent),
          FlatButton(
            onPressed:(){
              ToastMessage("나중에 개인페이지 이동 구현 ㄱ");
            },
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(radius: 50, backgroundImage: AssetImage('assets/user1.png'),),
                ), // Image.asset() 은 안됨
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        style: const TextStyle(),
                        children: [
                          TextSpan(text: "${userName} ", style: TextStyle(fontSize:20, fontWeight: FontWeight.bold, color: Colors.black)),
                          TextSpan(text: "님 환영합니다 ! ", style: TextStyle(fontSize:15,fontWeight: FontWeight.w300, color: Colors.grey)),
                        ]
                    ),
                  ),
                ),
              ],
            ),
          ),

        ]),
        Expanded(child:Column(children: [

          Container(height:1, color: Colors.grey,),
          Padding(padding: EdgeInsets.symmetric(vertical: 5.0),),
          ListTile(
            onTap: (){
              ToastMessage("나중에 홈화면 이동 구현 ㄱ");
            },
            leading: Icon(Icons.home),
            title: Text('홈'),
              trailing: Icon(Icons.arrow_forward_ios)
          ),

            ListTile(
              onTap: (){
                ToastMessage("나중에 작심문장 이동 구현 ㄱ");
              },
              leading: Icon(Icons.whatshot),
              title: Text('작심문장'),
                trailing: Icon(Icons.arrow_forward_ios)
            ),

            ListTile(
              onTap: (){
                ToastMessage("나중에 체크리스트 이동 구현 ㄱ");
              },
              leading: Icon(Icons.assignment_turned_in),
              title: Text('체크리스트'),
                trailing: Icon(Icons.arrow_forward_ios)
            ),

            ListTile(
              onTap: (){
                ToastMessage("나중에 공지사항 이동 구현 ㄱ");
              },
                leading: Icon(Icons.add_alert),
              title: Text('공지사항'),
                trailing: Icon(Icons.arrow_forward_ios)),

        ]
        )),
        Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: SizedBox(width: 100, child: Image.asset('assets/logo.png')),
            ))
      ]),

    ]),
  );
}
