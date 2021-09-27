import 'package:flutter/material.dart';

import 'main/main_page.dart';


class createAccount2 extends StatefulWidget {
  @override
  _createAccount2State createState() => _createAccount2State();
}

class _createAccount2State extends State<createAccount2> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailConstroller = TextEditingController();
  TextEditingController _nicknameConstroller = TextEditingController();
  TextEditingController _pwConstroller = TextEditingController();
  TextEditingController _cpwConstroller = TextEditingController();

  @override
  void dispose() {
    _emailConstroller.dispose();
    _nicknameConstroller.dispose();
    _pwConstroller.dispose();
    _cpwConstroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Opacity(
            opacity: 0.9,
            child: Image(
              image: AssetImage("assets/background_image1.png"),
              fit: BoxFit.cover,
            ),
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
                    flex: 20,
                  ),
                  Text(
                    "Welcome",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                    ),
                  ),
                  Spacer(
                    flex: 6,
                  ),
                  Opacity(
                    opacity: 0.7,
                    child: TextFormField(
                      controller: _emailConstroller,
                      decoration: getTextFieldDecor('Email'),

                      validator: (String value) {
                        if(value.length <= 5){
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
                    opacity: 0.7,
                    child: TextFormField(
                      controller: _nicknameConstroller,
                      decoration: getTextFieldDecor('nickname'),

                      validator: (String value) {
                        if(value.length <= 1){
                          return "At least 2 characters";
                        }
                        return null;
                      },
                    ),
                  ),
                  Spacer(
                    flex: 3,
                  ),
                  Opacity(
                    opacity: 0.7,
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
                    flex: 3,
                  ),
                  Opacity(
                    opacity: 0.7,
                    child: TextFormField(
                      obscureText: true,//hide password
                      controller: _cpwConstroller,
                      decoration: getTextFieldDecor("Re enter the Password"),
                      validator: (String value) {
                        if (value.isEmpty || value != _pwConstroller.value.text) {
                          return 'password does not match';
                        }
                        return null;
                      },
                    ),
                  ),
                  Spacer(
                    flex: 4,
                  ),
                  Opacity(
                    opacity: 0.8,
                    child: Padding(
                      padding: EdgeInsets.only(left: 70, right: 70),
                      child: SizedBox(
                        height: 50,
                        child: FlatButton(
                          onPressed: () {
                            if(_formKey.currentState.validate()){
                              final route = MaterialPageRoute(builder: (context) => MainPage());
                              Navigator.pushReplacement(context, route);
                            }
                          },
                          child: Text(
                            "Register",
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
                    flex: 18,
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
