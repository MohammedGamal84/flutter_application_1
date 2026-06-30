import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/localization/app_language.dart';
import 'package:flutter_application_1/core/localization/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_application_1/home/home_screen.dart';
import 'package:flutter_application_1/auth/screens/auth_screen.dart';
import 'package:flutter_application_1/auth/services/api_service.dart';
import 'package:flutter_application_1/screen_onbord/onbord_screen.dart';
import 'package:flutter_application_1/screen_onbord/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appLanguage = AppLanguage();
  await appLanguage.loadSavedLanguage();

  runApp(
    ChangeNotifierProvider(
      create: (_) => appLanguage,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appLanguage = Provider.of<AppLanguage>(context);

    return MaterialApp(
      navigatorKey: ApiService.navigatorKey,
      debugShowCheckedModeBanner: false,
      locale: appLanguage.locale,
      supportedLocales: const [
        Locale('ar'),
        Locale('en'),
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      initialRoute: "/",
      routes: {
        "/": (context) => const SplashScreen(),
        "/onboarding": (context) => const OnboardingScreen(),
        "/auth": (context) => const AuthScreen(),
        "/home": (context) => const HomesScreen(),
      },
      builder: (context, child) {
        final isArabic = appLanguage.locale.languageCode == 'ar';

        return Directionality(
          textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
          child: child!,
        );
      },
    );
  }
}