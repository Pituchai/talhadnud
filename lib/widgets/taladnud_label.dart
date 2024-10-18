import 'package:flutter/material.dart';
import 'package:talhadnad/theme/talhadnad_theme.dart';

class TaladnudLabel extends StatelessWidget {
  const TaladnudLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                'Find your Market!',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: zomp, // Ensure the color is set correctly
                    ),
              ),
              Text('TaLadNud', style: Theme.of(context).textTheme.labelLarge),
            ],
          ),
          const SizedBox(
            width: 100,
          ),
          Column(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
