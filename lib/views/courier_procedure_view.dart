import 'dart:math';

import "package:flutter/material.dart";
import 'package:pdm_project/model/location_model.dart';
import 'package:pdm_project/model/user.dart';
import 'package:pdm_project/repository/restaurants.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../constant_data/map_constants.dart';
import '../widgets/restaurant_card.dart';

class CourierProcedureView extends StatefulWidget {
  UserRecord? currentUser;

  LocationModel? locationModel;
  CourierProcedureView({Key? key, this.currentUser, this.locationModel})
      : super(key: key);

  @override
  State<CourierProcedureView> createState() => _CourierProcedureViewState();
}

class _CourierProcedureViewState extends State<CourierProcedureView> {

  LatLng? _currentRestaurant;

  void updateMap(LatLng? newValue) {
    print("here");
    setState(() {
      _currentRestaurant = newValue;
    });
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    print(widget.currentUser.toString());
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  double getDistance(LatLng restaurantLocation) {
    return calculateDistance(
        widget.currentUser?.currentLocation.latitude,
        widget.currentUser?.currentLocation.longitude,
        restaurantLocation.latitude,
        restaurantLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Courier Procedure"),
        ),
        body: Container(
          child: Column(
            children: [
              SizedBox(
                  width: 400,
                  height: 500,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FlutterMap(
                        options: MapOptions(
                            zoom: 12, center: LatLng(45.753980, 21.231694)),
                        children: [
                          TileLayer(
                            urlTemplate: MapConstants.mapBoxUrl,
                          ),
                          MarkerLayer(markers: [
                            Marker(
                                point: _currentRestaurant ?? RestaurantsRepository.data.first.location ?? LatLng(0.0, 0.0),
                                builder: (BuildContext context) => const Icon(Icons.food_bank, color: Colors.amber, size: 60)
                            ),
                            Marker(
                                point: widget.currentUser?.currentLocation ?? LatLng(0.0, 0.0),
                                builder: (BuildContext context) => const Icon(Icons.accessibility_new_rounded, color: Colors.green, size: 60)
                            ),
                          ]),
                        ]),
                  )),
              Expanded(
                  child: ListView(
                shrinkWrap: true,
                children: [
                  ...RestaurantsRepository.data.map((e) => ListTile(
                      title: RestaurantCard(
                          tappedRestaurant: () => updateMap(e.location),
                          restaurant: e,
                          distanceFromUser: getDistance(
                              e.location ?? LatLng(0.0, 0.0)),
                          distanceFromDeliveryPoint: getDistance(e.location ?? LatLng(0.0, 0.0)),
                      )))
                ],
              ))
            ],
          ),
        ));
  }
}
