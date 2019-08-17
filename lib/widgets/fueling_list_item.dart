import 'package:flutter/material.dart';
import 'package:flutter_app_2/screens/page_edit_fueling.dart';
import 'package:intl/intl.dart';

class FuelingListItem extends StatefulWidget {
  @override
  _FuelingListItemState createState() => _FuelingListItemState();

  final itemData;
  final prevItemData;
  final onDelete;
  final int index;

  const FuelingListItem(
      {Key key, @required this.itemData, this.prevItemData, this.onDelete, this.index})
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
              if (_detailsDisplayed) _bottom(),
            ],
          ),
          padding: EdgeInsets.all(8.0),
        ),
      ),
      onTap: _toggle,
    );
  }

  Widget _top() {
    var _formatShort = new DateFormat('d MMM');
    var _formatLong = new DateFormat('y-MM-dd');
    var textStyle = TextStyle(fontSize: 17);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "Tankowanie",
          style: textStyle,
        ),
        Text(
          _detailsDisplayed
              ? _formatLong.format(widget.itemData.fuelingDateTime)
              : _formatShort.format(widget.itemData.fuelingDateTime),
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
                "${widget.itemData.odometr.toStringAsFixed(2)} km",
                style: textStyle,
              ),
            ],
          ),
          Text(
            "${widget.itemData.cost.toStringAsFixed(2)} pln",
            style: textStyle,
          ),
        ]);
  }

  Widget _details() {
    var textStyle = TextStyle(fontSize: 15);
    double litersper100;
    if (widget.prevItemData != null) {
      //TODO this is dont work because it not consider full fueling
      litersper100 = (widget.prevItemData.odometr - widget.itemData.odometr) /
          widget.itemData.liters *
          100;
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
              "${widget.itemData.liters.toStringAsFixed(2)} liters",
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
              litersper100 != null
                  ? "${litersper100.toStringAsFixed(2)} l/100km"
                  : "not enough data l/100km",
              style: textStyle,
            ),
          ],
        )
      ],
    );
  }

  Widget _bottom() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.delete),
          onPressed: widget.onDelete,
          tooltip: 'Delete',
          iconSize: 20,
        ),
        IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PageEditFueling(
                      itemIndex: widget.index,
                      fueling: widget.itemData,
            )));
          },
          tooltip: 'Edit',
          iconSize: 20,
        ),
      ],
    );
  }
}
