import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/localization/app_localizations.dart';
import 'auth_input_field.dart';

class SignupForm extends StatelessWidget {
  final double w;
  final GlobalKey<FormState> formKey;
  final bool submitted;
  final bool isLoading;
  final bool obscurePassword;
  final bool obscureConfirmPassword;
  final Color mainColor;
  final bool isArabic;

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
          _title(tr.translate('your_name')),
          AuthInputField(
            fieldKey: nameKey,
            w: w,
            hint: tr.translate('enter_full_name'),
            icon: Icons.person_outline,
            controller: nameController,
            validator: (value) {
              if (!submitted) return null;
              if (value == null || value.trim().isEmpty) {
                return tr.translate('name_required');
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
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
          const SizedBox(height: 10),
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
          const SizedBox(height: 10),
          _title(tr.translate('confirm_password')),
          AuthInputField(
            fieldKey: confirmKey,
            w: w,
            hint: tr.translate('reenter_password'),
            icon: Icons.lock_outline,
            isPassword: true,
            obscureText: obscureConfirmPassword,
            onToggleObscure: onToggleConfirmPassword,
            controller: confirmController,
            validator: (value) {
              if (!submitted) return null;
              if (value == null || value.isEmpty) {
                return tr.translate('confirm_password_required');
              }
              if (value != passwordController.text) {
                return tr.translate('passwords_not_match');
              }
              return null;
            },
          ),
          const SizedBox(height: 18),
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
                      height: 18,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : Text(
                      tr.translate('signup'),
                      style: TextStyle(
                        fontSize: w * 0.045,
                        color: const Color(0xFF6E5AA6),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}