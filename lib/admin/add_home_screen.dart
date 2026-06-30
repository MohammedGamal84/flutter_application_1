import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/admin/service/admin_service.dart';
import 'package:flutter_application_1/core/auth_storge.dart';
import 'package:image_picker/image_picker.dart';

class AddHomeScreen extends StatefulWidget {
  const AddHomeScreen({super.key});

  @override
  State<AddHomeScreen> createState() =>
      _AddHomeScreenState();
}

class _AddHomeScreenState
    extends State<AddHomeScreen> {

  final AdminService _adminService =
  AdminService();

  final titleController =
  TextEditingController();

  final descriptionController =
  TextEditingController();

  final rateController =
  TextEditingController();

  final priceController =
  TextEditingController();

  final locationController =
  TextEditingController();

  final featuresController =
  TextEditingController();

  File? imageFile;

  bool isLoading = false;

  Future<void> pickImage() async {

    final picked = await ImagePicker()
        .pickImage(
      source: ImageSource.gallery,
    );

    if (picked != null) {

      setState(() {

        imageFile = File(picked.path);
      });
    }
  }

  Future<void> addHome() async {

    if (imageFile == null) {

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text("اختر صورة"),
        ),
      );

      return;
    }

    setState(() {

      isLoading = true;
    });

    try {

      final userId =
      await AuthStorage.getUserId();

      await _adminService.addHome(

        userId: userId!,

        title: titleController.text,

        description:
        descriptionController.text,

        rate: rateController.text,

        price: priceController.text,

        location: locationController.text,

        features:
        featuresController.text,

        imageCover: imageFile!,
      );

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content:
          Text("تم إضافة المكان بنجاح"),
        ),
      );

      titleController.clear();

      descriptionController.clear();

      rateController.clear();

      priceController.clear();

      locationController.clear();

      featuresController.clear();

      setState(() {

        imageFile = null;
      });

    } catch (e) {

      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text("$e"),
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
      padding:
      const EdgeInsets.only(bottom: 15),

      child: TextField(

        controller: controller,

        decoration: InputDecoration(

          labelText: title,

          border: OutlineInputBorder(
            borderRadius:
            BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title:
        const Text("إضافة مكان سياحي"),
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

                  borderRadius:
                  BorderRadius.circular(20),
                ),

                child: imageFile != null

                    ? ClipRRect(

                  borderRadius:
                  BorderRadius.circular(20),

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

            buildField(
              "العنوان",
              titleController,
            ),

            buildField(
              "الوصف",
              descriptionController,
            ),

            buildField(
              "التقييم",
              rateController,
            ),

            buildField(
              "السعر",
              priceController,
            ),

            buildField(
              "Location ID",
              locationController,
            ),

            buildField(
              "المميزات",
              featuresController,
            ),

            const SizedBox(height: 25),

            SizedBox(

              width: double.infinity,
              height: 55,

              child: ElevatedButton(

                onPressed:
                isLoading
                    ? null
                    : addHome,

                child: isLoading

                    ? const CircularProgressIndicator()

                    : const Text(
                  "إضافة المكان",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}