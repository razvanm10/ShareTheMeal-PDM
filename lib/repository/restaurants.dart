import 'package:latlong2/latlong.dart';
import 'package:pdm_project/model/base_ingredient.dart';
import 'package:pdm_project/model/restaurant.dart';

import '../types/base_ingredient_type.dart';

class RestaurantsRepository {

  static final data = [
    Restaurant(
        name: "Restaurant X",
        address: "str. X, number 3, Timisoara",
        location: LatLng(45.754635, 21.235817),
        baseIngredients: List.of(
            [
              BaseIngredient(name: BaseIngredientType.Flour, quantity: 3.4),
              BaseIngredient(name: BaseIngredientType.Vegetables, quantity: 3.4),
            ]
        )
    ),
    Restaurant(
        name: "Restaurant Y",
        address: "str. X, number 3, Timisoara",
        location: LatLng(45.754505, 21.224215),
        baseIngredients: List.of(
            [
              BaseIngredient(name: BaseIngredientType.Flour, quantity: 3.4),
              BaseIngredient(name: BaseIngredientType.Vegetables, quantity: 3.4),
            ]
        )
    ),
    Restaurant(
        name: "Restaurant Z",
        address: "str. X, number 3, Timisoara",
        location: LatLng(45.756706, 21.230230),
        baseIngredients: List.of(
            [
              BaseIngredient(name: BaseIngredientType.Flour, quantity: 3.4),
              BaseIngredient(name: BaseIngredientType.Vegetables, quantity: 3.4),
            ]
        )
    ),
  ];

}