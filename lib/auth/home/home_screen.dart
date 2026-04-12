import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth/screens/auth_screen.dart';
import 'package:flutter_application_1/auth/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isArabic = true;

  @override
  void initState() {
    super.initState();
    _loadLanguage();
  }

  Future<void> _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final savedIsArabic = prefs.getBool('isArabic');

    if (mounted) {
      setState(() {
        _isArabic = savedIsArabic ?? true;
      });
    }
  }

  Future<void> _toggleLanguage() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      _isArabic = !_isArabic;
    });

    await prefs.setBool('isArabic', _isArabic);
  }

  Future<void> logout(BuildContext context) async {
    await AuthService().logout();

    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const AuthScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: _isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_isArabic ? "الرئيسية" : "Home"),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: _toggleLanguage,
              icon: const Icon(Icons.language),
              tooltip: _isArabic ? "تغيير اللغة" : "Change language",
            ),
            IconButton(
              onPressed: () => logout(context),
              icon: const Icon(Icons.logout),
              tooltip: _isArabic ? "تسجيل الخروج" : "Logout",
            ),
          ],
        ),
        body: Center(
          child: Text(
            _isArabic ? "أهلاً بيك 👋" : "Welcome 👋",
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}