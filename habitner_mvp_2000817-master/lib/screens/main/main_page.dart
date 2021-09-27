import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:habitner_mvp_2000817/constants/constants.dart';
import 'file:///C:/Users/asdf/AndroidStudioProjects/habitner_mvp_2000817/lib/screens/sentence/sentence_page.dart';
import 'package:habitner_mvp_2000817/widgets/calendar.dart';
import 'package:habitner_mvp_2000817/widgets/list_item.dart';
import 'package:habitner_mvp_2000817/widgets/menu.dart';
import 'package:habitner_mvp_2000817/widgets/top_label.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with SingleTickerProviderStateMixin {

  AnimationController _animationController;
  bool _menuOpened = false;
  int duration = 500;
  double menuWidth;

  bool _calendarUp = true;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: duration)); // must clear
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(size == null){
      size = MediaQuery.of(context).size;
    }

    menuWidth = size.width / 1.5;

    return Scaffold(

        resizeToAvoidBottomInset: false, // keyboard overflow 방지
        appBar: AppBar(
          leading: IconButton(
              onPressed:(){},
              icon: IconButton(
            //icon: Icon(Icons.menu),
            icon: AnimatedIcon(
              icon: AnimatedIcons.menu_close, //AnimatedIcons.menu_home,
              progress: _animationController,
              semanticLabel: 'Show menu',
            ),
            onPressed: () {
              _menuOpened
                  ? _animationController.reverse()
                  : _animationController.forward();
              setState(() {
                _menuOpened = !_menuOpened;
              });
            },
          )),
          title: SizedBox(
              height: 35,
              child: Center(child: Image.asset('assets/logo_title.png'))),
        ),
        body: Stack(
          children: [_backGround(),_mainPage(), _sideMenu()],
        ));
  }

  Widget _backGround() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
      child: Container(
        height: size.height * 0.8 + 20,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          border: Border.all(
              color: Colors.white,
              width: 1
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.grey[100], blurRadius: 0.1)],
        ),
      ),
    );
  }

  Widget _mainPage() {
    return AnimatedContainer(
      width: size.width,
      curve: Curves.easeInOut,
      duration: Duration(milliseconds: duration),
      transform: Matrix4.translationValues(_menuOpened ? menuWidth : 0, 0, 0),
      child: SafeArea(
        child: _mainPageContents(),
      ),
    );
  }

  Widget _sideMenu() {
    return AnimatedContainer(
      width: size.width,
      height: size.height,
      curve: Curves.easeInOut,
      duration: Duration(milliseconds: duration),
      transform: Matrix4.translationValues(_menuOpened ? 0 : -menuWidth, 0, 0),
      child: SafeArea(
        child: SizedBox(
          width: size.width,
          child: _sideMenuContents(),
        ),
      ),
    );
  }

  Widget _mainPageContents() {
    return Stack(
      children: [
        AnimatedContainer(
            height: _calendarUp ? size.height / 2 : size.height * 0.8,
            curve: Curves.easeInOut,
            duration: Duration(milliseconds: duration),
            transform: Matrix4.translationValues(
                0, 0, 0),
            child: SafeArea(child: Calendar(isUp: _calendarUp, year:2020, month:8))),
        AnimatedContainer(
            curve: Curves.easeInOut,
            duration: Duration(milliseconds: duration),
            transform: Matrix4.translationValues(
                0, _calendarUp ? size.height / 2 : size.height * 0.8,  0),
            child: SafeArea(child: _bottomContents())),

      ],
    );
  }
  
  Widget _bottomContents() {
    return GestureDetector(
      onTap: (){
        setState(() {
          _calendarUp = !_calendarUp;
        });
      },
      child: Column(children: [
        _upDownBorder(),
        _calendarUp? ListItem(context, "작심문장") : Container(),
        _calendarUp? ListItem(context, "체크리스트") : Container(),
      ]
      ),
    );
    
  }

  Widget _sideMenuContents() {
    return Row(children: [
      MenuScreen(),
      _menuOpened
          ? ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: SizedBox(
                    width: size.width - menuWidth,
                    child: Container(color: mainColor.shade500)),
              ),
            )
          : Container(color: Colors.transparent,)
    ]);
  }


  Widget _upDownBorder() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: SizedBox(
        height: 20,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                  width: 1,
                ),
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(1),
                boxShadow: [],
              ),
            ),
            Center(
              child: _calendarUp ? Icon(Icons.arrow_drop_down) : Icon(Icons.arrow_drop_up),
            )
          ],
        ),
      ),
    );
  }
}
