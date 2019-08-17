import 'package:flutter/material.dart';
import 'package:flutter_app_2/model/fuel_list_model.dart';
import 'package:flutter_app_2/model/fueling.dart';
import 'package:flutter_app_2/widgets/fueling_list_item.dart';
import 'package:scoped_model/scoped_model.dart';

class FuelingList extends StatelessWidget {
  BuildContext _context;

  void _dismissDialog(response) {
    Navigator.pop(_context, response);
  }

  void _deleteItem(Fueling fueling) async {
    bool result = await showDialog(
        context: _context,
        builder: (BuildContext context) =>
            AlertDialog(
              title: Text("Usuwanie tankowania"),
              content: Text("Czy chcesz napewno usunąć tankowanie?"),
              actions: <Widget>[
                FlatButton(
                  onPressed: () => _dismissDialog(false),
                  child: Text("Nie"),
                ),
                FlatButton(
                  onPressed: () => _dismissDialog(true),
                  child: Text("Tak, oczywiście"),
                )
              ],
            )
    );

    if (result == true) {
      final model = ScopedModel.of<FuelingListModel>(_context);

      model.delete(fueling);

      Scaffold.of(_context).hideCurrentSnackBar();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<FuelingListModel>(
        builder: (BuildContext context, child, model) {
          _context = context;

          return model.fuelings.isNotEmpty
              ? _buildList(context, model)
              : _buildPlaceholder(context);
        }
    );
  }

  Widget _buildList(BuildContext context, FuelingListModel model) {
    return ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        itemCount: model.fuelings.length,
        itemBuilder: (BuildContext context, int i) {
          final _fuelingItem = model.fuelings[i];

          return FuelingListItem(
            key: ObjectKey(_fuelingItem),
            itemData: _fuelingItem,
            prevItemData: i < model.fuelings.length - 1 ? model.fuelings[i + 1] : null,
            onDelete: () => _deleteItem(_fuelingItem),
            index: i,
          );
        }
    );
  }

  Widget _buildPlaceholder(BuildContext context){
    return Center(
        child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [SizedBox(height: 24.0), Text("Brak danych")]));
  }
}
