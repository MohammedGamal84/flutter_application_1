import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/localization/app_localizations.dart';
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
    final tr = AppLocalizations.of(context);

    return Form(
      key: formKey,
      child: Column(
        children: [
          _title(tr.translate('email')),
          AuthInputField(
            fieldKey: emailKey,
            w: w,
            hint: tr.translate('enter_email'),
            icon: Icons.email_outlined,
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (!submitted) return null;
              if (value == null || value.trim().isEmpty) {
                return tr.translate('email_required');
              }
              if (!value.contains('@')) {
                return tr.translate('invalid_email');
              }
              return null;
            },
          ),
          const SizedBox(height: 18),
          _title(tr.translate('password')),
          AuthInputField(
            fieldKey: passwordKey,
            w: w,
            hint: tr.translate('enter_password'),
            icon: Icons.lock_outline,
            isPassword: true,
            obscureText: obscurePassword,
            onToggleObscure: onTogglePassword,
            controller: passwordController,
            validator: (value) {
              if (!submitted) return null;
              if (value == null || value.isEmpty) {
                return tr.translate('password_required');
              }
              if (value.length < 6) {
                return tr.translate('password_short');
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
                    tr.translate('forgot_password'),
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
                      tr.translate('login'),
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
              tr.translate('terms_text'),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: w * 0.030,
                color: Colors.grey.shade600,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}