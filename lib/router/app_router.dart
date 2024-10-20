import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:talhadnad/model/user_model.dart';
import 'package:talhadnad/src/screen/edit_profile_page.dart';
import 'package:talhadnad/src/screen/landing_page.dart';
import 'package:talhadnad/src/screen/login_page.dart';
import 'package:talhadnad/src/screen/register_page.dart';
import 'package:talhadnad/src/screen/profile_page.dart';
import 'package:talhadnad/src/screen/payment_page.dart';
import 'package:talhadnad/src/screen/marketDetail_page.dart';
import 'package:talhadnad/src/screen/market_page.dart';
import 'package:talhadnad/src/screen/error_page.dart';

class AppRouter {
  static late UserModel _userModel;

  static void initialize(UserModel userModel) {
    _userModel = userModel;
  }

  static String? _guardRoute(BuildContext context, GoRouterState state) {
    final bool isAuthRoute =
        state.uri.toString() == '/login' || state.uri.toString() == '/register';

    if (!_userModel.isLogged && !isAuthRoute) {
      return '/login';
    }
    if (_userModel.isLogged && isAuthRoute) {
      return '/';
    }

    return null;
  }

  static final GoRouter router = GoRouter(
    initialLocation: '/',
    refreshListenable: _userModel,
    redirect: _guardRoute,
    errorBuilder: (context, state) => ErrorPage(error: state.error),
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const LandingPage(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfilePage(),
      ),
       GoRoute(
        path: '/profile-edit',
        builder: (context, state) => const EditProfilePage(),
      ),
      GoRoute(
        path: '/payment',
        builder: (context, state) => PaymentPage(
          initialRawResponse: state.extra as String? ?? '',
        ),
      ),
      GoRoute(
        path: '/marketDetail/:id',
        builder: (context, state) {
          final String id = state.pathParameters['id']!;
          return MarketDetailPage(id: id);
        },
        routes: [
          GoRoute(
            path: 'market',
            builder: (context, state) {
              final String marketId = state.pathParameters['id']!;
              final DateTime initialSelectedDate = state.extra as DateTime? ?? DateTime.now();
              return Market(
                id: marketId,
                initialSelectedDate: initialSelectedDate,
              );
            },
          ),
        ],
      ),
    ],
  );
} 