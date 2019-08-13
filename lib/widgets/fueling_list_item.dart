import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FuelingListItem extends StatefulWidget {
  @override
  _FuelingListItemState createState() => _FuelingListItemState();

  final itemData;
  final prevItemData;
  final onDelete;

  const FuelingListItem(
      {Key key, @required this.itemData, this.prevItemData, this.onDelete})
      : super(key: key);
}

class _FuelingListItemState extends State<FuelingListItem> {
  bool _detailsDisplayed = false;

  void _toggle() {
    setState(() {
      _detailsDisplayed = !_detailsDisplayed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        child: Padding(
          child: Column(
            children: <Widget>[
              _top(),
              if (_detailsDisplayed) _details(),
              _middle(),
            ],
          ),
          padding: EdgeInsets.all(8.0),
        ),
      ),
      onTap: _toggle,
    );
  }

  Widget _top() {
    var _format = new DateFormat('d MMM');
    var textStyle = TextStyle(fontSize: 17);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "Tankowanie",
          style: textStyle,
        ),
        Text(
          _format.format(widget.itemData.fuelingDateTime),
          style: textStyle,
        )
      ],
    );
  }

  Widget _middle() {
    var textStyle = TextStyle(fontSize: 15);
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
//                mainAxisAlignment: MainAxisAlignment.start, // TODO do not center
                width: 35,
                child: Image.asset(
                  "assets/odometer.png",
                  height: 30,
                ),
              ),
              Text(
                "${widget.itemData.odometr.toString()} km",
                style: textStyle,
              ),
            ],
          ),
          Text(
            "${widget.itemData.cost.toString()} pln",
            style: textStyle,
          ),
        ]);
  }

  Widget _details() {
    var textStyle = TextStyle(fontSize: 15);
    double litersper100;
    if(widget.prevItemData != null){ //TODO
      litersper100 = (widget.itemData.odometr - widget.prevItemData.odometr) / widget.itemData.liters * 100;
    }


    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 35,
              child: Image.asset(
                "assets/carnister.png",
                height: 25,
              ),
            ),
            Text(
              "${widget.itemData.liters.toString()} liters",
              style: textStyle,
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Container(
              width: 35,
              child: Image.asset(
                "assets/chart.png",
                height: 25,
              ),
            ),
            Text(
              litersper100 != null ?
              "${litersper100.toString()} l/100km" : "not enough data l/100km",
              style: textStyle,
            ),
          ],
        )
      ],
    );
  }
}
