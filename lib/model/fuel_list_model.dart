import 'package:flutter_app_2/model/fueling.dart';
import 'package:scoped_model/scoped_model.dart';

class FuelingListModel extends Model {
  final List<Fueling> _fuelings = [];

  List<Fueling> get fuelings =>
      _fuelings.where((fueling) => !fueling.isDeleted).toList();

  final Function(FuelingListModel) onSave;

  FuelingListModel({this.onSave});

  void import(List<Fueling> fuelings) {
    _fuelings.addAll(fuelings);

    notifyListeners();
  }

  void add(Fueling fueling) {
    _fuelings.add(fueling);

    _save();
  }

  void update(int itemIndex, Fueling fueling) {
    _fuelings[itemIndex] = fueling;

    _save();
  }


  void delete(Fueling fueling) {
    _clearHistory();
    fueling.delete();

    _save();
  }

  void _reset(Fueling fueling) {
   _fuelings.removeWhere((el){true;});

    _save();
  }


  void _clearHistory() {
    _fuelings.removeWhere((fueling) => fueling.isDeleted);
  }

  void undoDeleting() {
    _fuelings.forEach((fueling) => fueling.recover());

    _save();
  }

  void _save() {
    if (onSave != null) {
      onSave(this);
    }

    notifyListeners();
  }
}