import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth/home/home_screen.dart';
import 'package:flutter_application_1/auth/screens/auth_screen.dart';
import 'package:flutter_application_1/auth/services/api_service.dart';
import 'package:flutter_application_1/screen_onbord/onbord_screen.dart';
import 'package:flutter_application_1/screen_onbord/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: ApiService.navigatorKey,
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => const SplashScreen(),
        "/onboarding": (context) => const OnboardingScreen(),
        "/auth": (context) => const AuthScreen(),
        "/home": (context) => const HomeScreen(),
      },
    );
  }
}
