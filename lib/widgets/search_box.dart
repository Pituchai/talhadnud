import 'package:flutter/material.dart';
import 'package:talhadnad/theme/talhadnad_theme.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.18,
      left: 36,
      right: 36,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.fromLTRB(15, 25, 15, 25),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Find your Market!',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: oxfordBlue,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            _buildSearchField(),
            const SizedBox(height: 9),
            _buildSearchButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: oxfordBlue),
      ),
      child: const Row(
        children: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Icon(Icons.store, color: oxfordBlue),
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Kmutt Market',
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 46,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: oxfordBlue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        onPressed: () {},
        child: Text(
          'Search',
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }
}
