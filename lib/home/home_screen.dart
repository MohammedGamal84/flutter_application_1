import 'package:flutter/material.dart';
import 'package:flutter_application_1/home/home_model/home_model.dart';
import 'package:flutter_application_1/home/home_model/imege_helper.dart';
import 'package:flutter_application_1/home/screens_home/home_details_screen.dart';
import 'package:flutter_application_1/home/server_home/home_server.dart';
import 'package:flutter_application_1/core/localization/app_language.dart';
import 'package:flutter_application_1/core/localization/app_localizations.dart';
import 'package:flutter_application_1/hotel/hotel_screen.dart';
import 'package:flutter_application_1/location/location_screen.dart';
import 'package:provider/provider.dart';

class HomesScreen extends StatefulWidget {
  const HomesScreen({super.key});

  @override
  State<HomesScreen> createState() => _HomesScreenState();
}

class _HomesScreenState extends State<HomesScreen> {
  final HomeService _homeService = HomeService();
  late Future<List<HomeModel>> homesFuture;

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    homesFuture = _homeService.getAllHomes();
  }

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context);
    final isArabic =
        context.watch<AppLanguage>().locale.languageCode == 'ar';

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: const Color(0xffF6F2E6),

        // 🔥 هنا التغيير الأساسي
        body: IndexedStack(
          index: _currentIndex,
          children: [
            _buildHomeContent(context, tr, isArabic),
            const LocationsPage(),
            const Center(child: Text("Map Page")),
            const HotelsPage(locationId: '',),
            const Center(child: Text("Profile Page")),
          ],
        ),

        bottomNavigationBar: _buildBottomNav(tr, isArabic),
      ),
    );
  }

  // 🔥 محتوى الصفحة الرئيسية
  Widget _buildHomeContent(
      BuildContext context, AppLocalizations tr, bool isArabic) {
    return SafeArea(
      child: Column(
        children: [
          _buildTopBar(context, tr, isArabic),
          Expanded(
            child: FutureBuilder<List<HomeModel>>(
              future: homesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text("${tr.translate('error')}: ${snapshot.error}"),
                  );
                }

                final homes = snapshot.data ?? [];

                if (homes.isEmpty) {
                  return Center(child: Text(tr.translate('no_places')));
                }

                return ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    const SizedBox(height: 8),
                    Text(
                      tr.translate('tourist_places'),
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff7A9A1F),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      tr.translate('explore_best_places'),
                      style: const TextStyle(
                        fontSize: 18,
                        color: Color(0xff2F3B52),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildCategoryTabs(tr, isArabic),
                    const SizedBox(height: 20),
                    ...homes.map(
                      (home) => _buildHomeCard(home, tr, isArabic),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // 🔥 Top Bar
  Widget _buildTopBar(
      BuildContext context, AppLocalizations tr, bool isArabic) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Column(
            crossAxisAlignment:
                isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    tr.translate('discover_fayoum'),
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff7A9A1F),
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.location_on_outlined,
                      color: Color(0xff7A9A1F)),
                ],
              ),
              Text(
                tr.translate('tourist_guide'),
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xff8A8F9B),
                ),
              ),
            ],
          ),
          const Spacer(),
          PopupMenuButton<String>(
            icon: const Icon(Icons.language),
            onSelected: (value) {
              context.read<AppLanguage>().changeLanguage(value);
            },
            itemBuilder: (context) => [
              PopupMenuItem(value: 'ar', child: Text(tr.translate('arabic'))),
              PopupMenuItem(value: 'en', child: Text(tr.translate('english'))),
            ],
          ),
          const SizedBox(width: 10),
          const Icon(Icons.notifications_none),
        ],
      ),
    );
  }

  // 🔥 Bottom Navigation (مهم)
  Widget _buildBottomNav(AppLocalizations tr, bool isArabic) {
    return Container(
      height: 88,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavItem(
            icon: Icons.home_outlined,
            label: tr.translate('home'),
            active: _currentIndex == 0,
            onTap: () => setState(() => _currentIndex = 0),
          ),
          _NavItem(
            icon: Icons.location_on_outlined,
            label: tr.translate('places'),
            active: _currentIndex == 1,
            onTap: () => setState(() => _currentIndex = 1),
          ),
          _NavItem(
            icon: Icons.map_outlined,
            label: tr.translate('map'),
            active: _currentIndex == 2,
            onTap: () => setState(() => _currentIndex = 2),
          ),
          _NavItem(
            icon: Icons.apartment_outlined,
            label: tr.translate('hotels'),
            active: _currentIndex == 3,
            onTap: () => setState(() => _currentIndex = 3),
          ),
          _NavItem(
            icon: Icons.person_outline,
            label: tr.translate('my_account'),
            active: _currentIndex == 4,
            onTap: () => setState(() => _currentIndex = 4),
          ),
        ],
      ),
    );
  }

  // 🔥 Nav Item بعد التعديل
  Widget _NavItem({
    required IconData icon,
    required String label,
    bool active = false,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: active ? const Color(0xffEEF1E4) : Colors.transparent,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: active
                  ? const Color(0xff7A9A1F)
                  : const Color(0xff7F8796),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: active
                    ? const Color(0xff7A9A1F)
                    : const Color(0xff7F8796),
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // باقي الكود (cards + categories) زي ما هو عندك بدون تغيير
  Widget _buildCategoryTabs(AppLocalizations tr, bool isArabic) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _chip(tr.translate('all'), true),
          const SizedBox(width: 10),
          _chip(tr.translate('nature'), false),
          const SizedBox(width: 10),
          _chip(tr.translate('history'), false),
          const SizedBox(width: 10),
          _chip(tr.translate('adventure'), false),
        ],
      ),
    );
  }

  Widget _chip(String text, bool active) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
      decoration: BoxDecoration(
        color: active ? Colors.orange : const Color(0xffF4F5F7),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Text(text),
    );
  }

  Widget _buildHomeCard(
      HomeModel home, AppLocalizations tr, bool isArabic) {
    final imageUrl = ImageHelper.getFullImageUrl(home.imageCover);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => HomeDetailsScreen(homeId: home.id),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          children: [
            Image.network(imageUrl,
                height: 200, width: double.infinity, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(home.title),
            ),
          ],
        ),
      ),
    );
  }
}