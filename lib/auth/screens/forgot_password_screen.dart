import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth/screens/reset_password_screen.dart';
import 'package:flutter_application_1/auth/services/auth_service.dart';
import 'package:flutter_application_1/auth/widets/auth_input_field.dart';
import 'package:flutter_application_1/core/localization/app_language.dart';
import 'package:flutter_application_1/core/localization/app_localizations.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final Color mainColor = const Color(0xffF36A21);
  final Color greenColor = const Color(0xff6FA23D);

  final AuthService _authService = AuthService();

  final ScrollController scrollController = ScrollController();
  double scrollOffset = 0.0;

  final List<_Particle> particles = List.generate(20, (_) => _Particle());

  final _formKey = GlobalKey<FormState>();
  final GlobalKey _emailKey = GlobalKey();
  final TextEditingController _emailController = TextEditingController();

  bool _submitted = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      setState(() {
        scrollOffset = scrollController.offset;
      });
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _submitForgotPassword() async {
    setState(() {
      _submitted = true;
    });

    if (!_formKey.currentState!.validate()) {
      _scrollToKey(_emailKey);
      return;
    }

    final tr = AppLocalizations.of(context);

    try {
      setState(() {
        _isLoading = true;
      });

      final result = await _authService.forgotPassword(
        email: _emailController.text.trim(),
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            result["message"]?.toString() ??
                tr.translate('forgot_password_success'),
          ),
        ),
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ResetPasswordScreen(
            email: _emailController.text.trim(),
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString().replaceFirst("Exception: ", "")),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _scrollToKey(GlobalKey key) {
    final currentContext = key.currentContext;
    if (currentContext != null) {
      Scrollable.ensureVisible(
        currentContext,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        alignment: 0.3,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context);
    final isArabic = context.watch<AppLanguage>().locale.languageCode == 'ar';
    final double w = MediaQuery.of(context).size.width;
    final double h = MediaQuery.of(context).size.height;

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                SizedBox(
                  height: h * 0.35,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Transform.translate(
                        offset: Offset(0, scrollOffset * 0.2),
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/gemy2.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.white.withOpacity(0.9),
                            ],
                          ),
                        ),
                      ),
                      ...particles.map((p) {
                        return Positioned(
                          left: p.x * w,
                          top: ((p.y + scrollOffset * 0.05) % 1) * h * 0.35,
                          child: Opacity(
                            opacity: p.opacity,
                            child: Container(
                              width: p.size,
                              height: p.size,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.7),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        );
                      }),
                      Positioned(
                        bottom: h * 0.03 - scrollOffset * 0.1,
                        child: Column(
                          children: [
                            Hero(
                              tag: 'auth_icon',
                              child: Container(
                                padding: EdgeInsets.all(w * 0.035),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 6,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.lock_reset,
                                  size: w * 0.08,
                                  color: greenColor,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              tr.translate('forgot_password_title'),
                              style: TextStyle(
                                fontSize: w * 0.06,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    blurRadius: 6,
                                    color: Colors.black.withOpacity(0.2),
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: w * 0.06),
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: mainColor,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      tr.translate('recover_password'),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: w * 0.08),
                        child: Text(
                          tr.translate('forgot_password_subtitle'),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: w * 0.08),
                        child: Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(tr.translate('email')),
                        ),
                      ),
                      AuthInputField(
                        fieldKey: _emailKey,
                        w: w,
                        hint: tr.translate('enter_email'),
                        icon: Icons.email_outlined,
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (!_submitted) return null;
                          if (value == null || value.trim().isEmpty) {
                            return tr.translate('email_required');
                          }
                          if (!value.contains('@')) {
                            return tr.translate('invalid_email');
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 25),
                      SizedBox(
                        width: w * 0.9,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _submitForgotPassword,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: mainColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: _isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text(
                                  tr.translate('send_code'),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                    ],
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

class _Particle {
  double x = Random().nextDouble();
  double y = Random().nextDouble();
  double size = Random().nextDouble() * 6 + 2;
  double opacity = Random().nextDouble() * 0.6 + 0.2;
}