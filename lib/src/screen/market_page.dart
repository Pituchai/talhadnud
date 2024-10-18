import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:talhadnad/api_client/lib/api.dart' as api;
import 'package:talhadnad/widgets/market_latout.dart' as widgets;
import 'package:talhadnad/model/user_model.dart';
import 'package:talhadnad/theme/talhadnad_theme.dart';
import 'package:talhadnad/widgets/SmoothZoom.dart';
import 'package:talhadnad/widgets/market_label.dart';
import 'package:talhadnad/widgets/status_area.dart';

class Market extends StatefulWidget {
  final String id;

  final DateTime initialSelectedDate;

  const Market({required this.id, required this.initialSelectedDate, super.key});

  @override
  _MarketPageState createState() => _MarketPageState();
}

class _MarketPageState extends State<Market> {
  late DateTime selectedDate;
  String? selectedSlot;
  List<api.EntitiesSlot>? slotsData;
  bool hasSlotData = false;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialSelectedDate ?? DateTime.now();
      loadSlotByDate(widget.id, widget.initialSelectedDate);
  
  }

  void _handleSlotSelection(String? slotId) {
    if (hasSlotData) {
      setState(() {
        selectedSlot = slotId;
      });
    }
  }

  Future<void> loadSlotByDate(String marketID, DateTime date) async {
    try {
      final userModel = Provider.of<UserModel>(context, listen: false);
      final List<api.EntitiesSlot>? newSlotsData =
          await userModel.getSlotsByMarketIdAndDate(
              marketID, DateFormat('yyyy-MM-dd').format(date));

      setState(() {
        slotsData = newSlotsData;
        selectedSlot = null;
        hasSlotData = newSlotsData != null && newSlotsData.isNotEmpty;
      });

      if (!hasSlotData) {
        _showNoSlotsFoundBottomSheet(date);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error in loadSlotByDate: $e');
      }
      if (!mounted) return;
      _showAlertBottomSheet(
          'Error', 'Failed to load slots. Please try again later.');
      setState(() {
        slotsData = null;
        selectedSlot = null;
        hasSlotData = false;
      });
    }
  }

  void _showNoSlotsFoundBottomSheet(DateTime date) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          height: 250,
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.event_busy,
                        size: 50,
                        color: Colors.orange,
                      ),
                      const SizedBox(height: 15),
                      Text(
                        'No Slots Available',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'No slots found for ${DateFormat('MMMM d, y').format(date)}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Please select another date to view available slots.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                          fontStyle: FontStyle.italic,
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
    );
  }

  void _showAlertBottomSheet(String title, String message) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          width: double.infinity,
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.info_outline,
                        size: 50,
                        color: Colors.blue,
                      ),
                      const SizedBox(height: 15),
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        message,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          
          Expanded(
            flex: 2,
            child: Container(
              decoration: const BoxDecoration(
                color: oxfordBlue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  MarketLabel(
                    selectedDate: DateFormat('yyyy-MM-dd').format(widget.initialSelectedDate),
                  ),
                  const StatusArea(),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              color: Colors.white,
              child: SmoothZoomArea(
                child: Center(
                  child: AspectRatio(
                    aspectRatio: 0.8,
                    child: hasSlotData
                        ? widgets.MarketLayout(
                            onSlotSelected: _handleSlotSelection,
                            slots: slotsData,
                          )
                        : const Center(
                            child: Text(
                              'No slots available for the selected date.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                  ),
                ),
              ),
            ),
          ),
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              color: const Color.fromARGB(255, 245, 245, 245),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Slot',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        hasSlotData
                            ? (selectedSlot ?? 'Please select a slot')
                            : 'No slots available',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}