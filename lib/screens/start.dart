import 'package:flutter/material.dart';
import 'package:flutter_app_2/app.dart';
import 'package:flutter_app_2/model/fueling.dart';
import 'package:flutter_app_2/screens/page_edit_fueling.dart';

class StartPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fuel app"),
      ),
      body: StartPageBody(),
    );
  }
}

class StartPageBody extends StatelessWidget {
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
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
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FlatButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PageEditFueling(
                                itemIndex: 1,
                                fueling: Fueling(100, 4.11, 411, 901231, false,
                                    DateTime.now(), DateTime.now()))),
                      );
                    },
                    color: Colors.green,
                    child: Text(
                      "Test",
                      style: TextStyle(fontSize: 20.0, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ))
      ],
    );
  }
}
