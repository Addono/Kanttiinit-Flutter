import 'package:kanttiinit_flutter/restaurant.dart';

class Area extends Object {
  Area({this.id, this.latitude, this.longitude, this.locationRadius, this.name,
    this.restaurants});

  int id;
  double latitude;
  double longitude;
  int locationRadius;
  String name;
  List<Restaurant> restaurants;

  Area.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        latitude = json['latitude'],
        longitude = json['longitude'],
        locationRadius = json['locationRadius'],
        name = json['name'],
        restaurants = json['restaurants'].map<Restaurant>((v) => Restaurant.fromJson(v)).toList();
}