import 'package:flutter/material.dart';
import 'package:flutter_app_2/model/fueling.dart';
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
              onDelete: () => _deleteItem(context, i),
            )
    )
  }

  Widget _buildPlaceholder(BuildContext context) {
    return Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          SizedBox(
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.80,
              child: Image.asset('assets/placeholder.png')),
          SizedBox(height: 24.0),
          Text(AppLocalizations
              .of(context)
              .purchasesPlaceholder,
              style: TextStyle(fontSize: 16.0))
        ]));
  }
}

//class ShoppingListPage extends StatefulWidget {
//  @override
//  _ShoppingListPageState createState() => _ShoppingListPageState();
//}
//
//class _ShoppingListPageState extends State<ShoppingListPage> {
//  List<Fueling> _fuelings = [];
//  Persistor _persistor = Persistor();
//
//  @override
//  void initState() {
//    super.initState();
//
//    _persistor.load().then((data) => setState(() => _fuelings = data));
//  }
//
//  void _save() {
//    _persistor.save(_fuelings);
//  }
//
////  void _addPurchase(BuildContext context) async {
////    String name = await showDialog(
////        context: context, builder: (BuildContext context) => PurchaseDialog());
////
////    if (name == null) return;
////
////    setState(() {
////      _purchases.add(Purchase(name));
////    });
////    _save();
////  }
////
////
//  void _deleteFueling(BuildContext context, int index) async {
//    bool result = await showDialog(
//        context: context, builder: (BuildContext context) => Text("Usunieto"));
//
//    if (result == true) {
//      setState(() => _fuelings.removeAt(index));
//    }
//    _save();
//  }
////
////  void _deleteAllPurchases(BuildContext context) async {
////    bool result = await showDialog(
////        context: context,
////        builder: (BuildContext context) => ConfirmDialog(all: true));
////
////    if (result == true) {
////      setState(() => _purchases.clear());
////    }
////    _save();
////  }
//
////  @override
////  Widget build(BuildContext context) {
////    return _fuelings.isNotEmpty
////        ? ListView.builder(
////        padding: EdgeInsets.symmetric(vertical: 16.0),
////        itemCount: _fuelings.length,
////        itemBuilder: (BuildContext context, int i) => FuelingListItem(
////            key: ObjectKey(_fuelings[i]),
////            fueling: _fuelings[i];
//////            onTap: () => _togglePurchase(i),
//////            onDelete: () => _deleteFueling(context, i)));
////  }
////
////  Widget _buildPlaceholder(BuildContext context) {
////    return Center(
////        child: Column(mainAxisSize: MainAxisSize.min, children: [
////          SizedBox(
////              width: MediaQuery.of(context).size.width * 0.80,
////              child: Image.asset('assets/placeholder.png')),
////          SizedBox(height: 24.0),
////          Text(AppLocalizations.of(context).purchasesPlaceholder,
////              style: TextStyle(fontSize: 16.0))
////        ]));
////  }
//}
