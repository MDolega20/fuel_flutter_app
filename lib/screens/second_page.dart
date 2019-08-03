import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
                "Add new",
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
  int meterStart;
  int meterStop;

  TextEditingController input1controller = new TextEditingController();
  TextEditingController input2controller = new TextEditingController();
  TextEditingController input3controller = new TextEditingController();
  TextEditingController input4controller = new TextEditingController();
  TextEditingController input5controller = new TextEditingController();
  TextEditingController input6controller =
      new TextEditingController(); // TODO not used

  void tryToCalculateDistance() {
    print("S: $meterStart E: $meterStop");
    if (meterStart != null && meterStart != 0 && meterStop != null) {
      if (meterStop > meterStart) {
        setState(() {
          int dis = meterStop - meterStart;
          print("D: $dis");
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
    input3controller.addListener(() {
      if (input3controller.text != null &&
          input3controller.text != "" &&
          distance != double.parse(input3controller.text)) {
        setState(() {
          distance = double.parse(input3controller.text);
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
                formSectionTop(),
//                Padding(
//                  padding:
//                      const EdgeInsets.only(top: 10.0, left: 20, right: 20),
//                  child: TextFormField(
//                    inputFormatters: [
//                      WhitelistingTextInputFormatter.digitsOnly
//                    ],
//                    decoration: InputDecoration(
//                        labelText: 'Enter distance from last refueling (km)'),
//                    keyboardType: TextInputType.number,
//                    controller: input3controller,
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
                Row(
                  children: <Widget>[
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.only(top: 10.0, left: 20, right: 5),
                        child: TextFormField(
                          inputFormatters: [
                            WhitelistingTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                              labelText: 'Enter meter start state (km)'),
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
                      child: Padding(
                        padding: EdgeInsets.only(top: 10.0, right: 20, left: 5),
                        child: TextFormField(
                          inputFormatters: [
                            WhitelistingTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                              labelText: 'Enter meter end state (km)'),
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
                  ],
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
                        : "liczba litrów: $liters"),
                    Text(price == null
                        ? "Brak danych"
                        : "kwota wydana: ${price * liters} pln"),
                    Text(distance == null
                        ? "Brak danych"
                        : "cena za kilometr: ${price * liters / distance} pln"),
                  ],
                ),
              ],
            )),
      ],
    );
  }

  Widget formSectionTop() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 10.0, left: 20, right: 20),
          child: TextFormField(
            autofocus: true,
            controller: input1controller,
            decoration: InputDecoration(labelText: 'How much you refueled (l)'),
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
          padding: const EdgeInsets.only(top: 10.0, left: 20, right: 20),
          child: TextFormField(
            decoration:
                InputDecoration(labelText: 'Enter the price per liter (pln)'),
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
      ],
    );
  }

  Widget formSectionStart() {
    return Text("aegaeg");
  }
}
