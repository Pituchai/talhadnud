// slot.dart

class Slot {
  final String id;
  final String marketId;
  final DateTime date;
  final String startTime;
  final String endTime;
  final double price;
  final bool isAvailable;

  Slot({
    required this.id,
    required this.marketId,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.price,
    required this.isAvailable,
  });

  factory Slot.fromJson(Map<String, dynamic> json) {
    return Slot(
      id: json['id'],
      marketId: json['market_id'],
      date: DateTime.parse(json['date']),
      startTime: json['start_time'],
      endTime: json['end_time'],
      price: json['price'].toDouble(),
      isAvailable: json['is_available'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'market_id': marketId,
      'date': date.toIso8601String(),
      'start_time': startTime,
      'end_time': endTime,
      'price': price,
      'is_available': isAvailable,
    };
  }
}