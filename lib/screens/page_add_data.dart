import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//import 'package:intl/intl.dart';
//import 'package:datetime_picker_formfield/datetime_picker_formfield.dart'; // TODO DATETIME FORM

class PageAddData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
        children: <Widget>[
//          Center(
//            child: Text(
//              "Add new",
//              style: TextStyle(fontSize: 30.0, color: Colors.red),
//            ),
//          ),
      FormAdd(),
    ]);
  }
}

class FormAdd extends StatefulWidget {
  @override
  FormAddState createState() => FormAddState();
}

class FormAddState extends State<FormAdd> {
  final _formKey = GlobalKey<FormState>();

  double liters;
  double price;
  double cost;
  int odometr;

  bool fullFueling;

  var fuelingDate;
  var fuelingTime;

  double distance; // TODO nowDistance - prevDistance

  TextEditingController inputControllerDate = new TextEditingController();
  TextEditingController inputControllerTime = new TextEditingController();
  TextEditingController inputControllerOdometr = new TextEditingController();
  TextEditingController inputControllerPrice = new TextEditingController();
  TextEditingController inputControllerCost = new TextEditingController();
  TextEditingController inputControllerLiters = new TextEditingController();

  @override
  void initState() {
    super.initState();

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

    // TODO date and time
  }

