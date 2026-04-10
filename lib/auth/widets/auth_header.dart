import 'dart:math';
import 'package:flutter/material.dart';

class AuthHeader extends StatelessWidget {
  final double h;
  final double w;
  final double scrollOffset;
  final int tabIndex;
  final Color greenColor;
  final List<AuthParticle> particles;

  const AuthHeader({
    super.key,
    required this.h,
    required this.w,
    required this.scrollOffset,
    required this.tabIndex,
    required this.greenColor,
    required this.particles,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: h * 0.35,
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
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    transitionBuilder: (child, animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: ScaleTransition(
                          scale: animation,
                          child: child,
                        ),
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
                        size: w * 0.08,
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
                    tabIndex == 0 ? "اكتشف الفيوم" : "إنشاء حساب جديد",
                    key: ValueKey<int>(tabIndex),
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
  double size = Random().nextDouble() * 4 + 2;
  double opacity = Random().nextDouble() * 0.5 + 0.3;
}