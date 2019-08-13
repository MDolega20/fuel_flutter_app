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
//    _test();
    _save();
  }

  void _test(){
    setState(() => _fuelings.add(new Fueling(100, 500, 200, 3542353, true, DateTime.now(),  DateTime.now())));
    setState(() => _fuelings.add(new Fueling(100, 500, 200, 3542353, true, DateTime.now(),  DateTime.now())));
    setState(() => _fuelings.add(new Fueling(100, 500, 200, 3542353, true, DateTime.now(),  DateTime.now())));
    setState(() => _fuelings.add(new Fueling(100, 500, 200, 3542353, true, DateTime.now(),  DateTime.now())));
    setState(() => _fuelings.add(new Fueling(100, 500, 200, 3542353, true, DateTime.now(),  DateTime.now())));
  }

  void _save() => _presisitor.save(_fuelings);

  void _load() =>
      _presisitor.load().then((data) => setState(() => _fuelings = data));

  void _deleteItem(BuildContext context, int index) async {
    bool result = await showDialog(
        context: context, builder: (BuildContext context) => Text("Usunieto"));

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
              key: ObjectKey(
                  _fuelings[i]),
              itemData: _fuelings[i],
//              onTap: () => _deleteItem(context, i),
              onDelete: () => _deleteItem(context, i),
            )
    ) : _buildPlaceholder(context);
  }

  Widget _buildPlaceholder(BuildContext context) {
    return Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          SizedBox(height: 24.0),
          Text("Brak danych")
        ]));
  }
}