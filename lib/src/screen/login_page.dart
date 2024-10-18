import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:talhadnad/components/auth/login/loginbody.dart';
import 'package:talhadnad/theme/talhadnad_theme.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: whiteTheme(context),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  child: Center(
                    child: Text(
                      'Welcome back! Glad to see you, Again!',
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge
                          ?.copyWith(color: oxfordBlue),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const LoginBody(),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  child: Center(
                    child: TextButton(
                      onPressed: () {
                        context.go('/register');
                      },
                      child: Text(
                        'Don\'t have an account? Register',
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall
                            ?.copyWith(color: oxfordBlue),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
