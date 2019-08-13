import 'package:flutter/material.dart';
import 'package:flutter_app_2/widgets/fueling.dart';
import 'package:flutter_app_2/persistor.dart';
import 'package:flutter_app_2/widgets/fueling_list_item.dart';

class FuelingList extends StatefulWidget {
  @override
  _FuelingListState createState() => _FuelingListState();
}

class _FuelingListState extends State<FuelingList> {
  List<Fueling> _fuelings = [];
  Persistor _presisitor = Persistor();

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _test() {
    setState(() {
      for (int i = 0; i < 10; i++) {
        _fuelings.add(new Fueling(
            100,
            500,
            200,
            3542353 + i,
            true,
            DateTime.now(),
            DateTime.now()));
      }
    });
  }

  void _save() => _presisitor.save(_fuelings);

  void _load() async {
    await _presisitor.load().then((data) => setState(() => _fuelings = data));
//  await _test();
//  await _save();
  }

  void _dismissDialog(response) {
    Navigator.pop(context, response);
  }

  void _deleteItem(BuildContext context, int index) async {
    bool result = await showDialog(
        context: context,
        builder: (BuildContext context) =>
            AlertDialog(
              title: Text("Usuwanie tankowania"),
              content: Text("Czy chcesz napewno usunąć tankowanie?"),
              actions: <Widget>[
                FlatButton(
                  onPressed: () => _dismissDialog(false),
                  child: Text("Nie"),
                ),
                FlatButton(
                  onPressed: () => _dismissDialog(true),
                  child: Text("Tak, oczywiście"),
                )
              ],
            )
    );

    if (result == true) {
      setState(() => _fuelings.removeAt(index));
    }
    _save();
  }

  @override
  Widget build(BuildContext context) {
    return _fuelings.isNotEmpty
        ? ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        itemCount: _fuelings.length,
        itemBuilder: (BuildContext context, int i) =>
            FuelingListItem(
              key: ObjectKey(_fuelings[i]),
              itemData: _fuelings[i],
              onTap: () => _deleteItem(context, i),
              onDelete: () => _deleteItem(context, i),
            ))
        : _buildPlaceholder(context);
  }

  Widget _buildPlaceholder(BuildContext context) {
    return Center(
        child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [SizedBox(height: 24.0), Text("Brak danych")]));
  }

//  Widget _deleteDialog() {
//    return AlertDialog(
//      title: Text("Usuwanie tankowania"),
//      content: Text("Czy chcesz napewno usunąć tankowanie?"),
//      actions: <Widget>[
//        FlatButton(
//          onPressed: () => _dismissDialog(false),
//          child: Text("Nie"),
//        ),
//        FlatButton(
//          onPressed: () => _dismissDialog(true),
//          child: Text("Tak, oczywiście"),
//        )
//      ],
//    );
//  }
}
