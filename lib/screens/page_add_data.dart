import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_2/localizations.dart';
import 'package:flutter_app_2/model/fuel_list_model.dart';
import 'package:flutter_app_2/model/fueling.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';

class PageAddData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[
      FormAdd(),
    ]);
  }
}

class FormAdd extends StatefulWidget {
  @override
  _FormAddState createState() => _FormAddState();
}

class _FormAddState extends State<FormAdd> {
  BuildContext _context;

  final _formKey = GlobalKey<FormState>();

  TextEditingController inputControllerOdometr = new TextEditingController();
  TextEditingController inputControllerPrice = new TextEditingController();
  TextEditingController inputControllerCost = new TextEditingController();
  TextEditingController inputControllerLiters = new TextEditingController();

  DateTime _dateStart;
  DateTime _timeStart;
  DateTime _fuelingDateTime = new DateTime.now();
  DateTime _createdDateTime = new DateTime.now();

  int _odometrState;
  double _price;
  double _cost;
  double _liters;

  bool _fullFueling = true;

  @override
  void initState() {
    _controllerListeners();
    _compareDateTime();
    super.initState();
  }

  void _controllerListeners() {
    inputControllerOdometr.addListener(() {
      if (inputControllerOdometr.text != null &&
          inputControllerOdometr.text != "" &&
          _odometrState != int.parse(inputControllerOdometr.text)) {
        setState(() {
          _odometrState = int.parse(inputControllerOdometr.text);
        });
      }
    });
    inputControllerPrice.addListener(() {
      if (inputControllerPrice.text != null &&
          inputControllerPrice.text != "" &&
          _price != double.parse(inputControllerPrice.text)) {
        setState(() {
          _price = double.parse(inputControllerPrice.text);
        });
      }
      _calcFuelingCost();
    });
    inputControllerCost.addListener(() {
      if (inputControllerCost.text != null &&
          inputControllerCost.text != "" &&
          _cost != double.parse(inputControllerCost.text)) {
        setState(() {
          _cost = double.parse(inputControllerCost.text);
        });
      }
    });
    inputControllerLiters.addListener(() {
      if (inputControllerLiters.text != null &&
          inputControllerLiters.text != "" &&
          _liters != double.parse(inputControllerLiters.text)) {
        setState(() {
          _liters = double.parse(inputControllerLiters.text);
        });
      }
      _calcFuelingCost();
    });
  }

  void _addItem() async {
    if (_liters != null &&
        _price != null &&
        _cost != null &&
        _odometrState != null &&
        _fuelingDateTime != null &&
        _createdDateTime != null) {
      final model = ScopedModel.of<FuelingListModel>(_context);

      Fueling _newItem = Fueling(_liters, _price, _cost, _odometrState, _fullFueling,
          _fuelingDateTime, _createdDateTime);

      model.add(_newItem);
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text('Error')));
    }

    await Scaffold.of(context).showSnackBar(SnackBar(content: Text('Saved')));
  }

  void dispose() {
    inputControllerOdometr.dispose();
    inputControllerPrice.dispose();
    inputControllerCost.dispose();
    inputControllerLiters.dispose();

    super.dispose();
  }

  void _compareDateTime() {
    print("Compare... ${_dateStart} ${_timeStart}");
    if (_dateStart != null && _timeStart != null) {
      setState(() {
        _fuelingDateTime = _dateStart.add(
            new Duration(hours: _timeStart.hour, minutes: _timeStart.minute));
      });
    }
  }

  void _calcFuelingCost() {
    if (_liters != null && _price != null) {
      setState(() {
        double cost = _liters * _price;
        _cost = cost;
        inputControllerCost.text = cost.toStringAsFixed(2);
      });
    }
  }

  Widget _sectionTitle(text) {
    return Text(
      text.toUpperCase(),
      style: TextStyle(fontSize: 15),
    );
  }

  Widget _sectionBody(children) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, children: children),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<FuelingListModel>(
        builder: (BuildContext context, child, model) {
      _context = context;

      return _build(_context, model);
    });
  }

  Widget _build(BuildContext context, FuelingListModel model) {
    return Column(
      children: <Widget>[
        Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.only(right: 20, left: 20, top: 10),
              child: Column(
                children: <Widget>[
                  _date(),
                  _odometr(context, model),
                  _costs(),
                  _fullFuelingCheckbox(),
//                  _formSectionDateTime(),
//                  SizedBox(height: 5),
//                  _fromSectionOdometr(context, model),
//                  SizedBox(height: 5),
//                  _fromSectionLiters(),
//                  SizedBox(height: 5),
//                  _formSectionFullFueling(),
                  SizedBox(height: 5),
                  _fromSubmit(),
                  SizedBox(height: 25),
                  _testing()
                ],
              ),
            )),
      ],
    );
  }

