import 'base_need.dart';

class EndOfDayFood implements BaseNeed {

  String? name;

  double? quantity;

  EndOfDayFood({this.name, this.quantity});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EndOfDayFood &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          quantity == other.quantity;

  @override
  int get hashCode => name.hashCode ^ quantity.hashCode;
}