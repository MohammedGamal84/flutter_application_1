class LocationModel {
  final String id;
  final String name;
  final String country;
  final String city;

  LocationModel({
    required this.id,
    required this.name,
    required this.country,
    required this.city,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['_id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      country: json['country']?.toString() ?? '',
      city: json['city']?.toString() ?? '',
    );
  }
}