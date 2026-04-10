import 'package:flutter/material.dart';

class AuthInputField extends StatelessWidget {
  final Key? fieldKey;
  final double w;
  final String hint;
  final IconData icon;
  final bool isPassword;
  final bool obscureText;
  final VoidCallback? onToggleObscure;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextInputType? keyboardType;

  const AuthInputField({
    super.key,
    this.fieldKey,
    required this.w,
    required this.hint,
    required this.icon,
    this.isPassword = false,
    this.obscureText = true,
    this.onToggleObscure,
    this.validator,
    this.controller,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: w * 0.06, vertical: 6),
      child: TextFormField(
        key: fieldKey,
        controller: controller,
        validator: validator,
        keyboardType: keyboardType,
        obscureText: isPassword ? obscureText : false,
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon),
          suffixIcon: isPassword
              ? GestureDetector(
                  onTap: onToggleObscure,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (child, animation) {
                      return RotationTransition(
                        turns: Tween(begin: 0.0, end: 0.5).animate(animation),
                        child: ScaleTransition(scale: animation, child: child),
                      );
                    },
                    child: Icon(
                      obscureText
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      key: ValueKey<bool>(obscureText),
                      color: Colors.grey,
                    ),
                  ),
                )
              : null,
          filled: true,
          fillColor: Colors.grey.shade100,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Color(0xffF36A21), width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.red, width: 2),
          ),
        ),
      ),
    );
  }
}