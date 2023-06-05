import "package:flutter/material.dart";
import 'package:pdm_project/model/restaurant.dart';

class RestaurantCard extends StatefulWidget {
  Restaurant? restaurant;
  double? distanceFromUser;
  double? distanceFromDeliveryPoint;
  VoidCallback? tappedRestaurant;

  RestaurantCard(
      {Key? key,
      this.restaurant,
      this.distanceFromUser,
      this.distanceFromDeliveryPoint, this.tappedRestaurant})
      : super(key: key);

  @override
  State<RestaurantCard> createState() => _RestaurantCardState();
}

class _RestaurantCardState extends State<RestaurantCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: widget.tappedRestaurant,
        child: Center(
          child: Card(
            child: SizedBox(
              width: 400,
              height: 100,
              child: Column(
                children: [
                  Text("Restaurant: ${widget.restaurant?.name}"),
                  Text("Distance User -> Restaurant: " +
                      widget.distanceFromUser.toString()),
                  Text("Distance Restaurant -> Location: " +
                      widget.distanceFromDeliveryPoint.toString()),
                  Expanded(
                      child: Column(
                    children: [
                      Expanded(
                          child: ListView(
                        shrinkWrap: true,
                        children: [
                          ...?widget.restaurant?.baseIngredients
                              ?.map((e) => Card(
                                    shape: RoundedRectangleBorder(),
                                    color: Colors.amber,
                                    child: SizedBox(
                                      height: 50,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text("Ingredient ${e.name}",
                                              style: TextStyle(
                                                  color: Colors.black45)),
                                          Text("Quantity ${e.quantity}")
                                        ],
                                      ),
                                    ),
                                  ))
                              .toList(),
                          Text(widget.restaurant?.endOfDayFood?.isNotEmpty ==
                                  true
                              ? "Something Extra if needed..."
                              : ""),
                          ...?widget.restaurant?.endOfDayFood
                              ?.map((e) => Card(
                                    color: Colors.amber,
                                    child: Column(
                                      children: [
                                        Text("Ingredient ${e.name}"),
                                        Text("Ingredient ${e.quantity}")
                                      ],
                                    ),
                                  ))
                              .toList(),
                        ],
                      ))
                    ],
                  ))
                ],
              ),
            ),
          ),
        ));
  }
}
