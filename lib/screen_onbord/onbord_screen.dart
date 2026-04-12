import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_1/auth/screens/auth_screen.dart';
import 'package:flutter_application_1/models_onbord/onbord_items.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int currentPage = 0;

  final List<OnboardingItem> pages = const [
    OnboardingItem(
      title: 'اكتشف الفيوم',
      subtitle:
          'استمتع بجمال الطبيعة والآثار الفريدة في الفيوم، واكتشف أماكن ساحرة وتجارب لا تُنسى',
      imagePath: 'assets/images/image3.jpg',
    ),
    OnboardingItem(
      title: 'استكشف المعالم',
      subtitle:
          'تعرّف على أشهر المعالم السياحية والأثرية والوجهات المميزة داخل الفيوم بسهولة',
      imagePath: 'assets/images/image2.jpg',
    ),
    OnboardingItem(
      title: 'خطط رحلتك',
      subtitle: 'نظّم زيارتك واحفظ الأماكن المفضلة لديك للوصول إلى تجربة أفضل',
      imagePath: 'assets/images/image4.jpg',
    ),
    OnboardingItem(
      title: 'ابدأ المغامرة',
      subtitle: 'ابدأ الآن واستمتع بتجربة سياحية متكاملة داخل الفيوم',
      imagePath: 'assets/images/image1.jpg',
    ),
  ];

  Future<void> goToAuth() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seenOnboarding', true);

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const AuthScreen()),
    );
  }

  void nextPage() {
    if (currentPage < pages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    } else {
      goToAuth();
    }
  }

  void previousPage() {
    if (currentPage > 0) {
      _controller.previousPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    }
  }

  void skip() {
    goToAuth();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFFCFCFC),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: skip,
                        child: const Text(
                          'تخطي',
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xFF666666),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: screenHeight * 0.62,
                    child: PageView.builder(
                      controller: _controller,
                      itemCount: pages.length,
                      onPageChanged: (value) {
                        setState(() {
                          currentPage = value;
                        });
                      },
                      itemBuilder: (context, index) {
                        final page = pages[index];

                        return Column(
                          children: [
                            Container(
                              width: screenWidth * 0.78,
                              height: screenHeight * 0.34,
                              constraints: const BoxConstraints(
                                minHeight: 220,
                                maxHeight: 320,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF7F7FB),
                                borderRadius: BorderRadius.circular(28),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(28),
                                child: Image.asset(
                                  page.imagePath,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      color: const Color(0xFFF7F7FB),
                                      child: const Center(
                                        child: Icon(
                                          Icons.image_outlined,
                                          size: 70,
                                          color: Color(0xFFB8B8C5),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                page.title,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF4C4C4C),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 34),
                              child: Text(
                                page.subtitle,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 16,
                                  height: 1.7,
                                  color: Color(0xFFA7A7B3),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      pages.length,
                      (index) {
                        final isActive = index == currentPage;
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          width: isActive ? 28 : 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: isActive
                                ? const Color(0xffF36A21)
                                : const Color(0xFFD7D7E0),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 60,
                            child: ElevatedButton(
                              onPressed: nextPage,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xffF36A21),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(22),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    currentPage == pages.length - 1
                                        ? 'ابدأ الآن'
                                        : 'التالي',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  if (currentPage != pages.length - 1) ...[
                                    const SizedBox(width: 10),
                                    const Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: SizedBox(
                            height: 60,
                            child: ElevatedButton(
                              onPressed: previousPage,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFF2F2F6),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(22),
                                ),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.arrow_back_ios_new_rounded,
                                    color: Color(0xFF4C4C4C),
                                    size: 20,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    'السابق',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Color(0xFF4C4C4C),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
