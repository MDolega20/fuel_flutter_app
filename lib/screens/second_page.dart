import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "Form page",
                style: TextStyle(fontSize: 30.0, color: Colors.red),
              ),
              FormNrOne(),
            ]),
      ),
    );
  }
}

class FormNrOne extends StatefulWidget {
  @override
  FormNrOneState createState() => FormNrOneState();
}

class FormNrOneState extends State<FormNrOne> {
  final _formKey = GlobalKey<FormState>();
  double liters;
  double price;
  double distance;

  TextEditingController input1controller = new TextEditingController();
  TextEditingController input2controller = new TextEditingController();
  TextEditingController input3controller = new TextEditingController();

  @override
  void initState() {
    super.initState();

    input1controller.addListener((){
    liters = double.parse(input1controller.text);
    });
    input2controller.addListener((){
    price = double.parse(input2controller.text);
    });
    input3controller.addListener((){
    distance = double.parse(input3controller.text);
    });
  }

  void dispose() {
    input1controller.dispose();
    input2controller.dispose();
    input3controller.dispose();
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
                Padding(
                  padding:
                  const EdgeInsets.only(top: 10.0, left: 20, right: 20),
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Enter distance from last refueling (km)'),
                    keyboardType: TextInputType.number,
                    controller: input3controller,
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
                const Divider(
                  height: 10.0,
                ),
                Column(
                  children: <Widget>[
                    Text(liters == null
                        ? "Brak danych"
                        : "liczba litrów: ${liters}"),
                    Text(price == null
                        ? "Brak danych"
                        : "kwota wydana: ${price * liters} pln"),
                    Text(distance == null
                        ? "Brak danych"
                        : "cena za kilometr: ${price * liters / distance} pln"),
                  ],
                )
              ],
            )),
      ],
    );
  }
}