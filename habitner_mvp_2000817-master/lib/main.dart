import 'package:flutter/material.dart';
import 'package:habitner_mvp_2000817/constants/constants.dart';
import 'package:habitner_mvp_2000817/screens/login_page_whole.dart';
import 'package:habitner_mvp_2000817/screens/main/main_page.dart';

import 'package:flutter/services.dart'; // for prevent 자동 회전

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  bool isLogined = true;

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        home: isLogined ? MainPage(): loginPage(),
      theme: ThemeData(
        canvasColor: Colors.white, //transparent 사용할때 뒤에 보이던 색깔들이 요거 였음!
          primarySwatch: white // 그냥 Colors.white 는 에러가 뜬다. (MaterialColor로 지정되어 있지 않기 때문에)
      )
    );
  }
}
