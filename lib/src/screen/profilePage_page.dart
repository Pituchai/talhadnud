// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';

// class ProfilePage extends StatelessWidget {
//   const ProfilePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF1E2F4D), // Dark blue background
//       body: SafeArea(
//         child: Column(
//           children: [
//             _buildHeader(),
//             Expanded(
//               child: Container(
//                 decoration: const BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(30),
//                     topRight: Radius.circular(30),
//                   ),
//                 ),
//                 child: _buildProfileContent(),
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: _buildBottomNavBar(context),
//     );
//   }

//   Widget _buildHeader() {
//     return Padding(
//       padding: const EdgeInsets.all(20),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           const Text(
//             'Profile',
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           IconButton(
//             icon: const Icon(Icons.notifications_outlined, color: Colors.white),
//             onPressed: () {/* TODO: Implement notification */},
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildProfileContent() {
//     return ListView(
//       padding: const EdgeInsets.all(20),
//       children: [
//         const CircleAvatar(
//           radius: 50,
//           backgroundImage:
//               NetworkImage('https://example.com/profile_image.jpg'),
//         ),
//         const SizedBox(height: 20),
//         const Text(
//           'Kayal Vishi',
//           textAlign: TextAlign.center,
//           style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 5),
//         const Text(
//           '+1 6282 283 8324',
//           textAlign: TextAlign.center,
//           style: TextStyle(color: Colors.grey),
//         ),
//         const SizedBox(height: 30),
//         _buildProfileMenuItem(Icons.bookmark, 'My Bookings'),
//         _buildProfileMenuItem(Icons.account_balance_wallet, 'Wallet'),
//         _buildProfileMenuItem(Icons.card_giftcard, 'Refer & Earn'),
//         _buildProfileMenuItem(Icons.help_outline, 'Help & Support'),
//         _buildProfileMenuItem(Icons.info_outline, 'About Us'),
//         const SizedBox(height: 20),
//       ],
//     );
//   }

//   Widget _buildProfileMenuItem(IconData icon, String title) {
//     return ListTile(
//       leading: Icon(icon, color: const Color(0xFF1E2F4D)),
//       title: Text(title),
//       trailing: const Icon(Icons.chevron_right),
//       onTap: () {/* TODO: Implement navigation */},
//     );
//   }

//   Widget _buildBottomNavBar(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 10,
//             offset: const Offset(0, -5),
//           ),
//         ],
//       ),
//       child: BottomNavigationBar(
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//           BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Market'),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.qr_code_scanner), label: 'Scan'),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.account_balance_wallet), label: 'Wallet'),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
//         ],
//         currentIndex: 4, // Profile tab
//         selectedItemColor: const Color(0xFF1E2F4D),
//         unselectedItemColor: Colors.grey,
//         showUnselectedLabels: true,
//         type: BottomNavigationBarType.fixed,
//       ),
//     );
//   }
// }
