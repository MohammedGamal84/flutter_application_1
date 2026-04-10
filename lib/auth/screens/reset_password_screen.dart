import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth/services/auth_service.dart';
import 'package:flutter_application_1/auth/widets/auth_input_field.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;

  const ResetPasswordScreen({
    super.key,
    required this.email,
  });

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final Color mainColor = const Color(0xffF36A21);
  final Color greenColor = const Color(0xff6FA23D);

  final AuthService _authService = AuthService();

  final ScrollController scrollController = ScrollController();
  double scrollOffset = 0.0;

  final List<_Particle> particles = List.generate(20, (_) => _Particle());

  final _formKey = GlobalKey<FormState>();

  final GlobalKey _codeKey = GlobalKey();
  final GlobalKey _passwordKey = GlobalKey();
  final GlobalKey _confirmPasswordKey = GlobalKey();

  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _submitted = false;
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

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
    _codeController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _submitResetPassword() async {
    setState(() {
      _submitted = true;
    });

    if (!_formKey.currentState!.validate()) {
      _scrollToFirstInvalid();
      return;
    }

    try {
      setState(() {
        _isLoading = true;
      });

      final result = await _authService.resetPassword(
        email: widget.email,
        code: _codeController.text.trim(),
        password: _passwordController.text.trim(),
        passwordConfirm: _confirmPasswordController.text.trim(),
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text(result["message"]?.toString() ?? "تم تغيير كلمة المرور بنجاح"),
        ),
      );

      Navigator.pop(context);
      Navigator.pop(context);
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

  void _scrollToFirstInvalid() {
    if (_codeController.text.trim().isEmpty) {
      _scrollToKey(_codeKey);
      return;
    }
    if (_passwordController.text.isEmpty) {
      _scrollToKey(_passwordKey);
      return;
    }
    if (_confirmPasswordController.text.isEmpty) {
      _scrollToKey(_confirmPasswordKey);
      return;
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
    final double w = MediaQuery.of(context).size.width;
    final double h = MediaQuery.of(context).size.height;

    return Scaffold(
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
                    }).toList(),
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
                                Icons.lock_outline,
                                size: w * 0.08,
                                color: greenColor,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "تغيير كلمة المرور",
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
                  child: const Text(
                    "إعادة تعيين كلمة المرور",
                    style: TextStyle(
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
                        "البريد الإلكتروني: ${widget.email}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: w * 0.08),
                      child: const Align(
                        alignment: Alignment.centerRight,
                        child: Text("الكود"),
                      ),
                    ),
                    AuthInputField(
                      fieldKey: _codeKey,
                      w: w,
                      hint: "أدخل الكود المرسل",
                      icon: Icons.verified_user_outlined,
                      controller: _codeController,
                      validator: (value) {
                        if (!_submitted) return null;
                        if (value == null || value.trim().isEmpty) {
                          return "الكود مطلوب";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: w * 0.08),
                      child: const Align(
                        alignment: Alignment.centerRight,
                        child: Text("كلمة المرور الجديدة"),
                      ),
                    ),
                    AuthInputField(
                      fieldKey: _passwordKey,
                      w: w,
                      hint: "أدخل كلمة المرور الجديدة",
                      icon: Icons.lock_outline,
                      controller: _passwordController,
                      isPassword: true,
                      obscureText: _obscurePassword,
                      onToggleObscure: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                      validator: (value) {
                        if (!_submitted) return null;
                        if (value == null || value.isEmpty) {
                          return "كلمة المرور الجديدة مطلوبة";
                        }
                        if (value.length < 6) {
                          return "كلمة المرور يجب أن تكون 6 أحرف على الأقل";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: w * 0.08),
                      child: const Align(
                        alignment: Alignment.centerRight,
                        child: Text("تأكيد كلمة المرور"),
                      ),
                    ),
                    AuthInputField(
                      fieldKey: _confirmPasswordKey,
                      w: w,
                      hint: "أعد إدخال كلمة المرور الجديدة",
                      icon: Icons.lock_outline,
                      controller: _confirmPasswordController,
                      isPassword: true,
                      obscureText: _obscureConfirmPassword,
                      onToggleObscure: () {
                        setState(() {
                          _obscureConfirmPassword =
                              !_obscureConfirmPassword;
                        });
                      },
                      validator: (value) {
                        if (!_submitted) return null;
                        if (value == null || value.isEmpty) {
                          return "تأكيد كلمة المرور مطلوب";
                        }
                        if (value != _passwordController.text) {
                          return "كلمة المرور غير متطابقة";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 25),
                    SizedBox(
                      width: w * 0.9,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: mainColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 6,
                          shadowColor: Colors.black.withOpacity(0.2),
                        ),
                        onPressed: _isLoading ? null : _submitResetPassword,
                        child: _isLoading
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                "تغيير كلمة المرور",
                                style: TextStyle(fontSize: w * 0.045),
                              ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Particle {
  double x = Random().nextDouble();
  double y = Random().nextDouble();
  double size = Random().nextDouble() * 4 + 2;
  double opacity = Random().nextDouble() * 0.5 + 0.3;
}