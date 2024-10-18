// class Slot {
//   final String id;
//   final String providerId;
//   final String name;
//   final String address;
//   final String description;
//   final String image;
//   final String openTime;
//   final String closeTime;
//   final double latitude;
//   final double longitude;
//   final String? phone;

//   Slot({
//     required this.id,
//     required this.providerId,
//     required this.name,
//     required this.address,
//     required this.description,
//     required this.image,
//     required this.openTime,
//     required this.closeTime,
//     required this.latitude,
//     required this.longitude,
//     required this.phone,
//   });

//   factory Slot.fromJson(Map<String, dynamic> json) {
//     return Slot(
//       id: json['id'],
//       providerId: json['provider_id'],
//       name: json['name'],
//       address: json['address'],
//       description: json['description'],
//       image: json['image'],
//       openTime: json['open_time'],
//       closeTime: json['close_time'],
//       latitude: double.parse(json['latitude'].toString()),
//       longitude: double.parse(json['longitude'].toString()),
//       phone: json['phone'],
//     );
//   }
// }
import 'dart:ui';

class Slot {
  final String id;
  final String name;
  final String type;
  final Size size;
  final Offset position;
  final List<String> adjacent;

  Slot({
    required this.id,
    required this.name,
    required this.type,
    required this.size,
    required this.position,
    this.adjacent = const [],
  });
}

final List<Slot> mockMarketLayout = [
  Slot(
    id: 'slot_1',
    name: 'Restrooms',
    type: 'facility',
    size: Size(1, 1),
    position: Offset(0, 0),
    adjacent: ['slot_2', 'slot_3'],
  ),
  Slot(
    id: 'slot_2',
    name: 'Health & Beauty',
    type: 'retail',
    size: Size(1, 1),
    position: Offset(0, 1),
    adjacent: ['slot_1', 'slot_3', 'slot_4'],
  ),
  Slot(
    id: 'slot_3',
    name: 'Snack Bar',
    type: 'food',
    size: Size(2, 1),
    position: Offset(1, 0),
    adjacent: ['slot_1', 'slot_2', 'slot_4'],
  ),
  Slot(
    id: 'slot_4',
    name: 'Customer Service',
    type: 'service',
    size: Size(1, 1),
    position: Offset(1, 1),
    adjacent: ['slot_2', 'slot_3'],
  ),
  Slot(
    id: 'slot_5',
    name: 'Checkout',
    type: 'service',
    size: Size(1, 1),
    position: Offset(3, 0),
    adjacent: ['slot_6', 'slot_7'],
  ),
  Slot(
    id: 'slot_6',
    name: 'Checkout',
    type: 'service',
    size: Size(1, 1),
    position: Offset(4, 0),
    adjacent: ['slot_5', 'slot_7'],
  ),
  Slot(
    id: 'slot_7',
    name: 'Checkout',
    type: 'service',
    size: Size(1, 1),
    position: Offset(5, 0),
    adjacent: ['slot_5', 'slot_6'],
  ),
  Slot(
    id: 'slot_8',
    name: 'Appliances',
    type: 'retail',
    size: Size(1, 2),
    position: Offset(0, 2),
    adjacent: ['slot_9', 'slot_10'],
  ),
  Slot(
    id: 'slot_9',
    name: 'Stationery',
    type: 'retail',
    size: Size(1, 1),
    position: Offset(0, 4),
    adjacent: ['slot_8', 'slot_10'],
  ),
  Slot(
    id: 'slot_10',
    name: 'Home Decor',
    type: 'retail',
    size: Size(1, 2),
    position: Offset(0, 5),
    adjacent: ['slot_8', 'slot_9', 'slot_11'],
  ),
  Slot(
    id: 'slot_11',
    name: "Women's Clothing / Accessories",
    type: 'retail',
    size: Size(2, 2),
    position: Offset(1, 2),
    adjacent: ['slot_12', 'slot_13', 'slot_14', 'slot_15'],
  ),
  Slot(
    id: 'slot_12',
    name: "Boy's Clothing",
    type: 'retail',
    size: Size(1, 1),
    position: Offset(3, 2),
    adjacent: ['slot_11', 'slot_13'],
  ),
  Slot(
    id: 'slot_13',
    name: "Girl's Clothing",
    type: 'retail',
    size: Size(1, 1),
    position: Offset(4, 2),
    adjacent: ['slot_11', 'slot_12'],
  ),
  Slot(
    id: 'slot_14',
    name: "Men's Clothing",
    type: 'retail',
    size: Size(1, 1),
    position: Offset(3, 3),
    adjacent: ['slot_11', 'slot_15'],
  ),
  Slot(
    id: 'slot_15',
    name: 'Hosiery',
    type: 'retail',
    size: Size(1, 1),
    position: Offset(4, 3),
    adjacent: ['slot_11', 'slot_14'],
  ),
  Slot(
    id: 'slot_16',
    name: 'Toys',
    type: 'retail',
    size: Size(2, 1),
    position: Offset(1, 5),
    adjacent: ['slot_10', 'slot_17', 'slot_18'],
  ),
  Slot(
    id: 'slot_17',
    name: 'Home Electronics',
    type: 'retail',
    size: Size(2, 1),
    position: Offset(3, 5),
    adjacent: ['slot_16', 'slot_18'],
  ),
  Slot(
    id: 'slot_18',
    name: 'Sporting Goods',
    type: 'retail',
    size: Size(1, 1),
    position: Offset(5, 5),
    adjacent: ['slot_16', 'slot_17', 'slot_19'],
  ),
  Slot(
    id: 'slot_19',
    name: 'Seasonal',
    type: 'retail',
    size: Size(1, 2),
    position: Offset(5, 1),
    adjacent: ['slot_18', 'slot_20'],
  ),
  Slot(
    id: 'slot_20',
    name: 'Automotive',
    type: 'retail',
    size: Size(1, 2),
    position: Offset(5, 3),
    adjacent: ['slot_19'],
  ),
];
