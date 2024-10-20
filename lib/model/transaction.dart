// transaction.dart

import 'package:talhadnad/model/payment.dart';

enum TransactionStatus {
  pending,
  completed,
  failed
}

class Transaction {
  final String id;
  final String paymentId;
  final Payment? payment;
  final double price;
  final String method;
  final TransactionStatus status;
  final DateTime transactionDate;
  final String? transactionId;
  final String? ref1;
  final String? ref2;
  final String? ref3;
  final String? image;
  final DateTime expiresAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  Transaction({
    required this.id,
    required this.paymentId,
    this.payment,
    required this.price,
    required this.method,
    required this.status,
    required this.transactionDate,
    this.transactionId,
    this.ref1,
    this.ref2,
    this.ref3,
    this.image,
    required this.expiresAt,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      paymentId: json['payment_id'],
      payment: json['payment'] != null ? Payment.fromJson(json['payment']) : null,
      price: json['price'].toDouble(),
      method: json['method'],
      status: TransactionStatus.values.firstWhere(
        (e) => e.toString() == 'TransactionStatus.${json['status']}',
        orElse: () => TransactionStatus.pending,
      ),
      transactionDate: DateTime.parse(json['transaction_date']),
      transactionId: json['transaction_id'],
      ref1: json['ref1'],
      ref2: json['ref2'],
      ref3: json['ref3'],
      image: json['image'],
      expiresAt: DateTime.parse(json['expires_at']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      deletedAt: json['deleted_at'] != null ? DateTime.parse(json['deleted_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'payment_id': paymentId,
      'payment': payment?.toJson(),
      'price': price,
      'method': method,
      'status': status.toString().split('.').last,
      'transaction_date': transactionDate.toIso8601String(),
      'transaction_id': transactionId,
      'ref1': ref1,
      'ref2': ref2,
      'ref3': ref3,
      'image': image,
      'expires_at': expiresAt.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
    };
  }
}