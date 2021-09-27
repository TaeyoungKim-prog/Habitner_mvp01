import 'package:flutter/material.dart';
import 'package:habitner_mvp_2000817/constants/constants.dart';

import 'main/main_page.dart';


class loginPage2 extends StatefulWidget {
  @override
  _loginPage2State createState() => _loginPage2State();
}

class _loginPage2State extends State<loginPage2> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailConstroller = TextEditingController();
  TextEditingController _pwConstroller = TextEditingController();

  @override
  void dispose() {
    _emailConstroller.dispose();
    _pwConstroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image(
            image: AssetImage("assets/background_image1.png"),
            fit: BoxFit.cover,
          ),
          Padding(
            padding:
            const EdgeInsets.only(top: 0, bottom: 0, right: 33, left: 33),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Spacer(
                    flex: 35,
                  ),
                  Text(
                    "Login",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 50,
                      color: Colors.white,
                    ),
                  ),
                  Spacer(
                    flex: 10,
                  ),
                  Opacity(
                    opacity: 0.5,
                    child: TextFormField(
                      controller: _emailConstroller,
                      decoration: getTextFieldDecor('Email'),

                      validator: (String value) {
                        if (value.isEmpty || !value.contains("@")) {
                          return "Please enter your email address";
                        }else if(value.length <= 5){
                          return "email is too short(least6)";
                        }
                        return null;
                      },
                    ),
                  ),
                  Spacer(
                    flex: 3,
                  ),
                  Opacity(
                    opacity: 0.5,
                    child: TextFormField(
                      obscureText: true,//hide password
                      controller: _pwConstroller,
                      decoration: getTextFieldDecor("Password"),
                      validator: (String value) {
                        if (value.isEmpty || value.length <= 5) {
                          return 'password is too short(least6)';
                        }
                        return null;
                      },
                    ),
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  Text(
                    "Forgetten password?",
                    textAlign: TextAlign.end,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                  Spacer(
                    flex: 2,
                  ),
                  Opacity(
                    opacity: 0.8,
                    child: Padding(
                      padding: EdgeInsets.only(left: 70, right: 70),
                      child: SizedBox(
                        height: 50,
                        child: FlatButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              final route = MaterialPageRoute(
                                  builder: (context) => MainPage());
                              Navigator.pushReplacement(context, route);
                            }
                          },
                          child: Text(
                            "Log in",
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.blueGrey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Spacer(
                    flex: 8,
                  ),
                  FlatButton(
                    onPressed: () {},
                    child: (Text(
                      "Login with Google",
                      style: TextStyle(color: Colors.white70, fontSize: 15),
                    )),
                  ),
                  Spacer(
                    flex: 10,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration getTextFieldDecor(String hint) {
    return InputDecoration(
        errorStyle: TextStyle(
            color: Colors.white
        ),
        hintText: hint,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey[300],
            width: 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey[300],
            width: 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        fillColor: Colors.grey[100],
        filled: true);
  }

  void simpleSnackbar(BuildContext context, String txt) {
    final snackBar = SnackBar(
      content: Text(txt),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }
}
