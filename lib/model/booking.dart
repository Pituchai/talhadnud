// booking.dart

import 'package:talhadnad/models/slot.dart';
import 'package:talhadnad/models/vendor.dart';
import 'package:talhadnad/models/payment.dart';

enum BookingStatus {
  pending,
  cancelled,
  completed
}

enum Method {
  promptPay
}

class Booking {
  final String id;
  final String slotId;
  final Slot? slot;
  final String vendorId;
  final String marketId;
  final VendorDetails? vendor;
  final DateTime bookingDate;
  final BookingStatus status;
  final Method method;
  final double price;
  final Payment? payment;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime expiresAt;

  Booking({
    required this.id,
    required this.slotId,
    this.slot,
    required this.vendorId,
    required this.marketId,
    this.vendor,
    required this.bookingDate,
    required this.status,
    required this.method,
    required this.price,
    this.payment,
    required this.createdAt,
    required this.updatedAt,
    required this.expiresAt,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'],
      slotId: json['slot_id'],
      slot: json['slot'] != null ? Slot.fromJson(json['slot']) : null,
      vendorId: json['vendor_id'],
      marketId: json['market_id'],
      vendor: json['vendor'] != null ? VendorDetails.fromJson(json['vendor']) : null,
      bookingDate: DateTime.parse(json['booking_date']),
      status: BookingStatus.values.firstWhere(
        (e) => e.toString() == 'BookingStatus.${json['status']}',
        orElse: () => BookingStatus.pending,
      ),
      method: Method.values.firstWhere(
        (e) => e.toString() == 'Method.${json['method']}',
        orElse: () => Method.promptPay,
      ),
      price: json['price'].toDouble(),
      payment: json['payment'] != null ? Payment.fromJson(json['payment']) : null,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      expiresAt: DateTime.parse(json['expires_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'slot_id': slotId,
      'slot': slot?.toJson(),
      'vendor_id': vendorId,
      'market_id': marketId,
      'vendor': vendor?.toJson(),
      'booking_date': bookingDate.toIso8601String(),
      'status': status.toString().split('.').last,
      'method': method.toString().split('.').last,
      'price': price,
      'payment': payment?.toJson(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'expires_at': expiresAt.toIso8601String(),
    };
  }
}