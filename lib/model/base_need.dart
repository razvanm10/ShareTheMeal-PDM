import '../types/base_ingredient_type.dart';

class BaseNeed {


  double? quantity;

  BaseNeed({ this.quantity});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is BaseNeed &&
              runtimeType == other.runtimeType &&
              quantity == other.quantity;

  @override
  int get hashCode => quantity.hashCode;
}