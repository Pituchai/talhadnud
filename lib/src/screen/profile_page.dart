import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:talhadnad/theme/talhadnad_theme.dart';
import 'package:talhadnad/widgets/BottomNavBar.dart';
import 'package:talhadnad/model/user_model.dart';

// Mock data for a vendor
class VendorMockData {
  final String id;
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String phone;
  final String image;

  VendorMockData({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.image,
  });
}

// Create a mock vendor
final mockVendor = VendorMockData(
  id: "1",
  username: "kayalvishi",
  email: "kayal.vishi@example.com",
  firstName: "Kayal",
  lastName: "Vishi",
  phone: "+66 6282 283 8324",
  image: "https://upload.wikimedia.org/wikipedia/commons/thumb/4/48/Outdoors-man-portrait_%28cropped%29.jpg/1200px-Outdoors-man-portrait_%28cropped%29.jpg", // You can replace this with a local asset path
);

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userModel = Provider.of<UserModel>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.265,
            color: oxfordBlue,
            child: Column(
              children: [
                const SizedBox(height: 50),
                const Text(
                  'Profile',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                _buildProfileHeader(mockVendor),
              ],
            ),
          ),
          Expanded(
            child: Container(
              height: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: ListView(
                padding: EdgeInsets.all(20),
                children: [
                  _buildMenuItem('My Bookings', Icons.calendar_today_outlined,
                      () {
                    context.push('/myBookings');
                  }),
                  _buildMenuItem(
                      'Wallet', Icons.account_balance_wallet_outlined, () {
                    context.push('/wallet');
                  }),
                  _buildMenuItem('Refer & Earn', Icons.card_giftcard_outlined,
                      () {
                    context.push('/referAndEarn');
                  }),
                  _buildMenuItem('Help & Support', Icons.help_outline, () {
                    context.push('/helpAndSupport');
                  }),
                  _buildMenuItem('About Us', Icons.info_outline, () {
                    context.push('/aboutUs');
                  }),
                  SizedBox(height: 20),
                  _buildLogoutButton(context, userModel),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(selectedIndex: 3),
    );
  }

  Widget _buildProfileHeader(VendorMockData vendor) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(vendor.image),
                backgroundColor: Colors.blue,
                child: vendor.image.isEmpty
                    ? Icon(Icons.person, size: 50, color: Colors.white)
                    : null,
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Text(
                    '${vendor.firstName} ${vendor.lastName}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    vendor.phone,
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ],
          ),
          IconButton(
            icon: Icon(
              Icons.edit_note,
              color: Colors.white,
              size: 34,
            ),
            onPressed: () {
              // TODO: Add functionality for editing profile
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(String title, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Icon(icon, color: oxfordBlue),
            SizedBox(width: 20),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: oxfordBlue,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Icon(Icons.chevron_right, color: oxfordBlue),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context, UserModel userModel) {
    return Container(
      width: 10,
      height: 45,
      padding: EdgeInsets.symmetric(horizontal: 130),
      child: ElevatedButton(
        onPressed: () async {
          bool confirm = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Center(
                        child: Text(
                      'Logout',
                      style: TextStyle(
                          fontFamily: 'Quicksand', fontWeight: FontWeight.bold),
                    )),
                    content: Text(
                      'Are you sure you want to logout?',
                      style: TextStyle(
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                    actions: <Widget>[
                      ElevatedButton(
                        child: Text(
                          'Yes',
                          style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        ),
                        onPressed: () => Navigator.of(context).pop(true),
                      ),
                      ElevatedButton(
                        child: Text(
                          'No',
                          style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        ),
                        onPressed: () => Navigator.of(context).pop(false),
                      ),
                    ],
                  );
                },
              ) ??
              false;

          if (confirm) {
            await userModel.logout();
            context.go('/login');
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.logout, color: Colors.white, size: 20),
            SizedBox(width: 8),
            Text(
              'Logout',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}