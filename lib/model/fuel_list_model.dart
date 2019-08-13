import 'package:flutter_app_2/widgets/fueling.dart';
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

  void add(Fueling fuelings) {
    _fuelings.add(fuelings);

    _save();
  }


  void delete(Fueling fuelings) {
    _clearHistory();
    fuelings.delete();

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