import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth/screens/forgot_password_screen.dart';
import 'auth_input_field.dart';

class LoginForm extends StatelessWidget {
  final double w;
  final double h;
  final GlobalKey<FormState> formKey;
  final bool submitted;
  final bool isLoading;
  final bool obscurePassword;
  final Color mainColor;
  final Color greenColor;

  final GlobalKey emailKey;
  final GlobalKey passwordKey;

  final TextEditingController emailController;
  final TextEditingController passwordController;

  final VoidCallback onSubmit;
  final VoidCallback onTogglePassword;
  final VoidCallback onForgotPassword;

  const LoginForm({
    super.key,
    required this.w,
    required this.h,
    required this.formKey,
    required this.submitted,
    required this.isLoading,
    required this.obscurePassword,
    required this.mainColor,
    required this.greenColor,
    required this.emailKey,
    required this.passwordKey,
    required this.emailController,
    required this.passwordController,
    required this.onSubmit,
    required this.onTogglePassword,
    required this.onForgotPassword,
  });

  Widget _title(String text, double w) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: w * 0.08),
      child: Align(alignment: Alignment.centerRight, child: Text(text)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          _title("البريد الإلكتروني", w),
          AuthInputField(
            fieldKey: emailKey,
            w: w,
            hint: "أدخل بريدك الإلكتروني",
            icon: Icons.email_outlined,
            controller: emailController,
            validator: (value) {
              if (!submitted) return null;
              if (value == null || value.isEmpty) {
                return "البريد الإلكتروني مطلوب";
              }
              if (!value.contains('@')) return "البريد الإلكتروني غير صحيح";
              return null;
            },
          ),
          const SizedBox(height: 15),
          _title("كلمة المرور", w),
          AuthInputField(
            fieldKey: passwordKey,
            w: w,
            hint: "أدخل كلمة المرور",
            icon: Icons.lock_outline,
            isPassword: true,
            obscureText: obscurePassword,
            onToggleObscure: onTogglePassword,
            controller: passwordController,
            validator: (value) {
              if (!submitted) return null;
              if (value == null || value.isEmpty) {
                return "كلمة المرور مطلوبة";
              }
              if (value.length < 6) {
                return "كلمة المرور يجب أن تكون 6 أحرف على الأقل";
              }
              return null;
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.08, vertical: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ForgotPasswordScreen(),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 6,
                  ),
                  child: Text(
                    "نسيت كلمة المرور؟",
                    style: TextStyle(
                      color: greenColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
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
              onPressed: isLoading ? null : onSubmit,
              child: isLoading
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Text("تسجيل الدخول", style: TextStyle(fontSize: w * 0.045)),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: w * 0.9,
            height: h * 0.050,
            child: OutlinedButton.icon(
              icon: const Icon(Icons.person_outline),
              label: const Text("الدخول كزائر"),
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                backgroundColor: mainColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.08),
            child: const Text(
              "بالمتابعة أنت توافق على الشروط والأحكام وسياسة الخصوصية",
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
