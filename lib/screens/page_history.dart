import 'package:flutter/material.dart';

class PageHistory extends StatelessWidget {
  BuildContext _context;


  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            "History",
            style: TextStyle(fontSize: 30.0, color: Colors.red),
          ),
//          FormNrOne(),
        ]);
  }
}