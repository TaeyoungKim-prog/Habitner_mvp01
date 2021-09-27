import 'package:flutter/material.dart';

class Data {

  final List<int> dateTime;
  final List<String> sentences;
  final List<Map<String, dynamic>> checkList;

  Data({this.dateTime, this.sentences, this.checkList});

  Map<String, dynamic> toMap(){
    return {
      'dateTime': transToString_ListInt(dateTime),
      'sentences': transToString_ListString(sentences),
      'checkList': transToString_ListMap(checkList),
    };
  }

  @override
  String toString() {
    return 'Data{dateTime: ${transToString_ListInt(dateTime)}, sentences: ${transToString_ListString(sentences)}, checkList: ${transToString_ListMap(checkList)}}';
  }

}

String transToString_ListInt (List<int> data){
  String temp = '';
  
  // year _ _ _ _
  temp = temp + data[0].toString(); 
  
  // month _ _
  if(data[1] < 10) temp = temp + '0' + data[1].toString();
  else temp = temp + data[1].toString();
  
  // day _ _
  if(data[2] < 10) temp = temp + '0' + data[2].toString();
  else temp = temp + data[2].toString();

  return temp; // _ _ _ _ _ _ _ _  2 0 2 0 0 8 1 9  
}

List<int> interp_String_To_ListInt (String data) {

  String year = '';
  String month = '';
  String day = '';


  for (int i = 0; i < 8; i++){
    if (i < 4) {
      year = year + data[i];
    }
    else {
      if (i < 6) month = month + data[i];
      else day = day + data[i];
    }
  }


  return <int>[int.parse(year), int.parse(month), int.parse(day)];
}

String transToString_ListString (List<String> data) {

  String temp = '';

  for (int i = 0 ; i < data.length; i++){
    if(data[i].length < 10)
      temp = temp + '00${data[i].length}';
    else{
      if (data[i].length < 100)
        temp = temp + '0${data[i].length}';
      else
        temp = temp + '${data[i].length}';
    }
    temp = temp + data[i];
  }

  return temp;
}


List<String> interp_String_To_ListString (String data) {

  List<String> temp = [];
  String tempStr = '';
  int strlen = 0;
  bool isFirst = true;


  for (int i = 0; i < data.length;){
    if (strlen == 0){
      if (!isFirst) temp.add(tempStr);
      else isFirst = false;

      strlen = int.parse(data[i]+data[i+1]+data[i+2]);
      i = i + 3;
      tempStr = '';
    }
    else {
      tempStr = tempStr + data[i];
      strlen--;
      i++;
    }
  }
  temp.add(tempStr);

  return temp;
}


String transToString_ListMap (List<Map<String, dynamic>> data) {
  String temp = '';

  for (int i = 0 ; i < data.length; i++){
    if(data[i]['title'].length < 10)
      temp = temp + '00${data[i]['title'].length}';
    else{
      if (data[i]['title'].length < 100)
        temp = temp + '0${data[i]['title'].length}';
      else
        temp = temp + '${data[i]['title'].length}';
    }
    temp = temp + data[i]['title'];
    if(data[i]['check']) temp = temp + '1';
    else temp = temp + '0';
  }

  return temp;
}

List<Map<String, dynamic>> interp_String_To_ListMap (String data) {

  List<Map<String, dynamic>> temp = [];
  String tempStr = '';
  int strlen = 0;
  int checkFlag = 1;
  int tempCheck;
  bool isFirst = true;

  for (int i = 0; i < data.length;){
    if (strlen == 0){
      if (checkFlag == 1){
        if (!isFirst) temp.add({'title':tempStr, 'check': (tempCheck == 1)? true : false});
        else isFirst = false;

        strlen = int.parse(data[i]+data[i+1]+data[i+2]);
        i = i + 3;
        tempStr ='';
        checkFlag = 0;
      }
      else {
        checkFlag = 1;
        tempCheck = int.parse(data[i]);
        i++;
      }
    }
    else {
      tempStr = tempStr + data[i];
      strlen--;
      i++;
    }
  }
  temp.add({'title':tempStr, 'check': (tempCheck == 1)? true : false});

  return temp;
}
