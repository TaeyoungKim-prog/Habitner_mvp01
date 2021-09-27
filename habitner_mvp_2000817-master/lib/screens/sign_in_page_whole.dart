import 'package:flutter/material.dart';
import 'package:habitner_mvp_2000817/screens/sign_in_page.dart';

import 'login_page_whole.dart';


class createAccount1 extends StatefulWidget {
  @override
  _createAccount1State createState() => _createAccount1State();
}

class _createAccount1State extends State<createAccount1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(

          children: <Widget>[
            createAccount2(),
            _loginBottom(context, "Login Page", 0, 280),
            _loginBottom(context, "Need Help?", 280, 0),
          ],
        ),
      ),
    );
  }
  Positioned _loginBottom(BuildContext context, String txt, double leftSize, double rightSize){
    return Positioned(
      left: leftSize,
      right: rightSize,
      bottom: 0,
      height: 40,
      child: FlatButton(
        onPressed: (){
          final route = MaterialPageRoute(builder: (context)=>loginPage());
          Navigator.pushReplacement(context, route);
        },
        child: RichText(
          text: TextSpan(
            style: const TextStyle(),
            children: <TextSpan>[
              TextSpan(
                  text: txt,
                  style: TextStyle(
                      fontWeight: FontWeight.w500, color: Colors.white
                  )
              ),

            ],
          ),
        ),
      ),
    );
  }
}