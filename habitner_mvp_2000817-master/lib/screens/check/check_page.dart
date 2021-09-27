import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:habitner_mvp_2000817/constants/constants.dart';
import 'package:habitner_mvp_2000817/database/data.dart';
import 'package:habitner_mvp_2000817/database/db.dart';
import 'package:habitner_mvp_2000817/widgets/loading_screen.dart';
import 'package:habitner_mvp_2000817/widgets/menu.dart';

class CheckPage extends StatefulWidget {
  final int year;
  final int month;
  final int day;

  CheckPage(this.year, this.month, this.day);

  @override
  _CheckPageState createState() => _CheckPageState();
}

class _CheckPageState extends State<CheckPage>
    with SingleTickerProviderStateMixin {
  //bool isToday = false;
  bool isToday = true;
  List<int> dateTime;

  Data now_Data = Data();

  AnimationController _animationController;
  bool _menuOpened = false;
  int duration = 200;
  double menuWidth = size.width / 1.5;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: duration)); // must clear

    dateTime = [widget.year, widget.month, widget.day];

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // keyboard overflow 방지
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {},
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
            child: Center(
              child: Text(
                "${dateTime[0]} ${dateTime[1]} ${dateTime[2]}",
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
              ),
            )),
      ),
      body: Stack(
        children: [_backGround(), _checkPage(context), _sideMenu()],
      ),
    );
  }

  Widget _backGround() {
    return Container(
      color: Colors.grey[100],
    );
  }

  Widget _checkPage(BuildContext context) {
    return AnimatedContainer(
      width: size.width,
      curve: Curves.easeInOut,
      duration: Duration(milliseconds: duration),
      transform: Matrix4.translationValues(_menuOpened ? menuWidth : 0, 0, 0),
      child: SafeArea(
        child: _checkPageContents(context),
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
          child: _sideMenuContents(), // for using list
        ),
      ),
    );
  }

  Future<Data> findData(List<int> date_time) async {
    DBHelper sd = DBHelper();

    return await sd.findData(date_time);
  }

  Widget _checkPageContents(BuildContext context) {
    return FutureBuilder(
        future: findData(dateTime),
        builder: (context, projectSnap) {
          bool isEmpty = false;

          if (projectSnap.data == null) {
            print('there is no such day Data');
            isEmpty = true;
          } else {
            now_Data = projectSnap.data;
            print(projectSnap.data);
          }

          return isEmpty? LoadingScreen() :
          Padding(
            padding:
                const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 100.0),
            child: isEmpty ?
            LoadingScreen()
                :
            ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: isEmpty? 1 : now_Data.checkList.length + 1,
                itemBuilder: (context_list, index) {
                  if (index < now_Data.checkList.length) {
                    return _oneItem(context, index, now_Data.checkList[index]['title'],
                        now_Data.checkList[index]['check']);
                  } else {
                    if (isToday) {
                      return _addItem(context);
                    }
                    return null;
                  }
                }),
          );
        });
  }

  Widget _oneItem(
      BuildContext context_home, int index, String title, bool check) {
    return InkWell(
      onTap: () {
        if (isToday) {
          setState(() {
            switch_check(index);
          });
        }
      },
      onLongPress: () {
        if (isToday) {
          showAlertDialog_longPress(context_home, index);
        }
      },
      child: Container(
          margin: EdgeInsets.all(5.0),
          padding: const EdgeInsets.all(15.0),
          alignment: Alignment.center,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.grey,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [BoxShadow(color: Colors.grey[300], blurRadius: 1)],
          ),
          child: Row(
            children: [
              Expanded(child: Text(title)),
              check
                  ? SizedBox(
                      height: 80, child: Image.asset('assets/check_ok.png'))
                  : SizedBox(
                      height: 80, child: Image.asset('assets/check_not.png'))
            ],
          )),
    );
  }

  Widget _addItem(BuildContext context_home) {
    return InkWell(
      onTap: () {
        showAlertDialog_addPress(context_home);
      },
      onLongPress: () {},
      child: Container(
          margin: EdgeInsets.all(5),
          padding: const EdgeInsets.all(15.0),
          alignment: Alignment.center,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.grey,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 3)],
          ),
          child: Center(
            child: Icon(
              Icons.add,
              size: 60,
              color: Colors.deepOrangeAccent,
            ),
          )),
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
          : Container(
              color: Colors.transparent,
            )
    ]);
  }

  void showAlertDialog_longPress(BuildContext context, int index) async {
    String result = await showDialog(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('삭제 경고'),
            content: Text("정말 삭제하시겠습니까?\n 삭제된 메모는 복구되지 않습니다."),
            actions: <Widget>[
              FlatButton(
                color: Colors.red,
                child:
                    Text('삭제', style: TextStyle(fontWeight: FontWeight.bold)),
                onPressed: () {
                  setState(() {
                    delete_item(index);
                  });
                  Navigator.pop(context, "삭제");
                },
              ),
              FlatButton(
                color: Colors.grey,
                child: Text(
                  '취소',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Navigator.pop(context, "취소");
                },
              ),
            ],
          );
        });
  }

  void showAlertDialog_addPress(BuildContext context) async {
    String result = await showDialog(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          final addTextController = TextEditingController();

          return AlertDialog(
            title: Text('체크리스트 추가'),
            content: TextField(
              controller: addTextController,
              style: TextStyle(fontSize: 12),
              maxLines: 1,
            ),
            actions: <Widget>[
              FlatButton(
                color: Colors.deepOrangeAccent,
                child:
                    Text('생성', style: TextStyle(fontWeight: FontWeight.bold)),
                onPressed: () {
                  setState(() {
                    add_item(addTextController.text);
                  });
                  Navigator.pop(context, "생성");
                },
              ),
              FlatButton(
                color: Colors.grey,
                child: Text(
                  '취소',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Navigator.pop(context, "취소");
                },
              ),
            ],
          );
        });
  }

  void delete_item(int index) async {

    DBHelper sd = DBHelper();
    List<Map<String, dynamic>> temp = [];

    for (int i = 0; i < now_Data.checkList.length; i++)
      if (i != index) temp.add(now_Data.checkList[i]);

    await sd.updateData(Data(
      dateTime: dateTime,
      sentences: now_Data.sentences,
      checkList: temp,
    ));

  }

  void switch_check(int index) async {

    DBHelper sd = DBHelper();
    List<Map<String, dynamic>> temp = [];

    for (int i = 0; i < now_Data.checkList.length; i++)
      if (i != index) temp.add(now_Data.checkList[i]);
      else temp.add({'title':now_Data.checkList[i]['title'],'check':!now_Data.checkList[i]['check']});

    await sd.insertData(Data(
      dateTime: dateTime,
      sentences: now_Data.sentences,
      checkList: temp,
    ));
  }

  void add_item(String title) async {
    DBHelper sd = DBHelper();
    List<Map<String, dynamic>> temp = [];

    for (int i = 0; i < now_Data.checkList.length; i++)
      temp.add(now_Data.checkList[i]);

    temp.add({'title':title,'check':false});

    await sd.insertData(Data(
      dateTime: dateTime,
      sentences: now_Data.sentences,
      checkList: temp,
    ));
  }
}
