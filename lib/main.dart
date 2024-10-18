import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talhadnad/model/user_model.dart';
import 'package:talhadnad/router/app_router.dart';
import 'package:talhadnad/theme/talhadnad_theme.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  // Ensure that plugin services are initialized
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set URL strategy for web applications
  setPathUrlStrategy();

  // Create and initialize the UserModel
  final userModel = UserModel();
  await userModel.loadUserData();

  // If there's no access token, logout the user
  if (userModel.accessToken.isEmpty) {
    await userModel.logout();
  }

  // Initialize the AppRouter with the userModel
  AppRouter.initialize(userModel);

  // Run the app
  runApp(
    ChangeNotifierProvider.value(
      value: userModel,
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Talhadnad',
      routerConfig: AppRouter.router, // Use the static router
      theme: customTheme(context),
      builder: (context, child) {
        return Builder(
          builder: (BuildContext context) {
            return child!;
          },
        );
      },
    );
  }
}