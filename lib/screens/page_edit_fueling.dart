import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_2/localizations.dart';
import 'package:flutter_app_2/model/fueling.dart';
import 'package:intl/intl.dart';
import 'package:flutter_app_2/model/fuel_list_model.dart';
import 'package:scoped_model/scoped_model.dart';

class PageEditFueling extends StatefulWidget {
  PageEditFueling({@required this.itemIndex, this.fueling});

  final int itemIndex;
  final Fueling fueling;

  @override
  _PageEditFueling createState() => _PageEditFueling();
}

class _PageEditFueling extends State<PageEditFueling> {
  BuildContext _context;

  Fueling _fueling;

  DateTime _dateStart;
  DateTime _timeStart;
  DateTime _fuelingDateTime;

  int _odometrState;
  double _price;
  double _cost;
  double _liters;

  bool _fullFueling;

  TextEditingController inputControllerOdometr = new TextEditingController();
  TextEditingController inputControllerPrice = new TextEditingController();
  TextEditingController inputControllerCost = new TextEditingController();
  TextEditingController inputControllerLiters = new TextEditingController();

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
  void initState() {
    //SET default data
    setState(() {
      _fueling = widget.fueling;
    });
    _controllerListeners();
    _getInitialData();
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

  void _compareDateTime() {
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

  void _getInitialData() {
    setState(() {
      inputControllerOdometr.text = _fueling.odometr.toString();
      inputControllerCost.text = _fueling.cost.toString();
      inputControllerPrice.text = _fueling.price.toString();
      inputControllerLiters.text = _fueling.liters.toString();

      _fullFueling = _fueling.fullFueling;
    });
  }

  void _updateItem() async {
    final model = ScopedModel.of<FuelingListModel>(_context);

    Fueling _fuelingChanged = Fueling(
        _liters != null ? _liters : widget.fueling.liters,
        _price != null ? _price : widget.fueling.price,
        _cost != null ? _cost : widget.fueling.cost,
        _odometrState != null ? _odometrState : widget.fueling.odometr,
        _fullFueling != null ? _fullFueling : widget.fueling.fullFueling,
        _fuelingDateTime != null ? _fuelingDateTime : widget.fueling.fuelingDateTime,
        widget.fueling.createdDateTime);

    model.update(widget.itemIndex, _fuelingChanged);
    Navigator.pop(_context);
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return _build(context);
  }

  Widget _build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit item"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              _updateItem();
            },
          ),
        ],
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        child: Column(
          children: <Widget>[
            _date(),
            _odometr(),
            _costs(),
            _fullFuelingCheckbox(),
          ],
        ),
      ),
    );
  }

  //TODO this form widgets [must move to another class and share with add_data_form class]
  Widget _date() {
    DateTime _currentValue = _fueling.fuelingDateTime;

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

  Widget _odometr() {
    return _sectionBody(<Widget>[
      _sectionTitle(AppLocalizations.of(context).odometr),
      TextFormField(
        controller: inputControllerOdometr,
        decoration: InputDecoration(labelText: '${AppLocalizations.of(context).odometr} ${AppLocalizations.of(context).state}'),
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

}