import 'package:flutter/material.dart';
import 'package:flutter_application_1/home/home_model/home_model.dart';
import 'package:flutter_application_1/home/home_model/imege_helper.dart';
import 'package:flutter_application_1/home/server_home/home_server.dart';
import 'package:flutter_application_1/core/localization/app_language.dart';
import 'package:flutter_application_1/core/localization/app_localizations.dart';
import 'package:provider/provider.dart';

class HomeDetailsScreen extends StatefulWidget {
  final String homeId;

  const HomeDetailsScreen({
    super.key,
    required this.homeId,
  });

  @override
  State<HomeDetailsScreen> createState() => _HomeDetailsScreenState();
}

class _HomeDetailsScreenState extends State<HomeDetailsScreen> {
  final HomeService _homeService = HomeService();
  late Future<HomeModel> homeFuture;

  @override
  void initState() {
    super.initState();
    homeFuture = _homeService.getHomeById(widget.homeId);
  }

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context);
    final isArabic = context.watch<AppLanguage>().locale.languageCode == 'ar';

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder<HomeModel>(
          future: homeFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(
                child: Text(
                  "${tr.translate('error')}: ${snapshot.error}",
                  textAlign: TextAlign.center,
                ),
              );
            }

            if (!snapshot.hasData) {
              return Center(
                child: Text(
                  tr.translate('no_data'),
                  textAlign: TextAlign.center,
                ),
              );
            }

            final home = snapshot.data!;
            final imageUrl = ImageHelper.getFullImageUrl(home.imageCover);

            return Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment:
                        isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          imageUrl.isNotEmpty
                              ? Image.network(
                                  imageUrl,
                                  height: 340,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => Container(
                                    height: 340,
                                    color: Colors.grey.shade300,
                                    child: const Center(
                                      child: Icon(Icons.image, size: 60),
                                    ),
                                  ),
                                )
                              : Container(
                                  height: 340,
                                  color: Colors.grey.shade300,
                                  child: const Center(
                                    child: Icon(Icons.image, size: 60),
                                  ),
                                ),
                          Positioned(
                            top: 40,
                            right: isArabic ? 20 : null,
                            left: isArabic ? null : 20,
                            child: _circleButton(Icons.favorite_border),
                          ),
                          Positioned(
                            top: 40,
                            right: isArabic ? 80 : null,
                            left: isArabic ? null : 80,
                            child: _circleButton(Icons.share_outlined),
                          ),
                          Positioned(
                            top: 40,
                            left: isArabic ? 20 : null,
                            right: isArabic ? null : 20,
                            child: GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: _circleButton(Icons.close),
                            ),
                          ),
                          Positioned(
                            bottom: 20,
                            left: isArabic ? 20 : null,
                            right: isArabic ? null : 20,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                textDirection: isArabic
                                    ? TextDirection.rtl
                                    : TextDirection.ltr,
                                children: [
                                  const Text(
                                    "(245)",
                                    style: TextStyle(
                                      color: Color(0xff7F8796),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  const Icon(
                                    Icons.star,
                                    color: Color(0xff7A9A1F),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    home.rate.toStringAsFixed(1),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment:
                              isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                          children: [
                            Text(
                              home.title,
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                color: Color(0xff7A9A1F),
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              tr.translate('nature'),
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                color: Color(0xff2F3B52),
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 24),
                            Row(
                              textDirection:
                                  isArabic ? TextDirection.rtl : TextDirection.ltr,
                              children: [
                                Expanded(
                                  child: _infoBox(
                                    icon: Icons.access_time,
                                    title: tr.translate('duration'),
                                    value: tr.translate('full_day'),
                                    iconColor: const Color(0xff7A9A1F),
                                    bg: const Color(0xffF4F5EC),
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: _infoBox(
                                    icon: Icons.location_on_outlined,
                                    title: tr.translate('location'),
                                    value: home.location.isEmpty
                                        ? "Fayoum"
                                        : home.location,
                                    iconColor: Colors.blue,
                                    bg: const Color(0xffEEF5FF),
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: _infoBox(
                                    icon: Icons.attach_money,
                                    title: tr.translate('price'),
                                    value: "${home.price.toInt()}",
                                    iconColor: Colors.green,
                                    bg: const Color(0xffEAF6EF),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 30),
                            Align(
                              alignment: AlignmentDirectional.centerStart,
                              child: Text(
                                tr.translate('about_place'),
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                  color: Color(0xff7A9A1F),
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              home.description,
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                fontSize: 18,
                                color: Color(0xff22304C),
                                height: 1.8,
                              ),
                            ),
                            const SizedBox(height: 30),
                            Align(
                              alignment: AlignmentDirectional.centerStart,
                              child: Text(
                                tr.translate('top_features'),
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                  color: Color(0xff7A9A1F),
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            if (home.features.isEmpty)
                              Text(
                                tr.translate('no_data'),
                                textAlign: TextAlign.start,
                                style: const TextStyle(fontSize: 18),
                              )
                            else
                              ...home.features.map(
                                (feature) => Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Row(
                                    textDirection: isArabic
                                        ? TextDirection.rtl
                                        : TextDirection.ltr,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Icon(
                                        Icons.circle,
                                        size: 8,
                                        color: Color(0xff7A9A1F),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          feature,
                                          textAlign: TextAlign.start,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            color: Color(0xff22304C),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            const SizedBox(height: 120),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 16,
                  left: 16,
                  bottom: 20,
                  child: SizedBox(
                    height: 58,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff7A9A1F),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {},
                      icon: const Icon(
                        Icons.calendar_today_outlined,
                        color: Colors.white,
                      ),
                      label: Text(
                        tr.translate('book_now'),
                        style: const TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _circleButton(IconData icon) {
    return Container(
      width: 48,
      height: 48,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: const Color(0xff2F3B52)),
    );
  }

  Widget _infoBox({
    required IconData icon,
    required String title,
    required String value,
    required Color iconColor,
    required Color bg,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, color: iconColor, size: 28),
          const SizedBox(height: 10),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xff2F3B52),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}