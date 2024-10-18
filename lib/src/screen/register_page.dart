import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:talhadnad/components/auth/register/registerbody.dart';
import 'package:talhadnad/theme/talhadnad_theme.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: whiteTheme(context),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text('Register', style: TextStyle(color: Colors.black)),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              context.go('/login');
            },
          ),
        ),
        body: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(20.0),
              child: RegisterBody(),
            ),
          ],
        ),
      ),
    );
  }
}
