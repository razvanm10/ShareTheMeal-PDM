import 'package:pdm_project/model/base_need.dart';
import 'package:pdm_project/types/base_ingredient_type.dart';

class BaseIngredient implements BaseNeed {
  BaseIngredientType? name;

  double? quantity;

  BaseIngredient({this.name, this.quantity});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BaseIngredient &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          quantity == other.quantity;

  @override
  int get hashCode => name.hashCode ^ quantity.hashCode;
}
