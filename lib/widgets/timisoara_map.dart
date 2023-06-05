import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:pdm_project/constant_data/map_constants.dart';
import 'package:pdm_project/model/location_model.dart';
import 'package:pdm_project/repository/locations.dart';
import 'package:pdm_project/service/auth_service.dart';
import 'package:pdm_project/widgets/location_card.dart';

import '../views/courier_view.dart';

class TimisoaraMap extends StatefulWidget {
  VoidCallback? resize;

  TimisoaraMap({Key? key, this.resize}) : super(key: key);

  @override
  State<TimisoaraMap> createState() => _TimisoaraMapState();
}

class _TimisoaraMapState extends State<TimisoaraMap> {
  bool _detailsCardVisible = false;
  double _initialZoom = 14;
  MapController? mapController;
  AuthService authService = AuthService();

  LocationModel? locationModel;

  void closeCard() {
    setState(() {
      _detailsCardVisible = false;
    });
  }

  void _resizeMap() {
    print("resize");
    setState(() {
      _initialZoom = _initialZoom - 1;
    });
    mapController?.move(LatLng(45.753980, 21.231694), _initialZoom);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterMap(
            mapController: mapController,
            options: MapOptions(
                zoom: _initialZoom, center: LatLng(45.753980, 21.231694)),
            children: [
              TileLayer(
                urlTemplate: MapConstants.mapBoxUrl,
              ),
              MarkerLayer(
                  markers: Locations.locationsForDelivery
                      .map((e) => Marker(
                          point: LatLng(e.marker?.first ?? 0.0, e.marker?.last ?? 0.0),
                          builder: (context) => GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _detailsCardVisible = !_detailsCardVisible;
                                    locationModel = LocationModel
                                        .name(e.type, e.address, e.marker, e.story, e.needs, e.numberOfPeople);
                                  });
                                },
                                child: const Icon(
                                  Icons.pin_drop,
                                  color: Colors.amber,
                                  size: 60,
                                ),
                              )))
                      .toList())
            ]),
        if (_detailsCardVisible == true)
          LocationCard(
              locationModel: locationModel ?? LocationModel(),
              close: () {
                setState(() {
                  _detailsCardVisible = false;
                });
              },
              authService: authService)
        else
          Container(),
        Align(
            alignment: Alignment.bottomRight,
            child: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CourierView()));
                },
                icon: const Icon(
                  Icons.api_rounded,
                  color: Colors.black54,
                  size: 30,
                )))
      ],
    );
  }
}
