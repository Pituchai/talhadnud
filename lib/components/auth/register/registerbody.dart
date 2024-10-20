import 'package:flutter/material.dart';
import 'package:http/src/response.dart';
import 'package:provider/provider.dart';
import 'package:talhadnad/api_client/lib/api.dart';
import 'package:talhadnad/model/user_model.dart';
import 'package:go_router/go_router.dart';
import 'package:talhadnad/theme/talhadnad_theme.dart';

class RegisterBody extends StatefulWidget {
  const RegisterBody({super.key});

  @override
  State<RegisterBody> createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody> {
  final usertNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String? _errorMessage;
  DtosRegisterResponse? registerResponse;

  @override
  void dispose() {
    usertNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      try {
        Response registerResponse =
            await Provider.of<UserModel>(context, listen: false).registerUser(
          DtosRegisterRequest(
            username: usertNameController.text,
            email: emailController.text,
            password: passwordController.text,
            phoneNumber: phoneController.text,
          ),
        );

        print('registerResponse: $registerResponse');
        print('Registration Status Code: ${registerResponse.statusCode}');
        print('Registration Response Body: ${registerResponse.body}');


        if (!mounted) return;

        if (registerResponse != null) {
          GoRouter.of(context).go('/');
        } else {
          setState(() {
                      _errorMessage = 'Registration failed. Status: ${registerResponse.statusCode}';

          });
        }
      } catch (e) {
        if (!mounted) return;

        setState(() {
          _errorMessage = 'Registration failed: ${e.toString()}';
        });
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Fill your stall information',
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(color: oxfordBlue),
            ),
            // First Name Input Field
            _buildTextField(
              controller: usertNameController,
              hint: 'Username',
              icon: Icons.person,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your Username';
                }
                return null;
              },
            ),

            // Email Input Field
            _buildTextField(
              controller: emailController,
              hint: 'Email',
              icon: Icons.email,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
            ),
            _buildTextField(
              controller: phoneController,
              hint: 'Phone',
              icon: Icons.phone,
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please put your phone number';
                }
                return null;
              },
            ),
            // Password Input Field
            _buildTextField(
              controller: passwordController,
              hint: 'Password',
              icon: Icons.lock,
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a password';
                }
                return null;
              },
            ),

            // Error Message Display
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            SizedBox(height: height * 0.02),
            ElevatedButton(
              onPressed: _isLoading ? null : _register,
              child: SizedBox(
                width: double.infinity,
                child: Center(
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Register',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool obscureText = false,
    String? Function(String?)? validator,
  }) {
    return Container(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
      margin: const EdgeInsets.only(top: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        border: Border.all(color: Colors.grey),
      ),
      child: Row(
        children: <Widget>[
          Icon(icon, color: Colors.grey),
          SizedBox(width: MediaQuery.of(context).size.width * 0.04),
          Expanded(
            child: TextFormField(
              controller: controller,
              obscureText: obscureText,
              validator: validator,
              decoration: InputDecoration.collapsed(
                hintText: hint,
                hintStyle: const TextStyle(
                    color: Colors.grey, fontFamily: 'Quicksand'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
