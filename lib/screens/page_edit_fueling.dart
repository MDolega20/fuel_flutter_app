import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_2/model/fueling.dart';
import 'package:intl/intl.dart';
import 'package:flutter_app_2/model/fuel_list_model.dart';
import 'package:scoped_model/scoped_model.dart';

class PageEditFueling extends StatelessWidget {
  BuildContext _context;

  PageEditFueling({@required this.itemIndex, this.fueling});

  final int itemIndex;
  final Fueling fueling;

  void _updateItem() async {
    final model = ScopedModel.of<FuelingListModel>(_context);
    //TODO sending a edited object from EditFuelingBody
    model.update(itemIndex, fueling);
    //TODO figure out why this is not working and give mi error
    //ERROR HERE
    //    E/flutter ( 4594): [ERROR:flutter/lib/ui/ui_dart_state.cc(148)] Unhandled Exception: Scaffold.of() called with a context that does not contain a Scaffold.
    //    E/flutter ( 4594): No Scaffold ancestor could be found starting from the context that was passed to Scaffold.of(). This usually happens when the context provided is from the same StatefulWidget as that whose build function actually creates the Scaffold widget being sought.
    //    E/flutter ( 4594): There are several ways to avoid this problem. The simplest is to use a Builder to get a context that is "under" the Scaffold. For an example of this, please see the documentation for Scaffold.of():
    //    E/flutter ( 4594):   https://api.flutter.dev/flutter/material/Scaffold/of.html
    //    E/flutter ( 4594): A more efficient solution is to split your build function into several widgets. This introduces a new context from which you can obtain the Scaffold. In this solution, you would have an outer widget that creates the Scaffold populated by instances of your new inner widgets, and then in these inner widgets you would use Scaffold.of().
    //    E/flutter ( 4594): A less elegant but more expedient solution is assign a GlobalKey to the Scaffold, then use the key.currentState property to obtain the ScaffoldState rather than using the Scaffold.of() function.
    //    Scaffold.of(_context).showSnackBar(SnackBar(content: Text('Saved')));
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
        title: Text("Edit item 1"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              _updateItem();
            },
          )
        ],
      ),
      body: EditFuelingBody(itemIndex: itemIndex, fueling: fueling),
    );
  }
}

class EditFuelingBody extends StatefulWidget {
  EditFuelingBody({@required this.itemIndex, this.fueling});

  final int itemIndex;
  final Fueling fueling;

  @override
  _EditFuelingBodyState createState() => _EditFuelingBodyState();
}

class _EditFuelingBodyState extends State<EditFuelingBody> {
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
    setState(() {
      double cost = _liters * _price;
      _cost = cost;
      inputControllerCost.text = cost.toStringAsFixed(2);
    });
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

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<FuelingListModel>(
        builder: (BuildContext context, child, model) {
      _context = context;

      return _build(context, model);
    });
  }

  Widget _build(BuildContext context, FuelingListModel model) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      child: Column(
        children: <Widget>[_date(), _odometr(), _costs(), _fullFuelingCheckbox(), _testing()],
      ),
    );
  }

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
      _sectionTitle("Date and time"),
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
                      lastDate: DateTime(2100));
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
        ))
      ]),
    ]);
  }

  Widget _odometr() {
    return _sectionBody(<Widget>[
      _sectionTitle("Odometr"),
      TextFormField(
        controller: inputControllerOdometr,
        decoration: InputDecoration(labelText: 'Odometr state'),
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
      _sectionTitle("Price"),
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
                decoration: InputDecoration(labelText: 'liters'),
                keyboardType: TextInputType.number,
              ),
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(right: 5, left: 5),
              child: TextFormField(
                controller: inputControllerCost,
                decoration: InputDecoration(labelText: 'cost [AUTO]'),
                keyboardType: TextInputType.number,
              ),
            ),
          )
        ],
      )
    ]);
  }

  Widget _fullFuelingCheckbox(){
    return _sectionBody(<Widget>[
        _sectionTitle("Full fueling"),
    Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
        Text("Full fueling", style: TextStyle(fontSize: 18)),
    Checkbox(
    value: _fullFueling,
    onChanged: (bool value) {
    setState(() {
    _fullFueling = value;
    });
    })
    ],
    )]);
  }

  Widget _testing() {
    return Column(
      children: <Widget>[
        Text(_fueling.liters == null ? "liters" : "liters: ${_fueling.liters}"),
        Text(_fueling.price == null ? "price" : "price: ${_fueling.price}"),
        Text(_fueling.cost == null ? "cost" : "cost: ${_fueling.cost}"),
        Text(_fueling.odometr == null
            ? "odometr"
            : "odometr: ${_fueling.odometr}"),
        Text(_fueling.fullFueling == null
            ? "fullFueling"
            : "fullFueling: ${_fueling.fullFueling}"),
        Text(_fueling.fuelingDateTime == null
            ? "fuelingDateTime"
            : "fuelingDateTime: ${_fueling.fuelingDateTime}"),
        Text(_fueling.createdDateTime == null
            ? "createdDateTime"
            : "createdDateTime: ${_fueling.createdDateTime}"),
      ],
    );
  }
}
