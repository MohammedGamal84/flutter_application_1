import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth/screens/auth_screen.dart';
import 'package:flutter_application_1/core/localization/app_language.dart';
import 'package:flutter_application_1/core/localization/app_localizations.dart';
import 'package:flutter_application_1/models_onbord/onbord_items.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int currentPage = 0;

  Future<void> goToAuth() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seenOnboarding', true);

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const AuthScreen()),
    );
  }

  void nextPage(int length) {
    if (currentPage < length - 1) {
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
    final tr = AppLocalizations.of(context);
    final isArabic = context.watch<AppLanguage>().locale.languageCode == 'ar';

    final List<OnboardingItem> pages = const [
      OnboardingItem(
        titleKey: 'onboarding_title_1',
        subtitleKey: 'onboarding_subtitle_1',
        imagePath: 'assets/images/image3.jpg',
      ),
      OnboardingItem(
        titleKey: 'onboarding_title_2',
        subtitleKey: 'onboarding_subtitle_2',
        imagePath: 'assets/images/image2.jpg',
      ),
      OnboardingItem(
        titleKey: 'onboarding_title_3',
        subtitleKey: 'onboarding_subtitle_3',
        imagePath: 'assets/images/image4.jpg',
      ),
      OnboardingItem(
        titleKey: 'onboarding_title_4',
        subtitleKey: 'onboarding_subtitle_4',
        imagePath: 'assets/images/image1.jpg',
      ),
    ];

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
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
                      alignment: AlignmentDirectional.centerStart,
                      child: TextButton(
                        onPressed: skip,
                        child: Text(
                          tr.translate('skip'),
                          style: const TextStyle(
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
                                tr.translate(page.titleKey),
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
                                tr.translate(page.subtitleKey),
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
                      textDirection:
                          isArabic ? TextDirection.rtl : TextDirection.ltr,
                      children: [
                        if (currentPage > 0)
                          Expanded(
                            child: SizedBox(
                              height: 60,
                              child: OutlinedButton(
                                onPressed: previousPage,
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(
                                    color: Color(0xffF36A21),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(22),
                                  ),
                                ),
                                child: Text(
                                  tr.translate('skip'),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Color(0xffF36A21),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        if (currentPage > 0) const SizedBox(width: 16),
                        Expanded(
                          child: SizedBox(
                            height: 60,
                            child: ElevatedButton(
                              onPressed: () => nextPage(pages.length),
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
                                        ? tr.translate('start_now')
                                        : tr.translate('next'),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  if (currentPage != pages.length - 1) ...[
                                    const SizedBox(width: 10),
                                    Icon(
                                      isArabic
                                          ? Icons.arrow_back_ios_new_rounded
                                          : Icons.arrow_forward_ios_rounded,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}