
class Fueling with Deletable {
  Fueling(
      this.liters,
      this.price,
      this.cost,
      this.odometr,
      this.fullFueling,
      this.fuelingDateTime,
      this.createdDateTime,
      );

  double liters;
  double price;
  double cost;
  int odometr;

  bool fullFueling;

  DateTime fuelingDateTime;
  DateTime createdDateTime;


  Fueling.fromJson(Map<String, dynamic> json)
      : liters = json['liters'],
        cost = json['cost'],
        price = json['price'],
        odometr = json['odometr'],
        fullFueling = json['fullFueling'],
        fuelingDateTime = DateTime.parse(json['fuelingDateTime']),
        createdDateTime = DateTime.parse(json['createdDateTime']);

  Map<String, dynamic> toJson() => isDeleted
      ? null
      : {
          'liters': liters,
          'cost': cost,
          'price': price,
          'odometr': odometr,
          'fullFueling': fullFueling,
          'fuelingDateTime': fuelingDateTime.toString(),
          'createdDateTime': createdDateTime.toString()
        };
}

class Deletable {
  bool _deleted = false;

  bool get isDeleted => _deleted;

  void delete() => _deleted = true;

  void recover() => _deleted = false;
}
