import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:talhadnad/widgets/market_latout.dart';

Color getSlotColor(SlotStatus status) {
  switch (status) {
    case SlotStatus.Selected:
      return Colors.lightGreen;

    case SlotStatus.Booked:
      return Colors.grey.shade400;

    case SlotStatus.NoData:
      return Colors.red;

    case SlotStatus.Available:
      return Colors.greenAccent.shade700;
  }
}

Color getBorderColor(SlotStatus status) {
  switch (status) {
    case SlotStatus.Selected:
      return Colors.lightGreen;

    case SlotStatus.Booked:
      return Colors.grey;

    case SlotStatus.NoData:
      return Colors.red;

    case SlotStatus.Available:
      return Colors.grey;
  }
}
