class Market {
  final String id;
  final String providerId;
  final String name;
  final String address;
  final String description;
  final String image;
  final String openTime;
  final String closeTime;
  final double latitude;
  final double longitude;
  final String? phone;

  Market({
    required this.id,
    required this.providerId,
    required this.name,
    required this.address,
    required this.description,
    required this.image,
    required this.openTime,
    required this.closeTime,
    required this.latitude,
    required this.longitude,
    required this.phone,
  });

  factory Market.fromJson(Map<String, dynamic> json) {
    return Market(
      id: json['id'],
      providerId: json['provider_id'],
      name: json['name'],
      address: json['address'],
      description: json['description'],
      image: json['image'],
      openTime: json['open_time'],
      closeTime: json['close_time'],
      latitude: double.parse(json['latitude'].toString()),
      longitude: double.parse(json['longitude'].toString()),
      phone: json['phone'],
    );
  }
}
