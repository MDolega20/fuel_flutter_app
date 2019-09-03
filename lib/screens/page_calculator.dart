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

  bool _litersAuto = false;
  bool _priceAuto = false;
  bool _costAuto = true;
  bool _distanceAuto = false;
  bool _comsumptionAuto = true;

  @override
  void initState() {
    super.initState();
    _controllerListeners();
  }

  void _controllerListeners() {
    // on input change

    //TODO pobieranie nazwy zmiennej i używanie w pętli zmiennych które nazwy zapisane sa w tablicy "liście"
//    List<TextEditingController> controllers = [inputControllerLiters, inputControllerCost, inputControllerPrice, inputControllerDistance, inputControllerComsumption];
//    List<String> variables = ["_liters", "_cost", "_price", "_distance", "_comsumption"];
//
//    for(int i = 0; i < controllers.length; i++){
//          controllers[i].addListener(() {
//      if (controllers[i].text != null &&
//          controllers[i].text != "" &&
//          [variables[i]] != double.parse(controllers[i].text)) {
//        setState(() {
//          [variables[i]] = double.parse(controllers[i].text);
//        });
//      }
//    });
//    }
    // old way

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
          _field(inputControllerLiters, AppLocalizations.of(context).litres,
              _litersAuto),
          _field(inputControllerPrice, AppLocalizations.of(context).price,
              _priceAuto),
          _field(inputControllerCost, AppLocalizations.of(context).cost,
              _costAuto),
          _field(inputControllerDistance, "//TODO distancen",
              _distanceAuto),
          _field(inputControllerComsumption, "//TODO comsumption",
              _comsumptionAuto),
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
  Widget _field(controller, name, auto) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Flexible(
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(labelText: '${name}'),
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
            value: auto,
            onChanged: (bool value) {
              setState(() {
                print("Checkbox changed! value=${auto} $value");
                auto = value;
              });
            },
          ),
        )
      ],
    );
  }

}
