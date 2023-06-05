import 'package:pdm_project/model/base_ingredient.dart';
import 'package:pdm_project/model/location_model.dart';

import '../types/base_ingredient_type.dart';

class Locations {
  static final locationsForDelivery = <LocationModel>[
    LocationModel.name(
        "Restaurant",
        "Adress line1",
        [45.758004, 21.211726],
        "StoryStoryStoryStoryStory",
        List.of([
          BaseIngredient(name: BaseIngredientType.Vegetables, quantity: 3.4),
          BaseIngredient(name: BaseIngredientType.Flour, quantity: 3.4),
        ]),
        2),
    LocationModel.name(
        "ToDeliver",
        "Adress line1",
        [45.745774, 21.221241],
        "StoryStoryStoryStoryStory",
        List.of([
          BaseIngredient(name: BaseIngredientType.FoodOil, quantity: 3.4),
          BaseIngredient(name: BaseIngredientType.Flour, quantity: 3.4)
        ]),
        10)
  ];
}
