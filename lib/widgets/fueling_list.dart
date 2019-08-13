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
//    _resetList();
  }

  void _save() => _presisitor.save(_fuelings);

  void _load() async {
    await _presisitor.load().then((data) => setState(() => _fuelings = data));
    await _sortByDate();
  }

  void _sortByDate(){
    _fuelings.forEach((f) => print(f.fuelingDateTime));

    _fuelings.sort((a,b) {
      DateTime date1 = a.fuelingDateTime;
      DateTime date2 = b.fuelingDateTime;
      return date2.compareTo(date1);
    });

    _fuelings.forEach((f) => print(f.fuelingDateTime));
  }

  void _resetList(){
    _fuelings = [];
    _save();
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
              prevItemData: i  < _fuelings.length - 1 ? _fuelings[i + 1] : null,
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