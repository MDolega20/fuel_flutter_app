import 'package:flutter/material.dart';
import 'package:flutter_app_2/app.dart';

class StartPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fuel app"),
      ),
      body: StartPageBody(messege: "To jest wiadomość z propsa"),
    );
  }
}

class StartPageBody extends StatelessWidget {

  final String messege;

  StartPageBody({this.messege});

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
        Text(messege),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: FlatButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FuelAppMain()),
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
