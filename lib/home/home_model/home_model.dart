class HomeModel {
  final String id;
  final String title;
  final String description;
  final double rate;
  final double price;
  final List<String> features;
  final String imageCover;
  final List<String> images;
  final String location;

  HomeModel({
    required this.id,
    required this.title,
    required this.description,
    required this.rate,
    required this.price,
    required this.features,
    required this.imageCover,
    required this.images,
    required this.location,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      id: json['_id']?.toString() ?? json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      rate: (json['rate'] as num?)?.toDouble() ?? 0.0,
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      features: json['features'] is List
          ? List<String>.from(json['features'])
          : json['features'] != null && json['features'].toString().isNotEmpty
              ? [json['features'].toString()]
              : [],
      imageCover: json['imageCover']?.toString() ?? '',
      images: json['images'] is List
          ? List<String>.from(json['images'])
          : [],
      location: json['location'] is Map
          ? json['location']['name']?.toString() ?? ''
          : json['location']?.toString() ?? '',
    );
  }
}