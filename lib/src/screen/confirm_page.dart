import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:talhadnad/api_client/lib/api.dart';
import 'package:talhadnad/components/auth/register/registerbody.dart';
import 'package:talhadnad/model/market.dart';
import 'package:talhadnad/model/user_model.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:talhadnad/widgets/market_latout.dart';

class ConfirmPage extends StatefulWidget {
  final ApiEntitiesSlot slot;
  final String? slotID;

  const ConfirmPage({super.key, required this.slot, required this.slotID});

  @override
  State<ConfirmPage> createState() => _ConfirmPageState();
}

class _ConfirmPageState extends State<ConfirmPage> {
  UserModel? userModel;
  DtosGetUserResponse? userData;
  Market? market;
  String selectedPaymentMethod = 'PromptPay';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    setState(() => isLoading = true);
    userModel = Provider.of<UserModel>(context, listen: false);
    try {
      userData = await userModel?.getUserById(userModel!.vendorId);
      market = await userModel?.getMarketById(widget.slot.marketId!);
    } catch (e) {
      if (kDebugMode) {
        print('Failed to load user data: $e');
      }
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primaryColor: Colors.white,
      ),
      child: Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
            title: Text(
              'Payment Details',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.copyWith(color: Colors.black, fontSize: 20),
            )),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildBookingDetails(),
                      const SizedBox(height: 24),
                      _buildPaymentDetails(),
                      const SizedBox(height: 24),
                      _buildPaymentMethod(),
                      const SizedBox(height: 24),
                      _buildPayButton(),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildBookingDetails() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Booking Details',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.copyWith(color: Colors.black, fontSize: 18),
            ),
            const SizedBox(height: 16),
            _buildDetailRow('Market', market?.name ?? 'Unknown'),
            _buildDetailRow('Slot ID', widget.slotID ?? 'Unknown'),
            _buildDetailRow('Booking Date', _formatDate(widget.slot.date)),
            _buildDetailRow('Booking By',
                '${userData?.firstName ?? 'Unknown'} ${userData?.lastName ?? ''}'),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentDetails() {
    final ticketPrice = widget.slot.price ?? 0;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Payment Summary',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.copyWith(color: Colors.black, fontSize: 18),
            ),
            const SizedBox(height: 16),
            _buildDetailRow('Slot Price', '฿${ticketPrice.toStringAsFixed(2)}'),
            const Divider(),
            _buildDetailRow('Total', '฿${ticketPrice.toStringAsFixed(2)}',
                isBold: true),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethod() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Payment Method',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.copyWith(color: Colors.black, fontSize: 18),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: selectedPaymentMethod,
              items: ['PromptPay'].map((method) {
                return DropdownMenuItem(
                  value: method,
                  child: Text(method),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedPaymentMethod = value!;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPayButton() {
    final totalPrice = (widget.slot.price ?? 0);
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          try {
            setState(() => isLoading = true);

            // Convert the selectedPaymentMethod string to EntitiesMethod
            final paymentMethod = EntitiesMethod.values.firstWhere(
              (method) => method.value == selectedPaymentMethod,
              orElse: () => EntitiesMethod.MethodPromptPay,
            );

            final booking = DtosBookingRequest(
              slotId: widget.slot.id,
              vendorId: userModel!.vendorId,
              bookingDate: DateFormat("yyyy-MM-dd")
                  .format(DateTime.parse(widget.slot.date)),
              price: totalPrice,
              method: paymentMethod,
              marketId: widget.slot.marketId!,
            );

            final response = await userModel!.createBooking(booking);

            if (response.statusCode == 200 || response.statusCode == 201) {
              if (mounted) {
                print('Booking created successfully: $response.body');

                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(
                        content: Text('Booking created successfully!')))
                    .closed
                    .then((reason) {
                  if (mounted) {
                    context.go('/payment', extra: response.body);
                  }
                });
              }
            } else {
              if (mounted) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(
                      const SnackBar(
                        content: Text(
                            'Slot is not available : Please select another slot'),
                      ),
                    )
                    .closed
                    .then((reason) {
                  if (mounted) {
                    setState(() => isLoading = false);
                  }
                });
              }
            }
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(
                      'Slot is not available: you already have a pending or confirmed booking for this slot: $e')),
            );
          } finally {
            if (mounted) {
              setState(() => isLoading = false);
            }
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.teal,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : Text(
                'Pay ฿${totalPrice.toStringAsFixed(2)}',
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(String? date) {
    if (date == null) return 'Unknown';
    try {
      final DateTime parsedDate = DateTime.parse(date);
      return DateFormat('MMMM d, yyyy').format(parsedDate);
    } catch (e) {
      return date;
    }
  }
}