//  // Testing summary
  Widget _testing() {
    return Column(
      children: <Widget>[
        Text(_liters == null ? "liters" : "liters: $_liters"),
        Text(_price == null ? "price" : "price: $_price"),
        Text(_cost == null ? "cost" : "cost: $_cost"),
        Text(_odometrState == null ? "odometr" : "odometr: $_odometrState"),
        Text(_fullFueling == null ? "fullFueling" : "fullFueling: $_fullFueling"),
        Text(_fuelingDateTime == null
            ? "fuelingDateTime"
            : "fuelingDateTime: $_fuelingDateTime"),
        Text(_createdDateTime == null
            ? "createdDateTime"
            : "createdDateTime: $_createdDateTime"),
      ],
    );
  }

  Widget _date() {
    DateTime _currentValue = DateTime.now();

    final formatDate = DateFormat("yyyy-MM-dd");
    final formatTime = DateFormat("HH:mm");

    void _setDate(date) {
      setState(() {
        _dateStart = date;
      });
      _compareDateTime();
    }

    void _setTime(date) {
      setState(() {
        _timeStart = date;
      });
      _compareDateTime();
    }

    return _sectionBody(<Widget>[
      _sectionTitle(AppLocalizations.of(context).dateTime),
      Row(children: <Widget>[
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
                    lastDate: DateTime(2100),
                  );
                },
                validator: (date) => date == null ? 'Invalid date' : null,
                initialValue: _currentValue,
                onChanged: (date) => _setDate(date)),
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
                  TimeOfDay.fromDateTime(_currentValue ?? DateTime.now()),
                );
                return DateTimeField.convert(time);
              },
              validator: (date) => date == null ? 'Invalid date' : null,
              initialValue: _currentValue,
              onChanged: (date) => _setTime(date),
            ),
          ),
        ),
      ]),
    ]);
  }

  Widget _odometr(BuildContext context, FuelingListModel model) {
    return _sectionBody(<Widget>[
      _sectionTitle(AppLocalizations.of(context).odometr),
      TextFormField(
        controller: inputControllerOdometr,
        decoration: InputDecoration(labelText: '${AppLocalizations.of(context).odometr} ${AppLocalizations.of(context).state} [${model.fuelings.isNotEmpty ? model.fuelings.first.odometr.toString() : "No data yet :("}]'),
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value.isEmpty) {
            return 'State mustn\'t be null';
          }

          return null;
        },
      )
    ]);
  }

  Widget _costs() {
    return _sectionBody(<Widget>[
      _sectionTitle(AppLocalizations.of(context).price),
      Row(
        children: <Widget>[
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(right: 5),
              child: TextFormField(
                controller: inputControllerPrice,
                decoration: InputDecoration(labelText: 'pln/l'),
                keyboardType: TextInputType.number,
              ),
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(left: 5),
              child: TextFormField(
                controller: inputControllerLiters,
                decoration: InputDecoration(labelText: AppLocalizations.of(context).litres),
                keyboardType: TextInputType.number,
              ),
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(right: 5, left: 5),
              child: TextFormField(
                controller: inputControllerCost,
                decoration: InputDecoration(labelText: '${AppLocalizations.of(context).cost} [AUTO]'),
                keyboardType: TextInputType.number,
              ),
            ),
          )
        ],
      )
    ]);
  }

  Widget _fullFuelingCheckbox() {
    return _sectionBody(<Widget>[
      _sectionTitle(AppLocalizations.of(context).fullFueling),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(AppLocalizations.of(context).fullFueling, style: TextStyle(fontSize: 18)),
          Checkbox(
              value: _fullFueling,
              onChanged: (bool value) {
                setState(() {
                  _fullFueling = value;
                });
              })
        ],
      )
    ]);
  }

  Widget _fromSubmit() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        onPressed: () {
          if (_formKey.currentState.validate()) {
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text('Adding data...')));
            _addItem();
          }
        },
        child: Text('Submit'),
      ),
    );
  }

}
