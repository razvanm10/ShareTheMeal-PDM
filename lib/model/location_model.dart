import 'package:flutter_map/flutter_map.dart';
import 'package:pdm_project/model/base_need.dart';

class LocationModel {

  String? address;

  String? type;

  List<double>? marker;

  String? story;

  List<BaseNeed>? needs;

  int? numberOfPeople;


  LocationModel() {
    address = null;
    type = null;
    marker = null;
    story = null;
    needs = null;
    numberOfPeople = null;
  }

  LocationModel.name(
      this.type, this.address, this.marker, this.story, this.needs, this.numberOfPeople);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocationModel &&
          runtimeType == other.runtimeType &&
          type == other.type &&
          story == other.story &&
          needs == other.needs;

  @override
  int get hashCode => type.hashCode ^ story.hashCode ^ needs.hashCode;
}
