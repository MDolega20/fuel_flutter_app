import 'package:flutter/material.dart';
import 'package:flutter_app_2/screens/second_page.dart';

class HomePage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Fuel app"),
        ),
        body: HomeBody());
  }
}

class HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          "Welcome in my new fuel app!",
          style: TextStyle(fontSize: 50.0),
          textAlign: TextAlign.center,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: FlatButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SecondPage()),
              );
            },
            color: Colors.red,
            child: Text(
              "Check this!",
              style: TextStyle(fontSize: 20.0, color: Colors.white),
            ),
          ),
        )
      ],
    );
  }
}