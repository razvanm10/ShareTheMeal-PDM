import 'package:flutter/material.dart';
import 'package:pdm_project/model/base_ingredient.dart';
import 'package:pdm_project/model/location_model.dart';
import 'package:pdm_project/model/user.dart';
import 'package:pdm_project/views/courier_procedure_view.dart';

import '../service/auth_service.dart';
import '../types/user_roles.dart';
import '../views/restaurant_procedure_view.dart';

class LocationCard extends StatelessWidget {
  final LocationModel locationModel;
  final VoidCallback? close;
  final AuthService authService;

  LocationCard(
      {required this.authService, required this.locationModel, this.close});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserRecord>(
        future: authService.currentUserDetails(),
        builder: (context, snapshot) => Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 35.0),
              child: SizedBox(
                height: 300,
                child: Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          locationModel.address ?? "",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                          height:
                              200, // Adjust the height according to your needs
                          child: SingleChildScrollView(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: locationModel.needs
                                      ?.whereType<BaseIngredient>()
                                      .length ??
                                  0,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text((locationModel.needs![index]
                                          as BaseIngredient)
                                      .name
                                      .toString()),
                                );
                              },
                            ),
                          )),
                      Row(
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                bool isCurrentUserCourier =
                                    snapshot.data?.role == UserRoles.Courier;
                                if (isCurrentUserCourier) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CourierProcedureView(
                                                  locationModel: locationModel,
                                                  currentUser: snapshot.data,
                                              )));
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const RestaurantProcedureView()));
                                }
                              },
                              child: const Text("Go to Procedure")),
                          IconButton(
                              onPressed: close,
                              icon: const Icon(Icons.delete, color: Colors.red))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ));
  }
}
