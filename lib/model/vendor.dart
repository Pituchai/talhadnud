import 'package:talhadnad/model/booking.dart';

class VendorDetails {
  final String id;
  final String username;
  final String email;
  final String image;
  final String firstName;
  final String lastName;
  final String phone;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<Booking>? bookings;

  VendorDetails({
    required this.id,
    required this.username,
    required this.email,
    required this.image,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.createdAt,
    required this.updatedAt,
    this.bookings,
  });

  factory VendorDetails.fromJson(Map<String, dynamic> json) {
    return VendorDetails(
      id: json['id'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      image: json['image'] ?? '',
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      phone: json['phone'] ?? '',
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      bookings: (json['bookings'] as List<dynamic>?)
          ?.map((booking) => Booking.fromJson(booking))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'image': image,
      'first_name': firstName,
      'last_name': lastName,
      'phone': phone,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'bookings': bookings?.map((booking) => booking.toJson()).toList(),
    };
  }
}