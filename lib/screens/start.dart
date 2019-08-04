import 'package:flutter/material.dart';
import 'package:flutter_app_2/screens/main.dart';
//import 'package:flutter_app_2/screens/page_add_data.dart';

// TODo CHECK THIS https://flutter.dev/docs/catalog/samples/basic-app-bar

class StartPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fuel app"),
//        actions: <Widget>[
//          IconButton(
////            onPressed: () {
////              print("nacisnieto xd");
//////                _select(choices[0]);
////            },
//          ),
////            menu()
//        ],
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
          child: FlatButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MainTabs()),
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
