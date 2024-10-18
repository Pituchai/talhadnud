import 'package:flutter/material.dart';
import 'package:talhadnad/theme/talhadnad_theme.dart';
import 'package:talhadnad/widgets/market_card.dart';
import 'package:talhadnad/widgets/taladnud_label.dart';

class MainContent extends StatelessWidget {
  const MainContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: Container(
            color: oxfordBlue,
            child: const Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 60),
                  child: TaladnudLabel(),
                ),
              ],
            ),
          ),
        ),
        Expanded(
            flex: 6,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Spacer(flex: 4),
              Container(
                color: Colors.white,
                child: RefreshIndicator(
                  onRefresh: () async {},
                  child: const SingleChildScrollView(
                    child: Column(
                      children: [
                        MarketCard(),
                      ],
                    ),
                  ),
                ),
              ),
              const Spacer(flex: 1),
            ])),
      ],
    );
  }
}
