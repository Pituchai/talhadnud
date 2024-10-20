// payment.dart

import 'package:talhadnad/model/booking.dart';
import 'package:talhadnad/model/transaction.dart';


enum PaymentStatus {
  pending,
  completed,
  failed
}
class Payment {
  final String id;
  final String bookingId;
  final Booking? booking;
  final double price;
  final Method method;  // Using Method enum from Booking model
  final PaymentStatus status;
  final DateTime paymentDate;
  final Transaction? transactions;
  final DateTime expiresAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  Payment({
    required this.id,
    required this.bookingId,
    this.booking,
    required this.price,
    required this.method,
    required this.status,
    required this.paymentDate,
    this.transactions,
    required this.expiresAt,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      id: json['id'],
      bookingId: json['booking_id'],
      booking: json['booking'] != null ? Booking.fromJson(json['booking']) : null,
      price: json['price'].toDouble(),
      method: Method.values.firstWhere(
        (e) => e.toString() == 'Method.${json['method']}',
        orElse: () => Method.promptPay,
      ),
      status: PaymentStatus.values.firstWhere(
        (e) => e.toString() == 'PaymentStatus.${json['status']}',
        orElse: () => PaymentStatus.pending,
      ),
      paymentDate: DateTime.parse(json['payment_date']),
      transactions: json['transactions'] != null ? Transaction.fromJson(json['transactions']) : null,
      expiresAt: DateTime.parse(json['expires_at']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      deletedAt: json['deleted_at'] != null ? DateTime.parse(json['deleted_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'booking_id': bookingId,
      'booking': booking?.toJson(),
      'price': price,
      'method': method.toString().split('.').last,
      'status': status.toString().split('.').last,
      'payment_date': paymentDate.toIso8601String(),
      'transactions': transactions?.toJson(),
      'expires_at': expiresAt.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
    };
  }
}