import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Users/asdf/AndroidStudioProjects/habitner_mvp_2000817/lib/screens/check/check_page.dart';
import 'file:///C:/Users/asdf/AndroidStudioProjects/habitner_mvp_2000817/lib/screens/sentence/sentence_page.dart';

Widget ListItem(BuildContext context, String title) {

  return Container(
    margin: EdgeInsets.symmetric(horizontal: 20),
    child: InkWell(
      onTap: (){

      },
      onLongPress: (){},
      child: Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(10.0),
        alignment: Alignment.center,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.grey[300],
            width: 2
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 1)],
        ),
        child: Column(
          children: [
            Text(title),
            IconButton(
              icon: Icon(Icons.forward),
              onPressed: (){
                if (title == '작심문장'){
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => SentencePage()));
                }
                else{
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => CheckPage(2020,8,19)));
                }

              },
            )
          ],
        )
      )
    ),
  );
}