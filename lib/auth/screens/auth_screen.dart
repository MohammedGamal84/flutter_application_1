import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth/screens/forgot_password_screen.dart';
import 'package:flutter_application_1/auth/services/auth_service.dart';
import 'package:flutter_application_1/auth/widets/auth_header.dart';
import 'package:flutter_application_1/auth/widets/login_form.dart';
import 'package:flutter_application_1/auth/widets/signup_form.dart';

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

  late TabController _tabController;
  final ScrollController scrollController = ScrollController();
  double scrollOffset = 0.0;

  final List<AuthParticle> particles =
      List.generate(20, (_) => AuthParticle());

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
      setState(() {});
    });

    scrollController.addListener(() {
      setState(() {
        scrollOffset = scrollController.offset;
      });
    });
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

    if (!_loginFormKey.currentState!.validate()) {
      _scrollToFirstEmptyLogin();
      return;
    }

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
          content:
              Text(result["message"]?.toString() ?? "تم تسجيل الدخول بنجاح"),
        ),
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

    if (!_signupFormKey.currentState!.validate()) {
      _scrollToFirstEmptySignup();
      return;
    }

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
          content: Text(result["message"]?.toString() ?? "تم إنشاء الحساب بنجاح"),
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

  void _scrollToFirstEmptyLogin() {
    final fields = [
      {'key': _loginEmailKey, 'controller': _loginEmailController},
      {'key': _loginPasswordKey, 'controller': _loginPasswordController},
    ];

    for (var field in fields) {
      if ((field['controller'] as TextEditingController).text.trim().isEmpty) {
        _scrollToKey(field['key'] as GlobalKey);
        break;
      }
    }
  }

  void _scrollToFirstEmptySignup() {
    final fields = [
      {'key': _signupNameKey, 'controller': _signupNameController},
      {'key': _signupEmailKey, 'controller': _signupEmailController},
      {'key': _signupPasswordKey, 'controller': _signupPasswordController},
      {'key': _signupConfirmKey, 'controller': _signupConfirmController},
    ];

    for (var field in fields) {
      if ((field['controller'] as TextEditingController).text.trim().isEmpty) {
        _scrollToKey(field['key'] as GlobalKey);
        break;
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

  void _openForgotPassword() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const ForgotPasswordScreen(),
      ),
    );
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
              AuthHeader(
                h: h,
                w: w,
                scrollOffset: scrollOffset,
                tabIndex: _tabController.index,
                greenColor: greenColor,
                particles: particles,
              ),
              const SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: w * 0.06),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Stack(
                    children: [
                      AnimatedAlign(
                        duration: const Duration(milliseconds: 400),
                        alignment: _tabController.index == 0
                            ? Alignment.centerLeft
                            : Alignment.centerRight,
                        curve: Curves.easeInOut,
                        child: Container(
                          width: w * 0.42,
                          height: 44,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: LinearGradient(
                              colors: [mainColor.withOpacity(0.8), mainColor],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                        ),
                      ),
                      TabBar(
                        controller: _tabController,
                        indicatorColor: Colors.transparent,
                        labelColor: Colors.black,
                        unselectedLabelColor: greenColor,
                        tabs: const [
                          Tab(text: "تسجيل الدخول"),
                          Tab(text: "إنشاء حساب"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 25),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    LoginForm(
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
                          _obscureLoginPassword = !_obscureLoginPassword;
                        });
                      },
                      onForgotPassword: _openForgotPassword,
                    ),
                    SignupForm(
                      w: w,
                      formKey: _signupFormKey,
                      submitted: _signupSubmitted,
                      isLoading: _isLoading,
                      obscurePassword: _obscureSignupPassword,
                      obscureConfirmPassword: _obscureSignupConfirmPassword,
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
                          _obscureSignupPassword = !_obscureSignupPassword;
                        });
                      },
                      onToggleConfirmPassword: () {
                        setState(() {
                          _obscureSignupConfirmPassword =
                              !_obscureSignupConfirmPassword;
                        });
                      },
                    ),
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