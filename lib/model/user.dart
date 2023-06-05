import 'package:pdm_project/types/user_roles.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
class UserRecord {

  String? id;

  UserRoles? role;

  bool? isSignedIn;

  LatLng currentLocation = LatLng(45.764353, 21.228626);

  UserRecord({this.id, this.role, this.isSignedIn});



}