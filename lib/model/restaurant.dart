import 'package:pdm_project/model/end_of_day_food.dart';

import 'base_ingredient.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';


class Restaurant {

  String? name;

  String? address;

  LatLng? location;

  List<EndOfDayFood>? endOfDayFood;

  List<BaseIngredient>? baseIngredients;

  Restaurant({ this.name,
       this.address,  this.endOfDayFood, this.baseIngredients, this.location});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Restaurant &&
          runtimeType == other.runtimeType &&
          address == other.address &&
          endOfDayFood == other.endOfDayFood &&
          baseIngredients == other.baseIngredients;

  @override
  int get hashCode =>
      address.hashCode ^ endOfDayFood.hashCode ^ baseIngredients.hashCode;
}