import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  double liters;
  double price;
  double cost;
  int odometr;

  bool fullFueling = true;

  DateTime fuelingDateTime;
  DateTime createdDateTime = new DateTime.now();

  TextEditingController inputControllerOdometr = new TextEditingController();
  TextEditingController inputControllerPrice = new TextEditingController();
  TextEditingController inputControllerCost = new TextEditingController();
  TextEditingController inputControllerLiters = new TextEditingController();

  DateTime dateStart = new DateTime.now();
  DateTime timeStart = new DateTime.now();

  @override
  void initState() {
    super.initState();
    _controllerListeners();
    _compareDateTime();
  }

  void _addItem() async {
    if (liters != null &&
        price != null &&
        cost != null &&
        odometr != null &&
        fuelingDateTime != null &&
        createdDateTime != null) {

      final model = ScopedModel.of<FuelingListModel>(_context);

      Fueling _newItem = Fueling(liters, price, cost, odometr, fullFueling,
          fuelingDateTime, createdDateTime);

      model.add(_newItem);

    } else {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text('Error')));
    }

    await Scaffold.of(context).showSnackBar(SnackBar(content: Text('Saved')));
  }

  void _controllerListeners() {
    inputControllerOdometr.addListener(() {
      if (inputControllerOdometr.text != null &&
          inputControllerOdometr.text != "" &&
          odometr != int.parse(inputControllerOdometr.text)) {
        setState(() {
          odometr = int.parse(inputControllerOdometr.text);
        });
      }
    });
    inputControllerPrice.addListener(() {
      if (inputControllerPrice.text != null &&
          inputControllerPrice.text != "" &&
          price != double.parse(inputControllerPrice.text)) {
        setState(() {
          price = double.parse(inputControllerPrice.text);
        });
      }
    });
    inputControllerCost.addListener(() {
      if (inputControllerCost.text != null &&
          inputControllerCost.text != "" &&
          cost != double.parse(inputControllerCost.text)) {
        setState(() {
          cost = double.parse(inputControllerCost.text);
        });
      }
    });
    inputControllerLiters.addListener(() {
      if (inputControllerLiters.text != null &&
          inputControllerLiters.text != "" &&
          liters != double.parse(inputControllerLiters.text)) {
        setState(() {
          liters = double.parse(inputControllerLiters.text);
        });
      }
    });
  }

  void _compareDateTime() {
    if (dateStart != null && timeStart != null) {
      setState(() {
        fuelingDateTime = dateStart.add(
            new Duration(hours: timeStart.hour, minutes: timeStart.minute));
      });
    }
  }

  void _calcLiters() {
    if (inputControllerLiters.text == "" &&
        inputControllerPrice.text != "" &&
        inputControllerCost.text != "") {
      setState(() {
        double result = cost / price;
        inputControllerLiters.text = result.toString();
        liters = result;
      });
    } else if (inputControllerLiters.text != "" &&
        inputControllerPrice.text == "" &&
        inputControllerCost.text != "") {
      setState(() {
        double result = cost / liters;
        inputControllerPrice.text = result.toString();
        price = result;
      });
    } else if (inputControllerLiters.text != "" &&
        inputControllerPrice.text != "" &&
        inputControllerCost.text == "") {
      setState(() {
        double result = price * liters;
        inputControllerCost.text = result.toString();
        cost = result;
      });
    }
  }

  void dispose() {
    inputControllerOdometr.dispose();
    inputControllerPrice.dispose();
    inputControllerCost.dispose();
    inputControllerLiters.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<FuelingListModel>(
        builder: (BuildContext context, child, model) {
          _context = context;

          return _build(context, model);
        }
    );
  }

  Widget _build(BuildContext context, FuelingListModel model){
    return Column(
      children: <Widget>[
        Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.only(right: 20, left: 20, top: 10),
              child: Column(
                children: <Widget>[
                  formSectionDateTime(),
                  SizedBox(height: 5),
                  fromSectionOdometr(context, model),
                  SizedBox(height: 5),
                  fromSectionLiters(),
                  SizedBox(height: 5),
                  formSectionFullFueling(),
                  SizedBox(height: 5),
                  fromSubmit(),
                  SizedBox(height: 25),
                  testing()
                ],
              ),
            )),
      ],
    );
  }

  // Testing summary
  Widget testing() {
    return Column(
      children: <Widget>[
        Text(liters == null ? "liters" : "liters: $liters"),
        Text(price == null ? "price" : "price: $price"),
        Text(cost == null ? "cost" : "cost: $cost"),
        Text(odometr == null ? "odometr" : "odometr: $odometr"),
        Text(fullFueling == null ? "fullFueling" : "fullFueling: $fullFueling"),
        Text(fuelingDateTime == null
            ? "fuelingDateTime"
            : "fuelingDateTime: $fuelingDateTime"),
        Text(createdDateTime == null
            ? "createdDateTime"
            : "createdDateTime: $createdDateTime"),
      ],
    );
  }

  Widget formSectionDateTime() {
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
                    initialDate: currentValue ?? DateTime.now(),
                    lastDate: DateTime(2100));
              },
              validator: (date) => date == null ? 'Invalid date' : null,
              initialValue: dateStart,
              onChanged: (date) => {
                if (dateStart != date)
                  {
                    setState(() {
                      dateStart = date;
                    }),
                    _compareDateTime()
                  }
              },
              onSaved: (date) => {
                if (dateStart != date)
                  {
                    setState(() {
                      dateStart = date;
                    }),
                    _compareDateTime()
                  }
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
                if (timeStart != date)
                  {
                    setState(() {
                      timeStart = date;
                    }),
                    _compareDateTime()
                  }
              },
              onSaved: (date) => {
                if (timeStart != date)
                  {
                    setState(() {
                      timeStart = date;
                    }),
                    _compareDateTime()
                  }
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget fromSectionOdometr(BuildContext context, FuelingListModel model) {
    return TextFormField(
      controller: inputControllerOdometr,
      decoration: InputDecoration(
          labelText: 'Odometr state [last: ${model.fuelings.first.odometr}]'),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value.isEmpty) {
          return 'State mustn\'t be null';
        }
        if (model.fuelings.isNotEmpty) {
          if (int.parse(value) < model.fuelings.first.odometr) {
            //TODO fix that
            return 'State is lower than before';
          }
        }

        return null;
      },
    );
  }

  Widget fromSectionLiters() {
    return Row(
      children: <Widget>[
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(right: 5),
            child: TextFormField(
              controller: inputControllerPrice,
              decoration: InputDecoration(labelText: 'pln/l'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value == "") {
                  _calcLiters;
                }
                return null;
              },
            ),
          ),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(right: 5, left: 5),
            child: TextFormField(
              controller: inputControllerCost,
              decoration: InputDecoration(labelText: 'cost'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value == "") {
                  _calcLiters;
                }
                return null;
              },
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
              validator: (value) {
                if (value == null || value == "") {
                  _calcLiters;
                }
                return null;
              },
            ),
          ),
        )
      ],
    );
  }

  Widget formSectionFullFueling() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text("Full fueling", style: TextStyle(fontSize: 18)),
        Checkbox(
            value: fullFueling,
            onChanged: (bool value) {
              setState(() {
                fullFueling = value;
              });
            })
      ],
    );
  }

  Widget fromSubmit() {
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
