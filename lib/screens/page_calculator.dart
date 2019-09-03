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
            "Calc your drive",
            style: TextStyle(
                fontSize: 30.0, color: Theme.of(context).primaryColor),
          ),
          Calculator()
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
  TextEditingController inputControllerDistance = new TextEditingController();
  TextEditingController inputControllerComsumption =
      new TextEditingController();

  // data changing
  double _liters;
  double _cost;
  double _price;
  double _distance;
  double _comsumption;

  bool _autoListers = false;
  bool _autoPrice = false;
  bool _autoCost = true;
  bool _autoDistance = false;
  bool _autoComsumption = true;

  @override
  void initState() {
    super.initState();
    _controllerListeners();
  }

  void _controllerListeners() {

    inputControllerLiters.addListener(() {
      if (inputControllerLiters.text != null &&
          inputControllerLiters.text != "" &&
          _liters != double.parse(inputControllerLiters.text)) {
        setState(() {
          _liters = double.parse(inputControllerLiters.text);
        });
      }
    });
    inputControllerComsumption.addListener(() {
      if (inputControllerComsumption.text != null &&
          inputControllerComsumption.text != "" &&
          _comsumption != double.parse(inputControllerComsumption.text)) {
        setState(() {
          _comsumption = double.parse(inputControllerComsumption.text);
        });
      }
    });
    inputControllerDistance.addListener(() {
      if (inputControllerDistance.text != null &&
          inputControllerDistance.text != "" &&
          _liters != double.parse(inputControllerDistance.text)) {
        setState(() {
          _liters = double.parse(inputControllerDistance.text);
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
  }

  void _calc() {}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 20),
      child: Column(
        children: <Widget>[
          _header(),
          _fieldLiters(),
          _fieldPrice(),
          _fieldCost(),
          _fieldDistance(),
          _fieldComsumption()
        ],
      ),
    );
  }

  Widget _header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text("name"),
        Container(width: 50, alignment: Alignment(0, 0), child: Text("auto"))
      ],
    );
  }

  Widget _fieldLiters() {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Flexible(
          child: TextFormField(
            controller: inputControllerLiters,
            decoration: InputDecoration(labelText: '${AppLocalizations.of(context).litres}'),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value.isEmpty) {
                return 'State mustn\'t be null';
              }
              return null;
            },
          ),
        ),
        Container(
          width: 50,
          alignment: Alignment(0, 0),
          child: Checkbox(
            value: _autoListers,
            onChanged: (bool value) {
              setState(() {
                _autoListers = value;
              });
            },
          ),
        )
      ],
    );
  }
  Widget _fieldPrice() {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Flexible(
          child: TextFormField(
            controller: inputControllerPrice,
            decoration: InputDecoration(labelText: '${AppLocalizations.of(context).price}'),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value.isEmpty) {
                return 'State mustn\'t be null';
              }
              return null;
            },
          ),
        ),
        Container(
          width: 50,
          alignment: Alignment(0, 0),
          child: Checkbox(
            value: _autoPrice,
            onChanged: (bool value) {
              setState(() {
                _autoPrice = value;
              });
            },
          ),
        )
      ],
    );
  }
  Widget _fieldCost() {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Flexible(
          child: TextFormField(
            controller: inputControllerCost,
            decoration: InputDecoration(labelText: '${AppLocalizations.of(context).cost}'),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value.isEmpty) {
                return 'State mustn\'t be null';
              }
              return null;
            },
          ),
        ),
        Container(
          width: 50,
          alignment: Alignment(0, 0),
          child: Checkbox(
            value: _autoCost,
            onChanged: (bool value) {
              setState(() {
                _autoCost = value;
              });
            },
          ),
        )
      ],
    );
  }
  Widget _fieldDistance() {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Flexible(
          child: TextFormField(
            controller: inputControllerDistance,
            decoration: InputDecoration(labelText: '${
//                AppLocalizations.of(context).distance
            "distance //TODO"
            }'),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value.isEmpty) {
                return 'State mustn\'t be null';
              }
              return null;
            },
          ),
        ),
        Container(
          width: 50,
          alignment: Alignment(0, 0),
          child: Checkbox(
            value: _autoDistance,
            onChanged: (bool value) {
              setState(() {
                _autoDistance = value;
              });
            },
          ),
        )
      ],
    );
  }
  Widget _fieldComsumption() {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Flexible(
          child: TextFormField(
            controller: inputControllerComsumption,
            decoration: InputDecoration(labelText: '${
//                AppLocalizations.of(context).comsumption
                "comsumption //TODO"
            }'),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value.isEmpty) {
                return 'State mustn\'t be null';
              }
              return null;
            },
          ),
        ),
        Container(
          width: 50,
          alignment: Alignment(0, 0),
          child: Checkbox(
            value: _autoComsumption,
            onChanged: (bool value) {
              setState(() {
                _autoComsumption = value;
              });
            },
          ),
        )
      ],
    );
  }

}
