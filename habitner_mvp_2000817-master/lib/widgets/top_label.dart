
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:habitner_mvp_2000817/constants/constants.dart';

import 'menu.dart';

class TopLabel extends StatefulWidget {
  final Widget title;

  TopLabel({@required this.title});

  @override
  _TopLabelState createState() => _TopLabelState();
}

class _TopLabelState extends State<TopLabel> with SingleTickerProviderStateMixin{

  double menuWidth = size.width / 1.5;
  bool _menuOpened = false;
  int duration = 200;

  @override
  Widget build(BuildContext context) {
    return _topLabel(widget.title);
  }

  Widget _topLabel(Widget title) {

    return Stack(
      children: [
        Container(height: 80, color: Colors.white,),
        Column(
          children: [
            Container(height: 30,),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: (){
                    setState(() {
                      _menuOpened = true;
                    });
                  },),
                Expanded(child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: title
                ),)
              ],
            ),
          ],
        ),
        _menu()
      ]
    );
  }

  Widget _menu() {
    return AnimatedContainer(
        width: size.width,
        curve: Curves.easeInOut,
        duration: Duration(milliseconds: duration),
        transform: Matrix4.translationValues(_menuOpened? 0 : - size.width, 0, 0),
        child: SafeArea(
          child: Stack(
            children: [
              Row(
                children: [
                  SizedBox(
                      width: menuWidth,
                      child: MenuScreen()
                  ),
                  ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY:10.0),
                      child: SizedBox(
                          width: size.width -  menuWidth,
                          child: Container(color: _menuOpened ? mainColor.shade500 : Colors.transparent )
                      ),
                    ),
                  ),

                ]
            ),
              IconButton(
                icon:Icon(Icons.exit_to_app),
                onPressed: (){
                  setState(() {
                    _menuOpened = false;
                  });
                },
              )
            ]
          ),
        )
    );
  }

}




