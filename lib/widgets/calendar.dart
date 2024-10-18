import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';

class CalendarWidget extends StatefulWidget {
  final Function(DateTime) onDateSelected;
  final List<String> marketCloseDates;
  final String marketId;

  CalendarWidget({
    required this.onDateSelected,
    required this.marketCloseDates,
    required this.marketId,
  });

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  late DateTime _focusedDay;
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
  }

  bool isDateClosed(DateTime date) {
    return widget.marketCloseDates.any((closedDate) {
      DateTime parsedDate = DateTime.parse(closedDate);
      return date.year == parsedDate.year &&
          date.month == parsedDate.month &&
          date.day == parsedDate.day;
    });
  }

  void _showInvalidDateDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Text(
              'Market Closed',
              style: TextStyle(
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.bold,
                color:  Colors.teal
              ),
            ),
          ),
          content: Text(
            message,
            style:
                TextStyle(fontFamily: 'Quicksand', fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text(
                'OK',
                style: TextStyle(
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<String> weekdays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    final firstDayOfMonth = DateTime(_focusedDay.year, _focusedDay.month, 1);
    final daysInMonth =
        DateTime(_focusedDay.year, _focusedDay.month + 1, 0).day;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DateFormat('MMMM yyyy').format(_focusedDay),
                        style: TextStyle(
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.chevron_left,
                              color: Colors.white,
                              size: 24,
                            ),
                            onPressed: () {
                              setState(() {
                                _focusedDay = DateTime(
                                    _focusedDay.year, _focusedDay.month - 1, 1);
                              });
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.chevron_right,
                                color: Colors.white, size: 24),
                            onPressed: () {
                              setState(() {
                                _focusedDay = DateTime(
                                    _focusedDay.year, _focusedDay.month + 1, 1);
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: weekdays
                        .map((day) => Text(day,
                            style: TextStyle(
                              fontFamily: 'Quicksand',
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            )))
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 1,
            ),
            itemCount: 42,
            itemBuilder: (context, index) {
              final int dayOffset = firstDayOfMonth.weekday % 7;
              final int adjustedIndex = index - dayOffset;
              final DateTime date =
                  firstDayOfMonth.add(Duration(days: adjustedIndex));

              if (adjustedIndex >= 0 && adjustedIndex < daysInMonth) {
                bool isClosed = isDateClosed(date);
                bool isToday = date.year == DateTime.now().year &&
                    date.month == DateTime.now().month &&
                    date.day == DateTime.now().day;

                return GestureDetector(
                  onTap: () {
                    if (date.isBefore(DateTime.now())) {
                      _showInvalidDateDialog(
                          "Can't make a reservation for the current day or past days");
                    } else if (isClosed) {
                      _showInvalidDateDialog(
                          "The market is closed on ${DateFormat('MMMM d, yyyy').format(date)}");
                    } else {
                      setState(() {
                        _selectedDay = date;
                      });
                      widget.onDateSelected(date);
                      context.go('/marketDetail/${widget.marketId}/market',
                          extra: date);
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color:
                          _selectedDay != null && _selectedDay!.day == date.day
                              ? Colors.teal.withOpacity(0.3)
                              : null,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '${date.day}',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Quicksand',
                          color: isClosed
                              ? Colors.red
                              : date.isBefore(DateTime.now())
                                  ? Colors.grey
                                  : isToday
                                      ? Colors.blue
                                      : Colors.black,
                          fontWeight: isToday ||
                                  (_selectedDay != null &&
                                      _selectedDay!.day == date.day)
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }
}
