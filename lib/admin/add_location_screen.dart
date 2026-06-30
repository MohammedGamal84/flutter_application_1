import 'package:flutter/material.dart';
import 'package:flutter_application_1/admin/service/admin_service.dart';
import 'package:flutter_application_1/core/auth_storge.dart';

class AddLocationScreen extends StatefulWidget {
  const AddLocationScreen({super.key});

  @override
  State<AddLocationScreen> createState() =>
      _AddLocationScreenState();
}

class _AddLocationScreenState
    extends State<AddLocationScreen> {
  final AdminService _adminService = AdminService();

  final TextEditingController nameController =
      TextEditingController();

  final TextEditingController cityController =
      TextEditingController();

  final TextEditingController countryController =
      TextEditingController();

  bool isLoading = false;

  Future<void> addLocation() async {
    if (nameController.text.isEmpty ||
        cityController.text.isEmpty ||
        countryController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("املأ جميع البيانات"),
        ),
      );

      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final userId = await AuthStorage.getUserId();
      if (userId == null) {
        throw Exception('User ID is missing');
      }

      await _adminService.addLocation(
        userId: userId,
        name: nameController.text,
        city: cityController.text,
        country: countryController.text,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("تم إضافة المكان بنجاح"),
          ),
        );
      }

      nameController.clear();
      cityController.clear();
      countryController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("حدث خطأ: $e"),
        ),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  Widget buildField(
    String title,
    TextEditingController controller,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),

      child: TextField(
        controller: controller,

        decoration: InputDecoration(
          labelText: title,

          prefixIcon: Icon(icon),

          filled: true,
          fillColor: Colors.white,

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),

            borderSide: const BorderSide(
              color: Color(0xff7A8B3A),
              width: 2,
            ),
          ),
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
          "إضافة مكان",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),

        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            const SizedBox(height: 10),

            const Text(
              "أضف مكان سياحي جديد",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xff7A8B3A),
              ),
            ),

            const SizedBox(height: 8),

            Text(
              "أدخل بيانات المكان بالكامل",
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 35),

            buildField(
              "اسم المكان",
              nameController,
              Icons.place,
            ),

            buildField(
              "المدينة",
              cityController,
              Icons.location_city,
            ),

            buildField(
              "الدولة",
              countryController,
              Icons.flag,
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 58,

              child: ElevatedButton(
                onPressed: isLoading ? null : addLocation,

                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color(0xff7A8B3A),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),

                child: isLoading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text(
                        "إضافة المكان",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}