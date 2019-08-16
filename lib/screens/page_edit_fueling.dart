import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
      body: EditFuelingBody(itemIndex), //TODO something font work here :/
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
    return Text("Form for item ${widget.itemIndex}");
  }

  Widget _date(BuildContext context, FuelingListModel model){

    //TODO temporary from strech

    final formatDate = DateFormat("yyyy-MM-dd");
    final formatTime = DateFormat("HH:mm");

    DateTime dateStart = new DateTime.now();
    DateTime timeStart = new DateTime.now();

    return Row(
      children: <Widget>[
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(right: 5),
            child: DateTimeField(
              format: formatDate,
              onShowPicker: (context, currentValue) {
                return showDatePicker(
                    context: context,
                    firstDate: DateTime(1900),
                    initialDate: currentValue ?? DateTime.now(),
                    lastDate: DateTime(2100));
              },
              validator: (date) => date == null ? 'Invalid date' : null,
              initialValue: dateStart,
              onChanged: (date) => {

              },
              onSaved: (date) => {

              },
            ),
          ),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(left: 5),
            child: DateTimeField(
              format: formatTime,
              onShowPicker: (context, currentValue) async {
                final time = await showTimePicker(
                  context: context,
                  initialTime:
                  TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                );
                return DateTimeField.convert(time);
              },
              validator: (date) => date == null ? 'Invalid date' : null,
              initialValue: timeStart,
              onChanged: (date) => {

              },
              onSaved: (date) => {

              },
            ),
          ),
        ),
      ],
    );
  }
}