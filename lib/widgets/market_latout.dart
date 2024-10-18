import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:talhadnad/api_client/lib/api.dart' as api;
import 'package:talhadnad/components/auth/register/registerbody.dart';
import 'package:talhadnad/model/user_model.dart';
import 'package:talhadnad/src/screen/confirm_page.dart';
import 'package:talhadnad/theme/slot_theme.dart';
import 'package:intl/intl.dart';

typedef ApiEntitiesSlot = api.EntitiesSlot;

enum SlotStatus { Available, Selected, Booked, NoData }

class MarketLayout extends StatefulWidget {
  final Function(String?) onSlotSelected;
  final List<ApiEntitiesSlot>? slots;

  const MarketLayout({
    super.key,
    required this.onSlotSelected,
    this.slots,
  });

  @override
  _MarketLayoutState createState() => _MarketLayoutState();
}

class _MarketLayoutState extends State<MarketLayout> {
  Map<String, ApiEntitiesSlot> slotDataMap = {};
  String? selectedSlot;

  @override
  void initState() {
    super.initState();
    _resetState();
    _initializeSlotData();
  }

  @override
  void didUpdateWidget(MarketLayout oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.slots != oldWidget.slots) {
      _initializeSlotData();
    }
  }

  void _resetState() {
    setState(() {
      selectedSlot = null;
    });
  }

  void _initializeSlotData() {
    slotDataMap.clear();
    if (widget.slots != null) {
      for (var slot in widget.slots!) {
        String slotId = _extractSlotId(slot.id);
        slotDataMap[slotId] = slot;
      }
    }
    setState(() {});
  }

  String _extractSlotId(String? fullId) {
    if (fullId == null) return '';
    List<String> parts = fullId.split('-');
    if (parts.length >= 7) {
      return "${parts[5]}-${parts[6]}";
    }
    return fullId;
  }

  SlotStatus _getSlotStatus(ApiEntitiesSlot? slot) {
    if (slot == null) return SlotStatus.NoData;
    switch (slot.status?.toString().toLowerCase()) {
      case 'booked':
        return SlotStatus.Booked;
      default:
        return SlotStatus.Available;
    }
  }

  void _handleSlotTap(String slotId) {
    print("Slot tapped: $slotId");

    setState(() {
      if (selectedSlot == slotId) {
        selectedSlot = null;
      } else {
        selectedSlot = slotId;
      }
    });

    widget.onSlotSelected(selectedSlot);

    ApiEntitiesSlot? tappedSlot = slotDataMap[slotId];
    if (tappedSlot != null) {
      _showSlotDetails(tappedSlot);
    } else {
      _showNoDataMessage(slotId);
    }
  }

  void _handleOutsideTap() {
    if (selectedSlot != null) {
      setState(() {
        selectedSlot = null;
      });
      widget.onSlotSelected(null);
    }
  }

  void _showSlotDetails(ApiEntitiesSlot slot) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.7,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              Container(
                height: 5,
                width: 40,
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2.5),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Slot ${_extractSlotId(slot.id)}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                      _buildInfoRow(Icons.info_outline, 'ID', slot.id ?? 'N/A'),
                      _buildInfoRow(
                          Icons.label_outline,
                          'Name',
                          slot.name?.isEmpty ?? true
                              ? _extractSlotId(slot.id)
                              : slot.name!),
                      _buildInfoRow(Icons.event_available, 'Status',
                          slot.status?.toString() ?? 'N/A'),
                      _buildInfoRow(
                          Icons.attach_money,
                          'Price',
                          slot.price != null
                              ? NumberFormat.currency(
                                      symbol: '฿', decimalDigits: 2)
                                  .format(slot.price)
                              : 'N/A'),
                      _buildInfoRow(
                          Icons.calendar_today,
                          'Date',
                          DateFormat("dd-MM-yyyy")
                              .format(DateTime.parse(slot.date))),
                      const Spacer(),
                      if (slot.status.toString() == 'available')
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ConfirmPage(
                                          slot: slot,
                                          slotID: selectedSlot,
                                        )),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              'Confirm Booking',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    ).whenComplete(() {
      setState(() {
        selectedSlot = null;
      });
      widget.onSlotSelected(null);
    });
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(icon, color: Colors.teal, size: 24),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showNoDataMessage(String slotId) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.35,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              Container(
                height: 5,
                width: 40,
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2.5),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.info_outline,
                        size: 50,
                        color: Colors.orange,
                      ),
                      const SizedBox(height: 15),
                      Text(
                        'No Data Available for Slot $slotId',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Additional information for this slot is not available at the moment.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    ).whenComplete(() {
      setState(() {
        selectedSlot = null;
      });
      widget.onSlotSelected(null);
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const double scaleFactor = 0.82;
        final double slotWidth = (constraints.maxWidth / 6.7) * scaleFactor;
        final double tempmaxWidth = (constraints.maxWidth / 6) * scaleFactor;
        final double slotHeight = ((tempmaxWidth * 0.6) + 15) * scaleFactor;

        return GestureDetector(
          onTap: _handleOutsideTap,
          behavior: HitTestBehavior.opaque,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    SizedBox(height: slotHeight, width: slotWidth),
                    Padding(
                      padding: const EdgeInsets.only(left: 3 * scaleFactor),
                      child: _buildSlot('B-1', slotWidth, slotHeight),
                    ),
                    SizedBox(
                        height: slotHeight, width: slotWidth - 6 * scaleFactor),
                    SizedBox(
                        height: slotHeight,
                        width: slotWidth - 12 * scaleFactor),
                    _buildSlot('B-2', slotWidth, slotHeight),
                    _buildSlot('B-3', slotWidth, slotHeight),
                    _buildSlot('B-4', slotWidth, slotHeight),
                    _buildSlot('B-5', slotWidth, slotHeight),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                        height: slotHeight,
                        width: slotWidth + 0.5 * scaleFactor),
                    Padding(
                      padding: const EdgeInsets.only(left: 3 * scaleFactor),
                      child: _buildSlot('B-6', slotWidth, slotHeight),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        _buildSlot('A-1', slotWidth, slotHeight),
                        _buildSlot('A-2', slotWidth, slotHeight),
                      ],
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  _buildSlot('C-1', slotWidth, slotHeight),
                                  _buildSlot('C-2', slotWidth, slotHeight),
                                ],
                              ),
                              SizedBox(
                                  height: slotHeight,
                                  width: slotWidth - 6 * scaleFactor),
                              SizedBox(
                                  height: slotHeight,
                                  width: slotWidth - 12 * scaleFactor),
                              Column(
                                children: [
                                  _buildSlot('D-1', slotWidth, slotHeight),
                                  _buildSlot('D-2', slotWidth, slotHeight),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 5, bottom: 3),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[400],
                                    border: Border.all(),
                                    borderRadius:
                                        BorderRadius.circular(4 * scaleFactor),
                                  ),
                                  height: 110 * scaleFactor,
                                  width: 160 * scaleFactor,
                                  child: const Center(
                                    child: Text(
                                      'Shop',
                                      style: TextStyle(
                                        fontFamily: 'Quicksand',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14 * scaleFactor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              _buildSlot('E-1', slotWidth, slotHeight),
                              SizedBox(
                                  height: slotHeight,
                                  width: (slotWidth + 28) * scaleFactor),
                              _buildSlot('E-2', slotWidth, slotHeight),
                              _buildSlot('E-3', slotWidth, slotHeight),
                              _buildSlot('E-4', slotWidth, slotHeight),
                              _buildSlot('E-5', slotWidth, slotHeight),
                            ],
                          ),
                          Row(
                            children: [
                              _buildSlot('F-1', slotWidth, slotHeight),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(height: slotHeight, width: slotWidth),
                          _buildSlot('G-1', slotWidth, slotHeight),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 1 * scaleFactor, left: 4 * scaleFactor),
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 187, 186, 186),
                                borderRadius:
                                    BorderRadius.circular(4 * scaleFactor),
                                border: Border.all(),
                              ),
                              height: slotHeight,
                              width: slotWidth * 2 + 3,
                              child: const Center(
                                child: Text(
                                  'Stair',
                                  style: TextStyle(
                                    fontFamily: 'Quicksand',
                                    fontSize: 16 * scaleFactor,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 3 * scaleFactor),
                        child: Row(
                          children: [
                            SizedBox(
                                height: slotHeight,
                                width: slotWidth + 3.5 * scaleFactor),
                            _buildSlot('G-2', slotWidth, slotHeight),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          _buildSlot('G-3', slotWidth, slotHeight),
                          _buildSlot('G-4', slotWidth, slotHeight),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                          height: slotHeight,
                          width: slotWidth * 2 - 14 * scaleFactor),
                      SizedBox(
                          height: slotHeight,
                          width: slotWidth * 2 - 14 * scaleFactor),
                      SizedBox(
                          height: slotHeight,
                          width: slotWidth * 2 - 14 * scaleFactor),
                      SizedBox(
                          height: slotHeight,
                          width: slotWidth * 2 - 14 * scaleFactor),
                    ],
                  ),
                  Column(
                    children: [
                      _buildSlot('H-1', slotWidth, slotHeight),
                      _buildSlot('H-2', slotWidth, slotHeight),
                      _buildSlot('H-3', slotWidth, slotHeight),
                      _buildSlot('H-4', slotWidth, slotHeight),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 187, 186, 186),
                            borderRadius:
                                BorderRadius.circular(4 * scaleFactor),
                            border: Border.all(),
                          ),
                          width: slotWidth * 3,
                          height: 215 * scaleFactor,
                          child: const Center(
                            child: Text(
                              'Canteen',
                              style: TextStyle(
                                fontFamily: 'Quicksand',
                                fontSize: 16 * scaleFactor,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ]),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSlot(String slotId, double width, double height) {
    final slot = slotDataMap[slotId];
    final status = _getSlotStatus(slot);
    final isSelected = selectedSlot == slotId;
    final color = isSelected
        ? Colors.blue.shade100
        : (status == SlotStatus.NoData
            ? Colors.grey.shade100
            : getSlotColor(status));
    final borderColor = isSelected
        ? Colors.blue
        : (status == SlotStatus.NoData ? Colors.grey : getBorderColor(status));

    return Padding(
      padding: const EdgeInsets.only(left: 2, bottom: 3),
      child: GestureDetector(
        onTap: () {
          _handleSlotTap(slotId);
        },
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: color,
            border: Border.all(color: borderColor, width: 2),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Text(
              slotId,
              style: TextStyle(
                fontSize: width * 0.3,
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.bold,
                color: status == SlotStatus.NoData ? Colors.grey : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
