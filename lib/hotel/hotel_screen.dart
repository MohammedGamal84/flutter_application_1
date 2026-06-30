import 'package:flutter/material.dart';
import 'package:flutter_application_1/hotel/hotel_server/hotel_model.dart';
import 'package:flutter_application_1/hotel/hotel_server/hotel_service.dart';

class HotelsPage extends StatefulWidget {
  const HotelsPage({super.key, required String locationId});

  @override
  State<HotelsPage> createState() => _HotelsPageState();
}

class _HotelsPageState extends State<HotelsPage> {
  final HotelService _hotelService = HotelService();

  late Future<List<HotelModel>> hotelsFuture;

  @override
  void initState() {
    super.initState();
    hotelsFuture = _hotelService.getAllHotels();
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
                "الفنادق",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff7A8B3A),
                ),
              ),

              const SizedBox(height: 5),

              const Text(
                "أفضل الفنادق السياحية",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 20),

              Expanded(
                child: FutureBuilder<List<HotelModel>>(
                  future: hotelsFuture,

                  builder: (context, snapshot) {
                    if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                                if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                }

                    final hotels = snapshot.data ?? [];

                    if (hotels.isEmpty) {
                      return const Center(
                        child: Text("لا توجد فنادق"),
                      );
                    }

                    return GridView.builder(
                      itemCount: hotels.length,

                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                        childAspectRatio: 0.72,
                      ),

                      itemBuilder: (context, index) {
                        final hotel = hotels[index];

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => HotelDetailsPage(
                                  hotel: hotel,
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
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,

                              children: [
                                Expanded(
                                  flex: 6,
                                  child: ClipRRect(
                                    borderRadius:
                                        const BorderRadius.vertical(
                                      top: Radius.circular(20),
                                    ),

                                    child: hotel.imageCover.isNotEmpty
                                        ? Image.network(
                                            hotel.imageCover,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                          )
                                        : Container(
                                            color: Colors.grey.shade300,
                                            child: const Icon(
                                              Icons.hotel,
                                              size: 50,
                                              color: Colors.grey,
                                            ),
                                          ),
                                  ),
                                ),

                                Expanded(
                                  flex: 4,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),

                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,

                                      children: [
                                        Text(
                                          hotel.name,
                                          maxLines: 1,
                                          overflow:
                                              TextOverflow.ellipsis,

                                          style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),

                                        const SizedBox(height: 5),

                                        Text(
                                          hotel.description,
                                          maxLines: 2,
                                          overflow:
                                              TextOverflow.ellipsis,

                                          style: TextStyle(
                                            color: Colors.grey.shade600,
                                            fontSize: 13,
                                          ),
                                        ),

                                        const Spacer(),

                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.star,
                                              color: Colors.orange,
                                              size: 18,
                                            ),

                                            const SizedBox(width: 4),

                                            Text(
                                              hotel.rate.toString(),
                                              style: const TextStyle(
                                                fontWeight:
                                                    FontWeight.bold,
                                              ),
                                            ),

                                            const Spacer(),

                                            Text(
                                              "${hotel.price} جنيه",
                                              style: const TextStyle(
                                                color: Color(0xff7A8B3A),
                                                fontWeight:
                                                    FontWeight.bold,
                                              ),
                                            ),
                                          ],
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

class HotelDetailsPage extends StatelessWidget {
  final HotelModel hotel;

  const HotelDetailsPage({
    super.key,
    required this.hotel,
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
          hotel.name,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            hotel.imageCover.isNotEmpty
                ? Image.network(
                    hotel.imageCover,
                    width: double.infinity,
                    height: 280,
                    fit: BoxFit.cover,
                  )
                : Container(
                    height: 280,
                    color: Colors.grey.shade300,
                    child: const Center(
                      child: Icon(
                        Icons.hotel,
                        size: 80,
                        color: Colors.grey,
                      ),
                    ),
                  ),

            Padding(
              padding: const EdgeInsets.all(20),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    hotel.name,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.orange,
                      ),

                      const SizedBox(width: 5),

                      Text(
                        hotel.rate.toString(),
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "الوصف",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    hotel.description,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.7,
                    ),
                  ),

                  const SizedBox(height: 25),

                  Row(
                    children: [
                      const Icon(Icons.hotel),

                      const SizedBox(width: 10),

                      Text(
                        "الغرف المتاحة: ${hotel.availableRooms}",
                        style: const TextStyle(
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  Row(
                    children: [
                      const Icon(Icons.access_time),

                      const SizedBox(width: 10),

                      Text(
                        hotel.availableTimes,
                        style: const TextStyle(
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  Container(
                    width: double.infinity,
                    height: 55,

                    decoration: BoxDecoration(
                      color: const Color(0xff7A8B3A),
                      borderRadius: BorderRadius.circular(15),
                    ),

                    child: Center(
                      child: Text(
                        "${hotel.price} جنيه",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
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