  void dispose() {
    inputControllerOdometr.dispose();
    inputControllerPrice.dispose();
    inputControllerCost.dispose();
    inputControllerLiters.dispose();
    inputControllerDate.dispose();
    inputControllerTime.dispose();

    super.dispose();
  }

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: Column(
                children: <Widget>[
                  formSectionDateTime(),
                  SizedBox(height: 5),
                  fromSectionOdometr(),
                  SizedBox(height: 5),
                  fromSectionLiters(),
                  SizedBox(height: 5),
                  formSectionFullFueling(),
//                Padding(
//                  padding:
//                      const EdgeInsets.only(top: 10.0, left: 20, right: 20),
//                  child: TextFormField(
//                    autofocus: true,
//                    controller: input1controller,
//                    decoration:
//                        InputDecoration(labelText: 'How much you refueled (l)'),
//                    keyboardType: TextInputType.number,
//                    validator: (value) {
//                      if (value.isEmpty) {
//                        return 'Please enter number';
//                      }
//                      if (num.tryParse(value) == null) {
//                        return '"$value" is not a valid number';
//                      }
//                      return null;
//                    },
//                  ),
//                ),
//                Padding(
//                  padding:
//                      const EdgeInsets.only(top: 10.0, left: 20, right: 20),
//                  child: TextFormField(
//                    decoration: InputDecoration(
//                        labelText: 'Enter the price per liter (pln)'),
//                    keyboardType: TextInputType.number,
//                    controller: input2controller,
//                    validator: (value) {
//                      if (value.isEmpty) {
//                        return 'Please enter number';
//                      }
//                      if (num.tryParse(value) == null) {
//                        return '"$value" is not a valid number';
//                      }
//                      return null;
//                    },
//                  ),
//                ),
//                formSectionStart(),
//                formSectionEnd(),
                  const Divider(
                    height: 5.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: RaisedButton(
                      onPressed: () {
                        // Validate returns true if the form is valid, or false otherwise.
                        if (_formKey.currentState.validate()) {
                          // If the form is valid, display a Snackbar.
                          Scaffold.of(context).showSnackBar(
                              SnackBar(content: Text('Processing Data')));
                        }
                      },
                      child: Text('Submit'),
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }

//  Widget formSectionStart() {
//    return Padding(
//      padding: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 5),
//      child: Column(
//        children: <Widget>[
//          Text("Last fueling"),
//          Row(
//            children: <Widget>[
//              Flexible(
//                child: Padding(
//                  padding: EdgeInsets.only(right: 5),
//                  child: TextFormField(
//                    inputFormatters: [
//                      WhitelistingTextInputFormatter.digitsOnly
//                    ],
//                    decoration: InputDecoration(labelText: 'Mileage (km)'),
//                    style: TextStyle(fontSize: 14),
//                    keyboardType: TextInputType.number,
//                    controller: input4controller,
//                    validator: (value) {
//                      if (value.isEmpty) {
//                        return 'Please enter number';
//                      }
//                      if (num.tryParse(value) == null) {
//                        return '"$value" is not a valid number';
//                      }
//                      return null;
//                    },
//                  ),
//                ),
//              ),
//              Flexible(
//                // TODO temporary
//                child: Padding(
//                  padding: EdgeInsets.only(left: 5),
//                  child:
////                  DateTimeField(
////                    format: format,
////                    onShowPicker: (context, currentValue) {
////                      return showDatePicker(
////                          context: context,
////                          firstDate: DateTime(1900),
////                          initialDate: currentValue ?? DateTime.now(),
////                          lastDate: DateTime(2100));
////                    },
////                  ),
//                  TextFormField(
//                    inputFormatters: [
//                      WhitelistingTextInputFormatter.digitsOnly
//                    ],
//                    decoration: InputDecoration(labelText: 'Date-time'),
//                    style: TextStyle(fontSize: 14),
//                  ),
//                ),
//              ),
//            ],
//          ),
//        ],
//      ),
//    );
//  }
//
//  Widget formSectionEnd() {
//    return Padding(
//      padding: EdgeInsets.only(top: 10.0, left: 20, right: 20, bottom: 5),
//      child: Column(
//        children: <Widget>[
//          Text("Present fueling"),
//          Row(
//            children: <Widget>[
//              Flexible(
//                child: Padding(
//                  padding: EdgeInsets.only(right: 5),
//                  child: TextFormField(
//                    inputFormatters: [
//                      WhitelistingTextInputFormatter.digitsOnly
//                    ],
//                    decoration: InputDecoration(labelText: 'Mileage (km)'),
//                    style: TextStyle(fontSize: 14),
//                    keyboardType: TextInputType.number,
//                    controller: input5controller,
//                    validator: (value) {
//                      if (value.isEmpty) {
//                        return 'Please enter number';
//                      }
//                      if (num.tryParse(value) == null) {
//                        return '"$value" is not a valid number';
//                      }
//                      return null;
//                    },
//                  ),
//                ),
//              ),
//              Flexible(
//                // TODO temporary
//                child: Padding(
//                  padding: EdgeInsets.only(left: 5),
//                  child: TextFormField(
//                    inputFormatters: [
//                      WhitelistingTextInputFormatter.digitsOnly
//                    ],
//                    decoration: InputDecoration(labelText: 'Date-time'),
//                    style: TextStyle(fontSize: 14),
//                  ),
//                ),
//              ),
//            ],
//          ),
//        ],
//      ),
//    );
//  }

  Widget summary() {
    return Column(
      children: <Widget>[
        Text(liters == null ? "Brak danych" : "liczba litrów: $liters"),
        Text(price == null
            ? "Brak danych"
            : "kwota wydana: ${price * liters} pln"),
        Text(distance == null
            ? "Brak danych"
            : "cena za kilometr: ${price * liters / distance} pln"),
      ],
    );
  }

  Widget formSectionDateTime() {
    // TODO must do date and time inputs
    return Row(
      children: <Widget>[
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(right: 5),
            child: TextFormField(
//              autofocus: true,
              controller: inputControllerDate,
              decoration: InputDecoration(labelText: 'Date'),
            ),
          ),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(left: 5),
            child: TextFormField(
              controller: inputControllerTime,
              decoration: InputDecoration(labelText: 'Time'),
            ),
          ),
        ),
      ],
    );
  }

  Widget fromSectionOdometr() {
    return TextFormField(
      controller: inputControllerOdometr,
      decoration: InputDecoration(labelText: 'Odometr state'),
      keyboardType: TextInputType.number,
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
            value: true,
            onChanged: (bool value) {
              // TODO no controller :/
            })
      ],
    );
  }
}
