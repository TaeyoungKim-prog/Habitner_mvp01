import 'package:flutter/material.dart';
import 'package:habitner_mvp_2000817/constants/constants.dart';
import 'package:habitner_mvp_2000817/screens/sign_in_page_whole.dart';

import 'login_page.dart';

class loginPage extends StatefulWidget {
  @override
  _loginPageState createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {


  @override
  Widget build(BuildContext context) {

    if(size == null){
      size = MediaQuery.of(context).size;
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(

          children: <Widget>[
            loginPage2(),

            _loginBottom(context, "Create Account", 0, 280),
            _loginBottom(context, "Need Help?", 280, 0),
          ],
        ),
      ),
    );
  }

  Positioned _loginBottom(BuildContext context, String txt, double leftSize,
      double rightSize) {
    return Positioned(
      left: leftSize,
      right: rightSize,
      bottom: 0,
      height: 40,
      child: FlatButton(
        onPressed: () {
          final route = MaterialPageRoute(builder: (context) =>
              createAccount1());
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