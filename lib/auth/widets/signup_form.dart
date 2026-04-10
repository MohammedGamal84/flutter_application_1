import 'package:flutter/material.dart';
import 'auth_input_field.dart';

class SignupForm extends StatelessWidget {
  final double w;
  final GlobalKey<FormState> formKey;
  final bool submitted;
  final bool isLoading;
  final bool obscurePassword;
  final bool obscureConfirmPassword;
  final Color mainColor;

  final GlobalKey nameKey;
  final GlobalKey emailKey;
  final GlobalKey passwordKey;
  final GlobalKey confirmKey;

  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmController;

  final VoidCallback onSubmit;
  final VoidCallback onTogglePassword;
  final VoidCallback onToggleConfirmPassword;

  const SignupForm({
    super.key,
    required this.w,
    required this.formKey,
    required this.submitted,
    required this.isLoading,
    required this.obscurePassword,
    required this.obscureConfirmPassword,
    required this.mainColor,
    required this.nameKey,
    required this.emailKey,
    required this.passwordKey,
    required this.confirmKey,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmController,
    required this.onSubmit,
    required this.onTogglePassword,
    required this.onToggleConfirmPassword,
  });

  Widget _title(String text, double w) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: w * 0.08),
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          _title("ادخل اسمك", w),
          AuthInputField(
            fieldKey: nameKey,
            w: w,
            hint: "أدخل اسمك الكامل",
            icon: Icons.person_outline,
            controller: nameController,
            validator: (value) {
              if (!submitted) return null;
              if (value == null || value.trim().isEmpty) {
                return "الاسم مطلوب";
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          _title("البريد الإلكتروني", w),
          AuthInputField(
            fieldKey: emailKey,
            w: w,
            hint: "أدخل بريدك الإلكتروني",
            icon: Icons.email_outlined,
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (!submitted) return null;
              if (value == null || value.trim().isEmpty) {
                return "البريد الإلكتروني مطلوب";
              }
              if (!value.contains('@')) {
                return "البريد الإلكتروني غير صحيح";
              }
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
          const SizedBox(height: 15),
          _title("تأكيد كلمة المرور", w),
          AuthInputField(
            fieldKey: confirmKey,
            w: w,
            hint: "أعد إدخال كلمة المرور",
            icon: Icons.lock_outline,
            isPassword: true,
            obscureText: obscureConfirmPassword,
            onToggleObscure: onToggleConfirmPassword,
            controller: confirmController,
            validator: (value) {
              if (!submitted) return null;
              if (value == null || value.isEmpty) {
                return "تأكيد كلمة المرور مطلوب";
              }
              if (value != passwordController.text) {
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
                  : Text(
                      "إنشاء حساب",
                      style: TextStyle(fontSize: w * 0.045),
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