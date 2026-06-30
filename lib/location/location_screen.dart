import 'package:flutter/material.dart';
import 'package:flutter_application_1/hotel/hotel_screen.dart';
import 'package:flutter_application_1/location/location_serv/location_model.dart';
import 'package:flutter_application_1/location/location_serv/location_server.dart';

class LocationsPage extends StatefulWidget {
  const LocationsPage({super.key});

  @override
  State<LocationsPage> createState() => _LocationsPageState();
}

class _LocationsPageState extends State<LocationsPage> {
  final LocationService _locationService = LocationService();

  late Future<List<LocationModel>> locationsFuture;

  @override
  void initState() {
    super.initState();
    locationsFuture = _locationService.getAllLocations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F5EE),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              const Text(
                "الأماكن السياحية",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff7A8B3A),
                ),
              ),

              const SizedBox(height: 5),

              const Text(
                "استكشف أجمل الأماكن",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 20),

              Expanded(
                child: FutureBuilder<List<LocationModel>>(
                  future: locationsFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (snapshot.hasError) {
                      return const Center(
                        child: Text("حدث خطأ"),
                      );
                    }

                    final locations = snapshot.data ?? [];

                    if (locations.isEmpty) {
                      return const Center(
                        child: Text("لا توجد أماكن متاحة"),
                      );
                    }

                    return GridView.builder(
                      itemCount: locations.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                        childAspectRatio: 0.65,
                      ),
                      itemBuilder: (context, index) {
                        final location = locations[index];

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => LocationDetailsPage(
                                  location: location,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.08),
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 6,
                                  child: ClipRRect(
                                    borderRadius:
                                        const BorderRadius.vertical(
                                      top: Radius.circular(20),
                                    ),
                                    child: Container(
                                      width: double.infinity,
                                      color: const Color(0xffDDE3C2),
                                      child: const Icon(
                                        Icons.place,
                                        size: 70,
                                        color: Color(0xff7A8B3A),
                                      ),
                                    ),
                                  ),
                                ),

                                Expanded(
                                  flex: 4,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          location.name,
                                          maxLines: 1,
                                          overflow:
                                              TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),

                                        const SizedBox(height: 10),

                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.location_on,
                                              color: Colors.red,
                                              size: 18,
                                            ),

                                            const SizedBox(width: 5),

                                            Expanded(
                                              child: Text(
                                                "${location.city} - ${location.country}",
                                                maxLines: 1,
                                                overflow:
                                                    TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color:
                                                      Colors.grey.shade700,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                        const SizedBox(height: 8),

                                        Container(
                                          width: double.infinity,
                                          height: 38,
                                          decoration: BoxDecoration(
                                            color:
                                                const Color(0xff7A8B3A),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: const Center(
                                            child: Text(
                                              "عرض التفاصيل",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight:
                                                    FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LocationDetailsPage extends StatelessWidget {
  final LocationModel location;

  const LocationDetailsPage({
    super.key,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F5EE),

      appBar: AppBar(
        backgroundColor: const Color(0xffF7F5EE),
        elevation: 0,
        centerTitle: true,

        title: Text(
          location.name,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),

        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Container(
              width: double.infinity,
              height: 300,
              color: const Color(0xffDDE3C2),

              child: const Center(
                child: Icon(
                  Icons.place,
                  size: 100,
                  color: Color(0xff7A8B3A),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    location.name,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    children: [
                      const Icon(
                        Icons.location_city,
                        color: Color(0xff7A8B3A),
                      ),

                      const SizedBox(width: 10),

                      Text(
                        location.city,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  Row(
                    children: [
                      const Icon(
                        Icons.flag,
                        color: Colors.orange,
                      ),

                      const SizedBox(width: 10),

                      Text(
                        location.country,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    "نبذة عن المكان",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 15),

                  Text(
                    "${location.name} من أشهر الأماكن السياحية الموجودة في ${location.city} داخل ${location.country}.",
                    style: const TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 40),
                  GestureDetector(
  onTap: () {

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => HotelsPage(
          locationId: location.id,
        ),
      ),
    );

  },

  child: Container(
    width: double.infinity,
    height: 55,

    decoration: BoxDecoration(
      color: const Color(0xff7A8B3A),
      borderRadius: BorderRadius.circular(15),
    ),

    child: const Center(
      child: Text(
        "استكشف المكان",
        style: TextStyle(
          color: Colors.white,
          fontSize: 19,
          fontWeight: FontWeight.bold,
        ),
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
    );
  }
}