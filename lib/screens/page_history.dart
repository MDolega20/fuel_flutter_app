import 'package:flutter/material.dart';


class PageHistory extends StatelessWidget {
  BuildContext _context;

  // temporary
  final List<String> items = List<String>.generate(10000, (i) => "Item $i");

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
//          Text(
//            "History",
//            style: TextStyle(fontSize: 30.0, color: Colors.red),
//          ),
          fuelingList()
        ]);
  }

  Widget fuelingList() {
    return Flexible(
        child: ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('${items[index]}'),
        );
      },
    ));
  }
}