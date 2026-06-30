import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/localization/app_localizations.dart';

class AuthHeader extends StatelessWidget {
  final double h;
  final double w;
  final double scrollOffset;
  final int tabIndex;
  final Color greenColor;
  final List<AuthParticle> particles;
  final bool isArabic;
  final VoidCallback onLanguageToggle;

  const AuthHeader({
    super.key,
    required this.h,
    required this.w,
    required this.scrollOffset,
    required this.tabIndex,
    required this.greenColor,
    required this.particles,
    required this.isArabic,
    required this.onLanguageToggle,
  });

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context);
    final double headerHeight = h * 0.42;
    final double topInset = MediaQuery.of(context).padding.top;

    return SizedBox(
      height: headerHeight,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: Transform.translate(
              offset: Offset(0, scrollOffset * 0.2),
              child: Container(
                key: ValueKey<int>(tabIndex),
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
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.white.withOpacity(0.88)],
              ),
            ),
          ),
          Positioned(
            top: topInset + 10,
            right: isArabic ? w * 0.04 : null,
            left: isArabic ? null : w * 0.04,
            child: GestureDetector(
              onTap: onLanguageToggle,
              child: Container(
                width: w * 0.10,
                height: w * 0.10,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.language,
                  size: w * 0.05,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
          ...particles.map((p) {
            return Positioned(
              left: p.x * w,
              top: ((p.y + scrollOffset * 0.05) % 1) * headerHeight,
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
            bottom: h * 0.03,
            child: Column(
              children: [
                Hero(
                  tag: 'auth_icon',
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    transitionBuilder: (child, animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: ScaleTransition(scale: animation, child: child),
                      );
                    },
                    child: Container(
                      key: ValueKey<int>(tabIndex),
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
                        tabIndex == 0 ? Icons.location_on : Icons.person_add,
                        size: w * 0.05,
                        color: greenColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  transitionBuilder: (child, animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0.0, 0.5),
                          end: Offset.zero,
                        ).animate(animation),
                        child: child,
                      ),
                    );
                  },
                  child: Text(
                    tabIndex == 0
                        ? tr.translate('discover_fayoum')
                        : tr.translate('create_new_account'),
                    key: ValueKey('${tabIndex}_${isArabic ? "ar" : "en"}'),
                    style: TextStyle(
                      fontSize: w * 0.06,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      shadows: [
                        Shadow(
                          blurRadius: 6,
                          color: Colors.black.withOpacity(0.2),
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AuthParticle {
  double x = Random().nextDouble();
  double y = Random().nextDouble();
  double size = Random().nextDouble() * 6 + 2;
  double opacity = Random().nextDouble() * 0.6 + 0.2;
}