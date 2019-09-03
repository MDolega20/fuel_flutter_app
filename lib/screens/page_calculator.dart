import 'package:flutter/material.dart';
import 'package:flutter_app_2/localizations.dart';

class PageCalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            "Calculator",
            style: TextStyle(fontSize: 30.0, color: Colors.red),
          ),
//          FormNrOne(),
        ]);
  }
}

class Calculator extends StatefulWidget {

  @override
  _Calculator createState() => _Calculator();
}

class _Calculator extends State<Calculator> {

  TextEditingController inputControllerLiters = new TextEditingController();
  TextEditingController inputControllerCost = new TextEditingController();
  TextEditingController inputControllerPrice = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        //TODO calculator widgets here
      ],
    );
  }

  Widget _secLiters() {
    return TextFormField(
      controller: inputControllerLiters,
      decoration: InputDecoration(labelText: '${AppLocalizations
          .of(context)
          .litres}'),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value.isEmpty) {
          return 'State mustn\'t be null';
        }

        return null;
      },
    )
  }
}