import 'package:flutter/material.dart';
import 'package:flutter_app_2/model/fuel_list_model.dart';
import 'package:scoped_model/scoped_model.dart';

class PageEditFueling extends StatelessWidget{
  BuildContext _context;

  PageEditFueling({this.itemIndex});

  final int itemIndex;

  @override
  Widget build(BuildContext context) {
    return _build(context);
  }

  Widget _build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit item id $itemIndex"),
      ),
      body: EditFuelingBody({itemIndex: itemIndex}), //TODO something font work here :/
    );
  }
}

class EditFuelingBody extends StatefulWidget{

  @override
  _EditFuelingBodyState createState() => _EditFuelingBodyState();

  EditFuelingBody({this.itemIndex});

  final int itemIndex;
}

class _EditFuelingBodyState extends State<EditFuelingBody>{
  BuildContext _context;


  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<FuelingListModel>(
        builder: (BuildContext context, child, model) {
          _context = context;

          return _build(context, model);
        });
  }

  Widget _build(BuildContext context, FuelingListModel model){
    return Text("Form for item $itemIndex");
  }
}