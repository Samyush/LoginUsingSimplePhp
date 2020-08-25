import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('php Login'),
      ),
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: MyApp(),
      ),
    ),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool signin = true;
  // static const ROOT =
  //     'http://192.168.31.54/dashboard/EmpDB/employee_action.php';
  // TextEditingController namectrl;
  // TextEditingController emailctrl;
  // TextEditingController passctrl;
  TextEditingController namectrl, emailctrl, passctrl;

  bool processing = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    namectrl = new TextEditingController();
    emailctrl = new TextEditingController();
    passctrl = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Icon(
            Icons.account_circle,
            size: 200,
            color: Colors.blue,
          ),
          boxUi(),
        ],
      ),
    );
  }

  void changeState() {
    if (signin) {
      setState(() {
        signin = false;
      });
    } else {
      setState(() {
        signin = true;
      });
    }
  }

  Future<void> registerUser() async {
    setState(() {
      processing = true;
    });
    var url = 'http://192.168.31.54/dashboard/LoginDB/signup.php';
    var data = {
      "email": emailctrl.text,
      "name": namectrl.text,
      "pass": passctrl.text,
    };

    var res = await http.post(url, body: data);
    if (jsonDecode(res.body) == "account already exists") {
      Fluttertoast.showToast(
        msg: "account exists, please login",
        toastLength: Toast.LENGTH_SHORT,
      );
    } else {
      if (jsonDecode(res.body) == "true") {
        Fluttertoast.showToast(
          msg: "account created, please login",
          toastLength: Toast.LENGTH_SHORT,
        );
      } else
        Fluttertoast.showToast(
          msg: "error, please try again",
          toastLength: Toast.LENGTH_SHORT,
        );
    }
    setState(() {
      processing = true;
    });
  }

  Future<void> userSignIn() async {
    setState(() {
      processing = true;
    });
    var url = 'http://192.168.31.54/dashboard/LoginDB/signin.php';
    var data = {
      "email": emailctrl.text,
      "pass": passctrl.text,
    };

    var res = await http.post(url, body: data);

    if (jsonDecode(res.body) == "dont have a account") {
      Fluttertoast.showToast(
          msg: "dont have account, Create an account",
          toastLength: Toast.LENGTH_SHORT);
    } else {
      if (jsonDecode(res.body) == "false") {
        Fluttertoast.showToast(
            msg: "incorrect password", toastLength: Toast.LENGTH_SHORT);
      } else {
        print(jsonDecode(res.body));
      }
    }
    setState(() {
      processing = false;
    });
  }

  Widget boxUi() {
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton(
                  onPressed: () => changeState(),
                  child: Text(
                    'SIGN IN',
                    style: GoogleFonts.varelaRound(
                      color: signin == true ? Colors.blue : Colors.grey,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: () => changeState(),
                  child: Text(
                    'SIGN UP',
                    style: GoogleFonts.varelaRound(
                      color: signin != true ? Colors.blue : Colors.grey,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            signin == true ? signinUI() : signupUI(),
          ],
        ),
      ),
    );
  }

  Widget signinUI() {
    return Column(
      children: <Widget>[
        TextField(
          controller: emailctrl,
          decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.account_box,
              ),
              hintText: 'email address'),
        ),
        TextField(
          controller: passctrl,
          decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.account_box,
              ),
              hintText: 'Password'),
        ),
        SizedBox(
          height: 10.0,
        ),
        MaterialButton(
          onPressed: () => userSignIn(),
          child: processing == false
              ? Text(
                  'Sign IN',
                  style: GoogleFonts.varelaRound(
                    fontSize: 18.0,
                    color: Colors.blue,
                  ),
                )
              : CircularProgressIndicator(
                  backgroundColor: Colors.red,
                ),
        )
      ],
    );
  }

  Widget signupUI() {
    return Column(
      children: <Widget>[
        TextField(
          controller: namectrl,
          decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.account_box,
              ),
              hintText: 'name'),
        ),
        TextField(
          controller: emailctrl,
          decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.account_box,
              ),
              hintText: 'email address'),
        ),
        TextField(
          controller: passctrl,
          decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.account_box,
              ),
              hintText: 'Password'),
        ),
        SizedBox(
          height: 10.0,
        ),
        MaterialButton(
          onPressed: () => registerUser(),
          child: processing == false
              ? Text(
                  'Sign UP',
                  style: GoogleFonts.varelaRound(
                    fontSize: 18.0,
                    color: Colors.blue,
                  ),
                )
              : CircularProgressIndicator(
                  backgroundColor: Colors.red,
                ),
        ),
      ],
    );
  }
}

// set up php after all GUI
