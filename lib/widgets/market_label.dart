import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:talhadnad/model/market.dart';

class MarketLabel extends StatefulWidget {
  final String? selectedDate;

  const MarketLabel({this.selectedDate, super.key});

  @override
  State<MarketLabel> createState() => _MarketLabelState();
}

class _MarketLabelState extends State<MarketLabel> {
  bool isLoading = true;
  String errorMessage = '';
  Market? market;

  String _formatDate(String? dateString) {
    if (dateString == null) {
      return 'Date not selected';
    }
    try {
      final date = DateTime.parse(dateString);
      return DateFormat('dd-MM-yyyy').format(date);
    } catch (e) {
      return 'Invalid date';
    }
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate = _formatDate(widget.selectedDate);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Kmutt Market', style: Theme.of(context).textTheme.labelLarge),
          ],
        ),
        Padding(
          padding:
              const EdgeInsets.only(top: 12, left: 16, right: 16, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    '6:00 AM',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Text(
                    formattedDate,
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
              const Row(
                children: [
                  Text(
                    '-',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.calendar_today, color: Colors.white),
                  SizedBox(width: 8),
                  Text(
                    '-',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    '18:00 PM',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Text(
                    formattedDate,
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
