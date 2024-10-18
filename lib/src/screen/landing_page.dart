import 'package:flutter/material.dart';
import 'package:talhadnad/src/screen/main_content.dart';
import 'package:talhadnad/widgets/BottomNavBar.dart';
import 'package:talhadnad/widgets/search_box.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          MainContent(),
          SearchBox(),
        ],
      ),
      bottomNavigationBar: BottomNavBar(selectedIndex: 0),
    );
  }
}
