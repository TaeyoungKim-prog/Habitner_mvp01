import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:habitner_mvp_2000817/constants/constants.dart';
import 'package:habitner_mvp_2000817/database/data.dart';
import 'package:habitner_mvp_2000817/database/db.dart';
import 'package:habitner_mvp_2000817/screens/sentence/progress_bar.dart';
import 'package:habitner_mvp_2000817/widgets/loading_screen.dart';
import 'package:habitner_mvp_2000817/widgets/menu.dart';
import 'package:habitner_mvp_2000817/widgets/top_label.dart';

class SentencePage extends StatefulWidget {
  @override
  _SentencePageState createState() => _SentencePageState();
}
List<Data> events;
Data now_Data = Data();
List<String> sentences_temp = [];

class _SentencePageState extends State<SentencePage>
    with SingleTickerProviderStateMixin {
  bool isListPage = false;
  bool isToday = true;

  int numProgress = 0;
  List<int> now_dateTime;

  AnimationController _animationController;
  TextEditingController _textEditingController;

  bool _menuOpened = false;
  int duration = 200;
  double menuWidth = size.width / 1.5;

  bool is_filled = false;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: duration)); // must clear
    now_dateTime = [DateTime.now().year,DateTime.now().month,DateTime.now().day];

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
                  child: isListPage
                      ? Text("작심문장 history",
                          style: TextStyle(
                              fontSize: 11, fontWeight: FontWeight.bold))
                      : Text(
                          "${now_dateTime[0]} ${now_dateTime[1]} ${now_dateTime[2]}",
                          style: TextStyle(
                              fontSize: 11, fontWeight: FontWeight.bold)))),
        ),
        body: Stack(
          children: [
            _backGround(),
            isListPage ? _sentenceListPage() : _sentencePage(),
            _sideMenu(),
            _goToSentenceList()
          ],
        ));
  }

  Widget _backGround() {
    return Container(
      color: Colors.grey[100],
    );
  }

  Widget _sentencePage() {
    return AnimatedContainer(
      width: size.width,
      height: size.height,
      curve: Curves.easeInOut,
      duration: Duration(milliseconds: duration),
      transform: Matrix4.translationValues(_menuOpened ? menuWidth : 0, 0, 0),
      child: SafeArea(
        child: _sentencePageContents(),
      ),
    );
  }

  Widget _sideMenu() {
    return AnimatedContainer(
      width: size.width,
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

  Widget _goToSentenceList() {
    return Positioned(
      bottom: 20,
      child: IconButton(
        icon: Icon(Icons.arrow_forward),
        onPressed: () {
          setState(() {
            isListPage = !isListPage;
            numProgress = 0;
          });
        },
      ),
    );
  }

  Widget _sentencePageContents() {
    return FutureBuilder(
        future: findData(now_dateTime),
        builder: (context, projectSnap) {
          bool isEmpty = false;
          if (projectSnap.data == null) {
            print('there is no data in table');
            isEmpty = true;
          } else {
            now_Data = projectSnap.data;
          }
          return isEmpty? LoadingScreen()
              : Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 10.0, bottom: 0.0),
                child: Container(
                  margin: EdgeInsets.only(bottom: 5.0),
                  height: 200,
                  width: size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/sentence_back${(now_dateTime[1]+now_dateTime[2]) % 3 + 1}.png'),
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.3), BlendMode.dstATop),
                      fit: BoxFit.cover,
                    ),
                    color: Colors.transparent,
                    border: Border.all(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12)),
                    boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 1)],
                  ),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(child: Container()),
                          MyProgressBar(value: numProgress),
                        ],
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Row(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.arrow_back_ios,
                                    color: (numProgress == 0)
                                        ? Colors.grey
                                        : Colors.black,

                                  ),
                                  onPressed: () {
                                    setState(() {
                                      if (numProgress != 0) numProgress--;

                                    });
                                  },
                                ),
                                Expanded(child: Container()),
                                IconButton(
                                  icon: Icon(Icons.arrow_forward_ios,
                                      color: (numProgress == 14)
                                          ? Colors.grey
                                          : Colors.black),
                                  onPressed: () {
                                    setState(() {
                                      if (numProgress != 14) numProgress++;
                                    });
                                    },
                                ),
                              ],
                            ),
                          ),
                          Expanded(child: Container())
                        ],
                      ),
                      Column(
                        children: [
                          Spacer(flex: 1),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30.0),
                            child: Stack(children: [
                              Opacity(
                                  opacity: 0.5,
                                  child: Container(
                                    color: Colors.black,
                                  )),
                              TextField(
                                onChanged: (String text){
                                },
                                cursorColor: Colors.white,
                                controller: _textEditingController,
                                decoration: InputDecoration(),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                            ]),
                          ),
                          Spacer(flex: 1),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        });
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

  Widget _sentenceListPage() {
    return AnimatedContainer(
      width: size.width,
      height: size.height,
      curve: Curves.easeInOut,
      duration: Duration(milliseconds: duration),
      transform: Matrix4.translationValues(_menuOpened ? menuWidth : 0, 0, 0),
      child: SafeArea(
        child: _sentenceListPageContents(),
      ),
    );
  }

  Widget _sentenceListPageContents() {
    return FutureBuilder(
        future: loadData(),
        builder: (context, projectSnap) {
          bool isEmpty = false;
          if (projectSnap.data == null) {
            print('there is no data in table');
            isEmpty = true;
          } else {
            print(projectSnap.data);
            events = projectSnap.data;
          }
          return ListView.builder(
            itemCount: isEmpty ? 0 : events.length,
            itemBuilder: (context, index) {
              Data data = events[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical:5.0, horizontal: 15.0),
                child: _oneItem(index, data.dateTime, data.sentences[0]),
              );
            },
          );
        });
  }

  Widget _oneItem(int index, List<int> date_time, String main_sentence) {
    return GestureDetector(
      onTap: (){
        setState(() {
          isListPage = false;
          isToday = (date_time[0] == DateTime.now().year) | (date_time[1] == DateTime.now().month) | (date_time[2] == DateTime.now().day) ;

          now_dateTime = date_time;
        });
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 5.0),
        height: 100,
        width: size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/sentence_back${(date_time[1]+date_time[2]) % 3 + 1}.png'),
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.3), BlendMode.dstATop),
            fit: BoxFit.cover,
          ),
          color: Colors.transparent,
          border: Border.all(color: Colors.black, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(12)),
          boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 1)],
        ),
        child: Column(
          children: [
            Spacer(flex: 3),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Stack(children: [
                Opacity(
                    opacity: 0.5,
                    child: Container(
                      color: Colors.black,
                    )),
                Text(main_sentence),
              ]),
            ),
            Spacer(flex: 3),
            Text(
              "${date_time[0]} ${date_time[1]} ${date_time[2]}",
              textAlign: TextAlign.end,
            ),
            Spacer(flex: 1),
          ],
        ),
      ),
    );
  }

  Future<List<Data>> loadData() async {
    DBHelper sd = DBHelper();
    return await sd.datas();
  }

  Future<Data> findData(List<int> date_time) async {
    DBHelper sd = DBHelper();
    return await sd.findData(date_time);
  }
}
