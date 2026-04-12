import 'package:flutter/material.dart';
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
  final bool isArabic;

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
    required this.isArabic,
  });

  Widget _title(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: w * 0.08),
      child: Align(
        alignment: isArabic ? Alignment.centerRight : Alignment.centerLeft,
        child: Text(
          text,
          style: TextStyle(
            fontSize: w * 0.035,
            color: const Color(0xFF202020),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          _title (isArabic ? "البريد الإلكتروني" : "Email"),
          AuthInputField(
            fieldKey: emailKey,
            w: w,
            hint: isArabic ? "أدخل بريدك الإلكتروني" : "Enter your email",
            icon: Icons.email_outlined,
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            isArabic: isArabic,
            validator: (value) {
              if (!submitted) return null;
              if (value == null || value.trim().isEmpty) {
                return isArabic ? "البريد الإلكتروني مطلوب" : "Email is required";
              }
              if (!value.contains('@')) {
                return isArabic ? "البريد الإلكتروني غير صحيح" : "Invalid email";
              }
              return null;
            },
          ),
          const SizedBox(height: 18),
          _title(isArabic ? "كلمة المرور" : "Password"),
          AuthInputField(
            fieldKey: passwordKey,
            w: w,
            hint: isArabic ? "أدخل كلمة المرور" : "Enter your password",
            icon: Icons.lock_outline,
            isPassword: true,
            obscureText: obscurePassword,
            onToggleObscure: onTogglePassword,
            controller: passwordController,
            isArabic: isArabic,
            validator: (value) {
              if (!submitted) return null;
              if (value == null || value.isEmpty) {
                return isArabic ? "كلمة المرور مطلوبة" : "Password is required";
              }
              if (value.length < 6) {
                return isArabic
                    ? "كلمة المرور يجب أن تكون 6 أحرف على الأقل"
                    : "Password must be at least 6 characters";
              }
              return null;
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.08, vertical: 2),
            child: Align(
              alignment: isArabic ? Alignment.centerLeft : Alignment.centerRight,
              child: InkWell(
                onTap: onForgotPassword,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    isArabic ? "نسيت كلمة المرور؟" : "Forgot password?",
                    style: TextStyle(
                      color: greenColor,
                      fontSize: w * 0.030,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: w * 0.91,
            height: 48,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: mainColor,
                elevation: 4,
                shadowColor: Colors.black.withOpacity(0.18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              onPressed: isLoading ? null : onSubmit,
              child: isLoading
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : Text(
                      isArabic ? "تسجيل الدخول" : "Login",
                      style: TextStyle(
                        fontSize: w * 0.045,
                        color: const Color(0xFF6E5AA6),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 18),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.08),
            child: Text(
              isArabic
                  ? "بالمتابعة أنت توافق على الشروط والأحكام وسياسة الخصوصية"
                  : "By continuing, you agree to the Terms & Conditions and Privacy Policy",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: w * 0.030,
                color: const Color(0xFF1F1F1F),
                height: 1.4,
              ),
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}