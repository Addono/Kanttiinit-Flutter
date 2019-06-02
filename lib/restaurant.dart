class Restaurant extends Object {
  Restaurant(
      {this.id,
      this.openingHours,
      this.type,
      this.url,
      this.latitude,
      this.longitude,
      this.address,
      this.name});

  final int id;
  final List<String> openingHours;
  final String type;
  final String url;
  final double latitude;
  final double longitude;
  final String address;
  final String name;

  Restaurant.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        openingHours = json['openingHours'].map<String>((v) => v as String).toList(),
        type = json['type'],
        url = json['url'],
        latitude = json['latitude'],
        longitude = json['longitude'],
        address = json['address'],
        name = json['name'];
}
