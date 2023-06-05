import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pdm_project/service/auth_service.dart';
import 'package:pdm_project/types/user_roles.dart';

class Database {

  static final database = FirebaseFirestore.instance;

}