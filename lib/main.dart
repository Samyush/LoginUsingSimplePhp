import 'package:flutter/material.dart';
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
          ],
        ));
  }

  void changeState() {
    if (signin) {
      signin = false;
    } else
      signin = true;
  }

  Widget boxUi() {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            FlatButton(
              onPressed: null,
              child: Text(
                'SIGN IN',
                style: GoogleFonts.varelaRound(
                    color: signin == true ? Colors.blue : Colors.grey),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
