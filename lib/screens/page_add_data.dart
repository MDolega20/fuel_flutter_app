import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//import 'package:intl/intl.dart';
//import 'package:datetime_picker_formfield/datetime_picker_formfield.dart'; // TODO DATETIME FORM

class PageAddData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView( // Column first
//        mainAxisAlignment: MainAxisAlignment.center,
//        crossAxisAlignment: CrossAxisAlignment.center,
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
  double distance;
  int meterStart;
  int meterStop;

  TextEditingController input1controller = new TextEditingController();
  TextEditingController input2controller = new TextEditingController();
  TextEditingController input4controller = new TextEditingController();
  TextEditingController input5controller = new TextEditingController();
  TextEditingController input6controller =
      new TextEditingController();

  void tryToCalculateDistance() {
    if (meterStart != null && meterStart != 0 && meterStop != null) {
      if (meterStop > meterStart) {
        setState(() {
          int dis = meterStop - meterStart;
          distance = dis.toDouble();
        });
      } else {
        setState(() {
          distance = null;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();

    input1controller.addListener(() {
      if (input1controller.text != null &&
          input1controller.text != "" &&
          liters != double.parse(input1controller.text)) {
        setState(() {
          liters = double.parse(input1controller.text);
        });
      }
    });
    input2controller.addListener(() {
      if (input2controller.text != null &&
          input2controller.text != "" &&
          price != double.parse(input2controller.text)) {
        setState(() {
          price = double.parse(input2controller.text);
        });
      }
    });
    input4controller.addListener(() {
      if (input4controller.text != null &&
          input4controller.text != "" &&
          meterStart != int.parse(input4controller.text)) {
        setState(() {
          meterStart = int.parse(input4controller.text);
        });
        tryToCalculateDistance();
      }
    });
    input5controller.addListener(() {
      if (input5controller.text != null &&
          input5controller.text != "" &&
          meterStop != int.parse(input5controller.text)) {
        setState(() {
          meterStop = int.parse(input5controller.text);
        });
        tryToCalculateDistance();
      }
    });
  }

  void dispose() {
    input1controller.dispose();
    input2controller.dispose();
    input4controller.dispose();
    input5controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 20, right: 20),
                  child: TextFormField(
                    autofocus: true,
                    controller: input1controller,
                    decoration:
                        InputDecoration(labelText: 'How much you refueled (l)'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter number';
                      }
                      if (num.tryParse(value) == null) {
                        return '"$value" is not a valid number';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 20, right: 20),
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Enter the price per liter (pln)'),
                    keyboardType: TextInputType.number,
                    controller: input2controller,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter number';
                      }
                      if (num.tryParse(value) == null) {
                        return '"$value" is not a valid number';
                      }
                      return null;
                    },
                  ),
                ),
                formSectionStart(),
                formSectionEnd(),
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
//                const Divider(
//                  height: 10.0,
//                ),
//                summary()
              ],
            )),
      ],
    );
  }

  Widget formSectionStart() {
    return Padding(
      padding: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 5),
      child: Column(
        children: <Widget>[
          Text("Last fueling"),
          Row(
            children: <Widget>[
              Flexible(
                child: Padding(
                  padding: EdgeInsets.only(right: 5),
                  child: TextFormField(
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly
                    ],
                    decoration: InputDecoration(labelText: 'Mileage (km)'),
                    style: TextStyle(fontSize: 14),
                    keyboardType: TextInputType.number,
                    controller: input4controller,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter number';
                      }
                      if (num.tryParse(value) == null) {
                        return '"$value" is not a valid number';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              Flexible(
                // TODO temporary
                child: Padding(
                  padding: EdgeInsets.only(left: 5),
                  child:
//                  DateTimeField(
//                    format: format,
//                    onShowPicker: (context, currentValue) {
//                      return showDatePicker(
//                          context: context,
//                          firstDate: DateTime(1900),
//                          initialDate: currentValue ?? DateTime.now(),
//                          lastDate: DateTime(2100));
//                    },
//                  ),
                      TextFormField(
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly
                    ],
                    decoration: InputDecoration(labelText: 'Date-time'),
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget formSectionEnd() {
    return Padding(
      padding: EdgeInsets.only(top: 10.0, left: 20, right: 20, bottom: 5),
      child: Column(
        children: <Widget>[
          Text("Present fueling"),
          Row(
            children: <Widget>[
              Flexible(
                child: Padding(
                  padding: EdgeInsets.only(right: 5),
                  child: TextFormField(
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly
                    ],
                    decoration: InputDecoration(labelText: 'Mileage (km)'),
                    style: TextStyle(fontSize: 14),
                    keyboardType: TextInputType.number,
                    controller: input5controller,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter number';
                      }
                      if (num.tryParse(value) == null) {
                        return '"$value" is not a valid number';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              Flexible(
                // TODO temporary
                child: Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: TextFormField(
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly
                    ],
                    decoration: InputDecoration(labelText: 'Date-time'),
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

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
}
