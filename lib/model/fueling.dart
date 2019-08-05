class Fueling with Deletable {
  Fueling(
      this.name,
      this.liters,
      this.price,
      this.cost,
      this.odometr,
      this.fullFueling,
      this.fuelingDateTime,
      this.fuelingTimestamp,
      this.createdDateTime,
      this.carName,
      this.carId,
      this.stationName,
      this.stationId);

  String name;
  bool purchased;

  double liters;
  double price;
  double cost;
  int odometr;
  bool fullFueling;
  var fuelingDateTime;
  var createdDateTime;
  var fuelingTimestamp;
  var createdTimestamp;
  String carName;
  int carId;
  String stationName;
  int stationId;

  Fueling.fromJson(Map<String, dynamic> json)
      : liters = json['liters'],
        cost = json['cost'],
        price = json['price'],
        odometr = json['odometr'],
        fullFueling = json['fullFueling'],
        fuelingDateTime = json['fuelingDateTime'],
        createdDateTime = json['createdDateTime'],
        fuelingTimestamp = json['fuelingTimestamp'],
        createdTimestamp = json['createdTimestamp'],
        carName = json['carName'],
        stationName = json['stationName'],
        stationId = json['stationId'];

  Map<String, dynamic> toJson() => isDeleted
      ? null
      : {
          'liters': liters,
          'cost': cost,
          'price': price,
          'odometr': odometr,
          'fullFueling': fullFueling,
          'fuelingTimestamp': fuelingTimestamp,
          'fuelingDateTime': fuelingDateTime,
          'createdDateTime': createdDateTime,
          'createdTimestamp': createdTimestamp,
          'carName': carName,
          'carId': carId,
          'stationName': stationName,
          'stationId': stationId
        };
}

class Deletable {
  bool _deleted = false;

  bool get isDeleted => _deleted;

  void delete() => _deleted = true;

  void recover() => _deleted = false;
}
