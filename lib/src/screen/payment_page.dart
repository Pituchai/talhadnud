import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:talhadnad/theme/talhadnad_theme.dart';
import 'package:intl/intl.dart';

class PaymentPage extends StatefulWidget {
  final String initialRawResponse;

  const PaymentPage({
    super.key,
    required this.initialRawResponse,
  });

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> with WidgetsBindingObserver {
  static const Color primaryColor = Color(0xFF14213D);
  static const double defaultPadding = 16.0;

  Timer? _timer;
  late DateTime _expiresAt;
  late DateTime _bookingDate;
  late Duration _timeRemaining;
  bool _dialogShown = false;
  late Future<Map<String, dynamic>> _ticketDataFuture;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _ticketDataFuture = _initializeData(widget.initialRawResponse);
    _startTimer();
  }

  Future<Map<String, dynamic>> _initializeData(String rawResponse) async {
    try {
      final Map<String, dynamic> responseJson = json.decode(rawResponse);
      final ticketData = responseJson['data'];
      _bookingDate = DateFormat('yyyy-MM-dd')
          .parse(ticketData['bookingDate'] as String)
          .toLocal();
      _expiresAt = DateTime.parse(ticketData['expiresAt'] as String).toLocal();
      _timeRemaining = _expiresAt.difference(DateTime.now());
      return ticketData;
    } catch (e) {
      print('Error parsing response body: $e');
      return {};
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        _timeRemaining = _expiresAt.difference(DateTime.now());
        if (_timeRemaining.isNegative) {
          _timeRemaining = Duration.zero;
          _timer?.cancel();
          _showTimeoutDialog();
        }
      });
    });
  }

  void _showTimeoutDialog() {
    if (!_dialogShown) {
      _dialogShown = true;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext dialogContext) =>
            _buildTimeoutDialog(dialogContext),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: whiteTheme(context),
      child: Scaffold(
        appBar: _buildAppBar(),
        body: FutureBuilder<Map<String, dynamic>>(
          future: _ticketDataFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No data available'));
            }

            final ticketData = snapshot.data!;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTotalAmount(ticketData),
                    _buildInfoBox(),
                    const SizedBox(height: 24),
                    _buildQRCodeSection(ticketData),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => context.go('/'),
      ),
      title: const Text(
        'Payment Details',
        style: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
    );
  }

  Widget _buildTotalAmount(Map<String, dynamic> ticketData) {
    return _buildInfoRow(
      'Total Amount',
      '฿${ticketData['price'].toStringAsFixed(2)}',
      isTotal: true,
    );
  }

  Widget _buildInfoBox() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: _buildBoxDecoration(),
      child: Column(
        children: [
          _buildInfoItem('Time Remaining', _formatDuration(_timeRemaining)),
          _buildDivider(),
          _buildInfoItem('Please pay within', _formatDateTime(_expiresAt)),
          _buildDivider(),
          _buildInfoItem('Booking area on date', _formatDateTime(_bookingDate)),
        ],
      ),
    );
  }

  Widget _buildQRCodeSection(Map<String, dynamic> ticketData) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(defaultPadding),
        decoration: _buildBoxDecoration(),
        child: Column(
          children: [
            const Text(
              'THAI QR PAYMENT',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            const SizedBox(height: defaultPadding),
            StableQRCode(imageData: ticketData['image']),
            const SizedBox(height: defaultPadding),
            Text(
              '฿${ticketData['price'].toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Talhadnud (THAILAND) CO.,LTD',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Text(
              'Reference no. ${ticketData['transactionId']}',
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: _buildBoxDecoration(),
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: isTotal ? Colors.black : Colors.black87,
                  fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
                  fontSize: isTotal ? 18 : 16,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: isTotal ? 18 : 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          spreadRadius: 2,
          blurRadius: 5,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }

  Widget _buildDivider() => Divider(height: 1, color: Colors.grey[300]);

  String _formatDuration(Duration duration) {
    if (duration.isNegative) return "Expired";
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${duration.inHours}:$twoDigitMinutes:$twoDigitSeconds";
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('dd MMM yyyy, HH:mm:ss').format(dateTime);
  }

  Widget _buildTimeoutDialog(BuildContext dialogContext) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
                color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Time out',
              style: TextStyle(
                fontFamily: 'Quicksand',
                color: primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'The payment time has expired.',
              style: TextStyle(
                fontFamily: 'Quicksand',
                color: primaryColor,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                  ),
                  child: const Text(
                    'OK',
                    style: TextStyle(
                      fontFamily: 'Quicksand',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                    GoRouter.of(context).go('/reservation');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}

class StableQRCode extends StatelessWidget {
  final String imageData;
  final double size;

  const StableQRCode({Key? key, required this.imageData, this.size = 200})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imageData.isNotEmpty) {
      return Image.memory(
        base64Decode(imageData),
        width: size,
        height: size,
        fit: BoxFit.contain,
        gaplessPlayback: true,
      );
    } else {
      return Container(
        width: size,
        height: size,
        color: Colors.grey[300],
        child: const Center(
          child: Text(
            'QR Code Placeholder',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black54),
          ),
        ),
      );
    }
  }
}
