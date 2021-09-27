import 'package:flutter/material.dart';
import 'package:habitner_mvp_2000817/constants/constants.dart';
import 'package:habitner_mvp_2000817/database/data.dart';
import 'package:habitner_mvp_2000817/database/db.dart';

import 'package:date_util/date_util.dart';
import 'package:habitner_mvp_2000817/widgets/loading_screen.dart';

class Calendar extends StatefulWidget {
  final bool isUp;

  final int year;
  final int month;

  Calendar({this.isUp, this.year, this.month});

  @override
  _CalendarState createState() => _CalendarState();
}

List<Data> events;

class _CalendarState extends State<Calendar> {

  double oneBox_height = (size.height/2 - 95) / 6;
  double oneBox_height_down = (size.height*0.8 - 95) / 6;
  int now_year;
  int now_month;

  bool isLoading = true;

  List<Data> events = [];

  @override
  void initState() {
    init_db();
    now_year = widget.year;
    now_month = widget.month;

    super.initState();
  }


  Future<void> init_db() async {
    DBHelper sd = DBHelper();

    await sd.insertData(Data(
      dateTime: [2020,8,21],
      sentences: ["나는 대통령이 된다.", "나는 세계 최강 대통령이다.", "나는 성공한다."],
      checkList: [
        {'title':'push up 300개', 'check': true},{'title':'스쿼트 100개', 'check': false},{'title':'독서 10분', 'check': true},{'title':'플러터 공부', 'check': false},
      ]
    ));

    await sd.insertData(Data(
        dateTime: [2020,8,20],
        sentences: ["ㅁㄴㅇㄹㄹ는 대통령이 된다.", "ㅍ나는 세계 최강 대통령이다.", "나는 성공한다.", "나는 성공한다.", "나는 성공한다.", "나는 성공한다ㅇㄹㄴㅇㄹ."],
        checkList: [
          {'title':'push up 123개', 'check': false},{'title':'스쿼트 100개', 'check': true},{'title':'독서 10분', 'check': false},
        ]
    ));
    await sd.insertData(Data(
        dateTime: [2020,8,19],
        sentences: ["나는 대통령이 된다.", "나는 세계 최강 대통령이다.", "나는 성공한다."],
        checkList: [
          {'title':'push up 300개', 'check': true},{'title':'스쿼트 100개', 'check': false},{'title':'독서 10분', 'check': true},{'title':'플러터 공부', 'check': false},
        ]
    ));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: loadData(),
        builder: (context, projectSnap){
          if (projectSnap.data == null) {
            print('there is no data in table');}
          else{
            isLoading = false;
            events = projectSnap.data;
          }
          return isLoading ? LoadingScreen() : _calendar();
        }
    );
  }

  Future<List<Data>> loadData() async {
    DBHelper sd = DBHelper();
    return await sd.datas();
  }

  Widget _calendar() {
    return Column(
      children: [date_bar(), week_title(), week_line()],
    );
  }
  Widget date_bar(){
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right:20.0, top:20.0, bottom: 5.0),
      child: Container(
        height: 30,
        child: Row(
          children: [
          IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: (){
            setState((){
              now_year = (now_month == 1) ? now_year - 1 : now_year;
              now_month = (now_month == 1) ? 12 : now_month -1;
            });
          }),
          Spacer(),
          Text('$now_year $now_month'),
          Spacer(),
          IconButton(icon: Icon(Icons.arrow_forward_ios), onPressed: (){
            setState((){
              now_year = (now_month == 12) ? now_year + 1 : now_year;
              now_month = (now_month == 12) ? 1 : now_month + 1;
            });
          }),
        ],),
      ),
    );
  }

  Widget week_title() {
    return Row(
      children: [
        Spacer(
          flex: 1,
        ),
        title_box('월', Colors.black),
        title_box('화', Colors.black),
        title_box('수', Colors.black),
        title_box('목', Colors.black),
        title_box('금', Colors.black),
        title_box('토', Colors.blue),
        title_box('일', Colors.red),
        Spacer(
          flex: 1,
        ),
      ],
    );
  }

  Widget title_box(String weekday, Color TextColor) {
    return Container(
        height: 40,
        width: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(0),
          boxShadow: [],
        ),
        child: Row(
          children: [
            Spacer(),
            Text(
              weekday,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 20, color: TextColor),
            ),
            Spacer(),
          ],
        ));
  }

  Widget week_line() {
    // 월 : 1, 화 : 2, 수 : 3, 목 : 4, 금 : 5, 토 : 6, 일 : 7

    int year = now_year;
    int month = now_month;

    int diff_day = DateTime.now().day - 1;
    //DateTime first_day = DateTime.now().subtract(Duration(days: diff_day));
    DateTime first_day = DateTime(year, month, 1);

    var dateUtility = new DateUtil();

    List<List<int>> days = [];

    int day_temp = 1;

    for (int i = 0; i < 6; i++) {
      days.add([]);
      for (int j = 1; j < 8; j++) {
        if (i == 0) {
          if (j >= first_day.weekday)
            days[i].add(day_temp++);
          else
            days[i].add(0);
        } else {
          if (day_temp > dateUtility.daysInMonth(month, year)) {
            days[i].add(0);
          } else
            days[i].add(day_temp++);
        }
      }
    }

    return Row(
      children: [
        Spacer(),
        Column(
            children: List.generate(
                6,
                    (index_1) => Row(
                    children: List.generate(
                        7,
                            (index_2) => day_box([now_year, now_month, days[index_1][index_2]],
                            "${days[index_1][index_2]}", index_2 + 1, index_1))
                        .toList())).toList()),
        Spacer(),
      ],
    );
  }
  Widget day_box(List<int> date_time, String day, int week_day, int week_num) {
    Color TextColor = Colors.black;

    if (week_day == 6) TextColor = Colors.blue;
    if (week_day == 7) TextColor = Colors.red;

    Data sel_data = null;

    for (int i = 0; i < events.length; i++){
      if ((events[i].dateTime[0] == date_time[0]) && (events[i].dateTime[1] == date_time[1]) && (events[i].dateTime[2] == date_time[2])){
        sel_data = events[i];
        print(sel_data);
      }
    }


    return AnimatedContainer(
        width: 50,
        height: widget.isUp ? oneBox_height : oneBox_height_down,
        curve: Curves.easeInOut,
        duration: Duration(milliseconds: 500),
        transform: Matrix4.translationValues(0, 0, 0),
        child: Container(
            width: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(0),
              boxShadow: [],
            ),
            child: (day == '0') ? Text('') : Column(
              children: [
                Text(
                  day,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 12, color: TextColor),
                ),
                (widget.isUp) ?
                (sel_data == null) ? Text('') : Text((100 * (sel_data.sentences.length + check_sucess(sel_data.checkList)) / (sel_data.checkList.length + 15)).toStringAsFixed(0) +'%'
                ,style: TextStyle(fontSize: 8))
                    :
                (sel_data == null) ? Text('') : Column(children: [
                  Text('${check_sucess(sel_data.checkList)} / ${sel_data.checkList.length}',style: TextStyle(fontSize: 8)),
                  Text('${sel_data.sentences.length} / 15',style: TextStyle(fontSize: 8)),
                ],)

              ],
            )));
  }


  int check_sucess(List<Map<String, dynamic>> check_list){
    int num = 0;

    for ( int i = 0; i < check_list.length ; i++ ){
      if(check_list[i]['check']) num++;
    }

    return num;
  }

}