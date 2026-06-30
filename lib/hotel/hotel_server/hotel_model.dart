class HotelModel {
  final String id;
  final String name;
  final String description;
  final double rate;
  final double price;
  final String imageCover;
  final int availableRooms;
  final String availableTimes;

  HotelModel({
    required this.id,
    required this.name,
    required this.description,
    required this.rate,
    required this.price,
    required this.imageCover,
    required this.availableRooms,
    required this.availableTimes,
  });

  factory HotelModel.fromJson(Map<String, dynamic> json) {
  return HotelModel(
    id: json['_id']?.toString() ?? '',
    name: json['name']?.toString() ?? '',
    description: json['description']?.toString() ?? '',
    rate: double.tryParse(json['rate'].toString()) ?? 0,
    price: double.tryParse(json['price'].toString()) ?? 0,
    imageCover: json['imageCover']?.toString() ?? '',
    availableRooms:
        int.tryParse(json['availableRooms'].toString()) ?? 0,
    availableTimes: json['availableTimes']?.toString() ?? '',
  );
}
}