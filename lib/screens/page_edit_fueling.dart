import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_2/model/fueling.dart';
import 'package:intl/intl.dart';
import 'package:flutter_app_2/model/fuel_list_model.dart';
import 'package:scoped_model/scoped_model.dart';

class PageEditFueling extends StatelessWidget{
  BuildContext _context;

  PageEditFueling({@required this.itemIndex, this.fueling});

  final int itemIndex;
  final Fueling fueling;

  @override
  Widget build(BuildContext context) {
    return _build(context);
  }

  Widget _build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit item index $itemIndex"),
      ),
//      body: null,
      body: EditFuelingBody(itemIndex: itemIndex, fueling: fueling), //TODO something font work here :/
    );
  }
}

class EditFuelingBody extends StatefulWidget{

  EditFuelingBody({@required this.itemIndex, this.fueling});

  final int itemIndex;
  final Fueling fueling;

  @override
  _EditFuelingBodyState createState() => _EditFuelingBodyState();

}

class _EditFuelingBodyState extends State<EditFuelingBody>{
  BuildContext _context;

  Fueling _fueling;

  DateTime _dateStart;
  DateTime _timeStart;

  @override
  void initState() {
    //SET default data
    setState(() {
      _fueling = widget.fueling;
    });
    super.initState();
  }

  void _compareDateTime() {
    if (_dateStart != null && _timeStart != null) {
      setState(() {
        _fueling.fuelingDateTime = _dateStart.add(
            new Duration(hours: _timeStart.hour, minutes: _timeStart.minute));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<FuelingListModel>(
        builder: (BuildContext context, child, model) {
          _context = context;

          return _build(context, model);
        });
  }

  Widget _build(BuildContext context, FuelingListModel model){
    return Column(
      children: <Widget>[
        Text("Form for item ${widget.itemIndex}"),
      ],
    );
  }

  Widget _date(){

    //TODO temporary from strech

    // TODO get TimeDate and make date and time

//    setState(() {
//      fuelingDateTime = dateStart.add(
//          new Duration(hours: timeStart.hour, minutes: timeStart.minute));
//    });

    DateTime _currentValue = _fueling.fuelingDateTime;

    final formatDate = DateFormat("yyyy-MM-dd");
    final formatTime = DateFormat("HH:mm");

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
                    initialDate: _currentValue ?? DateTime.now(),
                    lastDate: DateTime(2100));
              },
              validator: (date) => date == null ? 'Invalid date' : null,
              initialValue: _dateStart,
              onChanged: (date) => _compareDateTime()
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
                  initialTime: TimeOfDay.fromDateTime(_currentValue ?? DateTime.now()),
                );
                return DateTimeField.convert(time);
              },
              validator: (date) => date == null ? 'Invalid date' : null,
              initialValue: _timeStart,
              onChanged: (date) => _compareDateTime()
            ),
          ),
        ),
      ],
    );
  }

  Widget _odometr(){
    return Text("Odometr widget");
  }

  Widget _liters(){
      return Text("Liters widget");
  }
}