// vendor_details.dart

import 'package:talhadnad/models/booking.dart'; // Ensure this import points to your Booking model file

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
  final List<Booking> bookings;

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
    required this.bookings,
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
          .toList() ?? [],
    );
  }
}