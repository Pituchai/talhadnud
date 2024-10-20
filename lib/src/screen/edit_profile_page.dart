import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talhadnad/model/user_model.dart';
import 'package:talhadnad/api_client/lib/api.dart';
import 'package:talhadnad/theme/talhadnad_theme.dart';

class UserDTOWrapper {
  final DtosGetUserResponse _userResponse;
  final DtosUpdateUserRequest _updateRequest;

  UserDTOWrapper(this._userResponse) : _updateRequest = DtosUpdateUserRequest();

  String? get username => _userResponse.username;
  set username(String? value) => _updateRequest.username = value;

  String? get email => _userResponse.email;
  set email(String? value) => _updateRequest.email = value;

  String? get firstName => _userResponse.firstName;
  set firstName(String? value) => _updateRequest.first_name = value;

  String? get lastName => _userResponse.lastName;
  set lastName(String? value) => _updateRequest.last_name = value;

  // since user_get_response don't have phone value to get
  // String? get phone => _userResponse.phone;
  // set phone(String? value) => _updateRequest.phone = value;

  String? get id => _userResponse.id;

  DtosUpdateUserRequest toUpdateRequest() => _updateRequest;

  static UserDTOWrapper fromGetUserResponse(DtosGetUserResponse response) {
    return UserDTOWrapper(response);
  }
}

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  // We'll keep the _phoneController, but won't use it for updates yet
  late TextEditingController _phoneController;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final userModel = Provider.of<UserModel>(context, listen: false);
    final vendorDetails = userModel.vendorDetails;
    if (vendorDetails != null) {
      final userWrapper = UserDTOWrapper.fromGetUserResponse(vendorDetails);

      print('Vendor Details in EditProfilePage: ${vendorDetails.toJson()}');
      _usernameController = TextEditingController(text: userWrapper.username);
      _emailController = TextEditingController(text: userWrapper.email);
      _firstNameController = TextEditingController(text: userWrapper.firstName);
      _lastNameController = TextEditingController(text: userWrapper.lastName);
      _phoneController =
          TextEditingController(); // Initialize with empty string for now

      print('Controllers initialized with:');
      print('Username: ${_usernameController.text}');
      print('Email: ${_emailController.text}');
      print('FirstName: ${_firstNameController.text}');
      print('LastName: ${_lastNameController.text}');
      print('Phone: ${_phoneController.text}');
    } else {
      print('Vendor Details are null');
      _usernameController = TextEditingController();
      _emailController = TextEditingController();
      _firstNameController = TextEditingController();
      _lastNameController = TextEditingController();
      _phoneController = TextEditingController();
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _updateProfile() async {
    setState(() {
      _isLoading = true;
    });

    final userModel = Provider.of<UserModel>(context, listen: false);

    if (userModel.vendorDetails != null) {
      final userWrapper =
          UserDTOWrapper.fromGetUserResponse(userModel.vendorDetails!);

      userWrapper.username = _usernameController.text;
      userWrapper.email = _emailController.text;
      userWrapper.firstName = _firstNameController.text;
      userWrapper.lastName = _lastNameController.text;
      //userWrapper.phone = _phoneController.text;

      final updateRequest = userWrapper.toUpdateRequest();

      try {
        print('Sending update request: ${updateRequest.toJson()}');
        await userModel.updateProfile(updateRequest);
        print('Profile updated successfully');

        await userModel.fetchVendorDetails();
        print('Refreshed user details: ${userModel.vendorDetails?.toJson()}');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile updated successfully')),
        );

        if (userModel.vendorDetails != null) {
          final refreshedWrapper =
              UserDTOWrapper.fromGetUserResponse(userModel.vendorDetails!);
          setState(() {
            _usernameController.text = refreshedWrapper.username ?? '';
            _emailController.text = refreshedWrapper.email ?? '';
            _firstNameController.text = refreshedWrapper.firstName ?? '';
            _lastNameController.text = refreshedWrapper.lastName ?? '';
            // _phoneController.text = refreshedWrapper.phone ?? '';
          });
        }

        Navigator.of(context).pop();
      } catch (e) {
        print('Error updating profile: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update profile: $e')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      print('Cannot update profile: Vendor Details are null');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text('Failed to update profile: User details not available')),
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        backgroundColor: oxfordBlue,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _firstNameController,
                    decoration: InputDecoration(
                      labelText: 'First Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _lastNameController,
                    decoration: InputDecoration(
                      labelText: 'Last Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                      labelText: 'Phone (Not updatable yet)',
                      border: OutlineInputBorder(),
                    ),
                    enabled: false, // Disable the phone field for now
                  ),
                  SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _isLoading ? null : _updateProfile,
                    child: Text('Update Profile'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: oxfordBlue,
                      padding:
                          EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
