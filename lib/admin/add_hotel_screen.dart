import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/admin/service/admin_service.dart';
import 'package:flutter_application_1/core/auth_storge.dart';
import 'package:image_picker/image_picker.dart';


class AddHotelScreen extends StatefulWidget {
  const AddHotelScreen({super.key});

  @override
  State<AddHotelScreen> createState() => _AddHotelScreenState();
}

class _AddHotelScreenState extends State<AddHotelScreen> {
  final AdminService _adminService = AdminService();

  final TextEditingController nameController =
      TextEditingController();

  final TextEditingController descriptionController =
      TextEditingController();

  final TextEditingController rateController =
      TextEditingController();

  final TextEditingController priceController =
      TextEditingController();

  final TextEditingController locationController =
      TextEditingController();

  final TextEditingController roomsController =
      TextEditingController();

  final TextEditingController timesController =
      TextEditingController();

  File? imageFile;

  bool isLoading = false;

  Future<void> pickImage() async {
    final picked =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (picked != null) {
      setState(() {
        imageFile = File(picked.path);
      });
    }
  }

  
  Future<void> addHotel() async {
    if (imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("اختر صورة أولاً"),
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

      await _adminService.addHotel(
        userId: userId,

        name: nameController.text,
        description: descriptionController.text,
        rate: rateController.text,
        price: priceController.text,
        location: locationController.text,
        availableRooms: roomsController.text,
        availableTimes: timesController.text,
        imageCover: imageFile!,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("تم إضافة الفندق بنجاح"),
        ),
      );
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
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),

      child: TextField(
        controller: controller,

        decoration: InputDecoration(
          labelText: title,

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("إضافة فندق"),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            GestureDetector(
              onTap: pickImage,

              child: Container(
                width: double.infinity,
                height: 200,

                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(20),
                ),

                child: imageFile != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(20),

                        child: Image.file(
                          imageFile!,
                          fit: BoxFit.cover,
                        ),
                      )
                    : const Icon(
                        Icons.add_a_photo,
                        size: 60,
                      ),
              ),
            ),

            const SizedBox(height: 20),

            buildField("اسم الفندق", nameController),
            buildField("الوصف", descriptionController),
            buildField("التقييم", rateController),
            buildField("السعر", priceController),
            buildField("Location ID", locationController),
            buildField("عدد الغرف", roomsController),
            buildField("المواعيد", timesController),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 55,

              child: ElevatedButton(
                onPressed: isLoading ? null : addHotel,

                child: isLoading
                    ? const CircularProgressIndicator()
                    : const Text(
                        "إضافة الفندق",
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}