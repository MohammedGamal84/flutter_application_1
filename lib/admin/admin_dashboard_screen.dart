import 'package:flutter/material.dart';
import 'package:flutter_application_1/admin/add_home_screen.dart';
import 'package:flutter_application_1/core/auth_storge.dart';

import 'add_hotel_screen.dart';
import 'add_location_screen.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() =>
      _AdminDashboardScreenState();
}

class _AdminDashboardScreenState
    extends State<AdminDashboardScreen> {

  @override
  void initState() {
    super.initState();

    _checkAdminAccess();
  }

  Future<void> _checkAdminAccess() async {

    final role = await AuthStorage.getRole();

    print("ADMIN ROLE = $role");

    if (role != "admin") {

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("ليس لديك صلاحية للدخول"),
        ),
      );

      Navigator.pushReplacementNamed(
        context,
        "/home",
      );
    }
  }

  Widget buildCard({
    required BuildContext context,
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 60,
              color: const Color(0xff7A8B3A),
            ),

            const SizedBox(height: 15),

            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xffF7F5EE),

      appBar: AppBar(
        backgroundColor: const Color(0xffF7F5EE),
        elevation: 0,
        centerTitle: true,

        title: const Text(
          "لوحة التحكم",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,

          children: [

            buildCard(
              context: context,
              title: "إضافة فندق",
              icon: Icons.hotel,
              onTap: () {

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const AddHotelScreen(),
                  ),
                );
              },
            ),

            buildCard(
              context: context,
              title: "إضافة موقع",
              icon: Icons.location_on,
              onTap: () {

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const AddLocationScreen(),
                  ),
                );
              },
            ),
            buildCard(
  context: context,
  title: "إضافة مكان سياحي",
  icon: Icons.place,
  onTap: () {

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
        const AddHomeScreen(),
      ),
    );
  },
),
          ],
        ),
      ),
    );
  }
}