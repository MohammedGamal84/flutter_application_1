import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth/home/home_screen.dart';
import 'package:flutter_application_1/auth/screens/forgot_password_screen.dart';
import 'package:flutter_application_1/auth/services/auth_service.dart';
import 'package:flutter_application_1/auth/widets/auth_header.dart';
import 'package:flutter_application_1/auth/widets/login_form.dart';
import 'package:flutter_application_1/auth/widets/signup_form.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  final Color mainColor = const Color(0xffF36A21);
  final Color greenColor = const Color(0xff6FA23D);

  final AuthService _authService = AuthService();

  bool _isLoading = false;
  bool _obscureLoginPassword = true;
  bool _obscureSignupPassword = true;
  bool _obscureSignupConfirmPassword = true;
  bool _isArabic = true;

  late TabController _tabController;
  final ScrollController scrollController = ScrollController();
  double scrollOffset = 0.0;

  final List<AuthParticle> particles = List.generate(20, (_) => AuthParticle());

  final _loginFormKey = GlobalKey<FormState>();
  final _signupFormKey = GlobalKey<FormState>();

  final _signupNameKey = GlobalKey();
  final _signupEmailKey = GlobalKey();
  final _signupPasswordKey = GlobalKey();
  final _signupConfirmKey = GlobalKey();
  final _loginEmailKey = GlobalKey();
  final _loginPasswordKey = GlobalKey();

  final TextEditingController _loginEmailController = TextEditingController();
  final TextEditingController _loginPasswordController =
      TextEditingController();
  final TextEditingController _signupNameController = TextEditingController();
  final TextEditingController _signupEmailController = TextEditingController();
  final TextEditingController _signupPasswordController =
      TextEditingController();
  final TextEditingController _signupConfirmController =
      TextEditingController();

  bool _loginSubmitted = false;
  bool _signupSubmitted = false;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });

    scrollController.addListener(() {
      if (mounted) {
        setState(() {
          scrollOffset = scrollController.offset;
        });
      }
    });

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

  @override
  void dispose() {
    _tabController.dispose();
    scrollController.dispose();
    _loginEmailController.dispose();
    _loginPasswordController.dispose();
    _signupNameController.dispose();
    _signupEmailController.dispose();
    _signupPasswordController.dispose();
    _signupConfirmController.dispose();
    super.dispose();
  }

  Future<void> _submitLogin() async {
    setState(() {
      _loginSubmitted = true;
    });

    if (!_loginFormKey.currentState!.validate()) return;

    try {
      setState(() {
        _isLoading = true;
      });

      final result = await _authService.login(
        email: _loginEmailController.text.trim(),
        password: _loginPasswordController.text.trim(),
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            result["message"]?.toString() ??
                (_isArabic ? "تم تسجيل الدخول بنجاح" : "Login successful"),
          ),
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString().replaceFirst("Exception: ", ""))),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _submitSignup() async {
    setState(() {
      _signupSubmitted = true;
    });

    if (!_signupFormKey.currentState!.validate()) return;

    try {
      setState(() {
        _isLoading = true;
      });

      final result = await _authService.signup(
        userName: _signupNameController.text.trim(),
        email: _signupEmailController.text.trim(),
        password: _signupPasswordController.text.trim(),
        passwordConfirm: _signupConfirmController.text.trim(),
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            result["message"]?.toString() ??
                (_isArabic
                    ? "تم إنشاء الحساب بنجاح"
                    : "Account created successfully"),
          ),
        ),
      );

      _signupNameController.clear();
      _signupEmailController.clear();
      _signupPasswordController.clear();
      _signupConfirmController.clear();

      _tabController.animateTo(0);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString().replaceFirst("Exception: ", ""))),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _openForgotPassword() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ForgotPasswordScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.of(context).size.width;
    final double h = MediaQuery.of(context).size.height;
    final double bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Directionality(
      textDirection: _isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: Column(
          children: [
            AuthHeader(
              h: h,
              w: w,
              scrollOffset: scrollOffset,
              tabIndex: _tabController.index,
              greenColor: greenColor,
              particles: particles,
              isArabic: _isArabic,
              onLanguageToggle: _toggleLanguage,
            ),
            Expanded(
              child: SafeArea(
                top: false,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: w * 0.03),
                      child: Container(
                        height: 50,
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE5E5E5),
                          borderRadius: BorderRadius.circular(34),
                        ),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            final tabWidth = (constraints.maxWidth - 8) / 2;

                            return Stack(
                              children: [
                                AnimatedAlign(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                  alignment: _tabController.index == 0
                                      ? AlignmentDirectional.centerStart
                                      : AlignmentDirectional.centerEnd,
                                  child: Container(
                                    width: tabWidth,
                                    height: 48,
                                    decoration: BoxDecoration(
                                      color: mainColor,
                                      borderRadius: BorderRadius.circular(25),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.10),
                                          blurRadius: 5,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                TabBar(
                                  controller: _tabController,
                                  indicatorColor: Colors.transparent,
                                  dividerColor: Colors.transparent,
                                  overlayColor: WidgetStateProperty.all(
                                    Colors.transparent,
                                  ),
                                  labelColor: Colors.black,
                                  unselectedLabelColor: greenColor,
                                  labelStyle: TextStyle(
                                    fontSize: w * 0.038,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  unselectedLabelStyle: TextStyle(
                                    fontSize: w * 0.038,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  tabs: [
                                    Tab(
                                      text: _isArabic
                                          ? "تسجيل الدخول"
                                          : "Login",
                                    ),
                                    Tab(
                                      text: _isArabic
                                          ? "إنشاء حساب"
                                          : "Sign Up",
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          SingleChildScrollView(
                            controller: scrollController,
                            padding: EdgeInsets.only(bottom: bottomInset + 16),
                            child: LoginForm(
                              w: w,
                              h: h,
                              formKey: _loginFormKey,
                              submitted: _loginSubmitted,
                              isLoading: _isLoading,
                              obscurePassword: _obscureLoginPassword,
                              mainColor: mainColor,
                              greenColor: greenColor,
                              emailKey: _loginEmailKey,
                              passwordKey: _loginPasswordKey,
                              emailController: _loginEmailController,
                              passwordController: _loginPasswordController,
                              onSubmit: _submitLogin,
                              onTogglePassword: () {
                                setState(() {
                                  _obscureLoginPassword =
                                      !_obscureLoginPassword;
                                });
                              },
                              onForgotPassword: _openForgotPassword,
                              isArabic: _isArabic,
                            ),
                          ),
                          SingleChildScrollView(
                            controller: scrollController,
                            padding: EdgeInsets.only(bottom: bottomInset + 16),
                            child: SignupForm(
                              w: w,
                              formKey: _signupFormKey,
                              submitted: _signupSubmitted,
                              isLoading: _isLoading,
                              obscurePassword: _obscureSignupPassword,
                              obscureConfirmPassword:
                                  _obscureSignupConfirmPassword,
                              mainColor: mainColor,
                              nameKey: _signupNameKey,
                              emailKey: _signupEmailKey,
                              passwordKey: _signupPasswordKey,
                              confirmKey: _signupConfirmKey,
                              nameController: _signupNameController,
                              emailController: _signupEmailController,
                              passwordController: _signupPasswordController,
                              confirmController: _signupConfirmController,
                              onSubmit: _submitSignup,
                              onTogglePassword: () {
                                setState(() {
                                  _obscureSignupPassword =
                                      !_obscureSignupPassword;
                                });
                              },
                              onToggleConfirmPassword: () {
                                setState(() {
                                  _obscureSignupConfirmPassword =
                                      !_obscureSignupConfirmPassword;
                                });
                              },
                              isArabic: _isArabic,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}